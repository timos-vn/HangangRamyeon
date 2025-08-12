import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:hangangramyeon/core/utils/debouncer.dart';
import 'package:hangangramyeon/core/utils/utils.dart';
import 'package:hangangramyeon/core/widgets/app_circular_indicator.dart';
import 'package:hangangramyeon/core/widgets/app_textfield.dart';
import 'package:hangangramyeon/features/auth/presentation/widgets/barcode_scanner_widget.dart';
import 'package:hangangramyeon/features/home/blocs/home_cubit.dart';
import 'package:hangangramyeon/features/home/blocs/home_state.dart';
import 'package:hangangramyeon/features/home/models/add_promotion_to_order_model_request.dart';
import 'package:hangangramyeon/features/home/models/add_promotion_to_order_model_response.dart';
import 'package:hangangramyeon/features/home/models/check_voucher_model_request.dart';
import 'package:hangangramyeon/features/home/models/production_detail_model.dart';
import 'package:hangangramyeon/features/home/models/request/create_order_request.dart';
import 'package:hangangramyeon/features/home/models/request/update_order_request.dart';
import 'package:hangangramyeon/features/home/models/response/detail_transaction_response.dart';
import 'package:hangangramyeon/features/voucher/models/check_promotion_model_response.dart';
import 'package:hangangramyeon/features/voucher/models/common_detail.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:hangangramyeon/core/services/shared_prefs_service.dart';
import 'package:hangangramyeon/core/di/dependency_injection.dart';
import 'package:hangangramyeon/core/services/receipt_printer_service.dart' as printer;
import 'package:hangangramyeon/core/services/bill_preview_service.dart';
import 'package:hangangramyeon/core/widgets/bill_preview_widget.dart';
import 'package:vibration/vibration.dart';

class ScanCheckoutScreen extends StatefulWidget {
  const ScanCheckoutScreen({super.key, this.isUpdateOrder, this.detailTransactionData});

  final bool? isUpdateOrder;
  final DetailTransactionData? detailTransactionData;

  @override
  State<ScanCheckoutScreen> createState() => _ScanCheckoutScreenState();
}

class _ScanCheckoutScreenState extends State<ScanCheckoutScreen> {
  List<ProductionDetailData> scannedProducts = [];
  String? selectedCustomerCode;
  double discountAmount = 0.0;
  final nameCustomerController = TextEditingController();final nameCustomerFocus = FocusNode();
  String voucherSelectedName = '';
  String voucherSelectedId = '';
  List<String> listPromotion = [];
  String idCustomer = '';
  @override
  void initState() {
    super.initState();
    // Auto-bind current user as selected customer
    selectedCustomerCode = Const.userId;
    nameCustomerController.text = Const.userName;
    if(widget.isUpdateOrder == true){
      discountAmount = widget.detailTransactionData?.discount??0;
      selectedCustomerCode = widget.detailTransactionData?.customerId??"";
      nameCustomerController.text = widget.detailTransactionData?.buyerName??"";
      addMissingFromBtoA(listA: scannedProducts, listB: widget.detailTransactionData?.details??[]);
    }
  }

  final Debounce onSearchDebounce =  Debounce(delay:  const Duration(milliseconds: 1000));

  ///chiet khau nhap tay
  double changeDisCount = 0;
  double changeDisCountValue = 0;
  int changeDisCountType = 0;

  int diemKH = 0;
  bool isUserPoint = false;

  void handleScan(ProductionDetailData item) {
    setState(() {
      final existing = scannedProducts.indexWhere((p) => p.code == item.code);
      if (existing != -1) {
        final updatedItem = scannedProducts[existing]
            .copyWith(quantity: scannedProducts[existing].quantity + 1);
        scannedProducts[existing] = updatedItem;
      } else {
        scannedProducts.add(item.copyWith(quantity: 1));
      }
    });
  }


  double get totalPrice => scannedProducts.fold(
    0,
        (sum, item) => sum + item.quantity * item.salePrice,
  );

  double get finalAmount => totalPrice - discountAmount;

  void _showCustomerSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SizedBox(
        height: 200,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text("Quét mã QR khách hàng"),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  builder: (bottomSheetContext) => SizedBox(
                    height: 300,
                    child: BarcodeScannerWidget(
                      onBarcodeDetected: (values) async {
                        if ((await Vibration.hasVibrator())) {
                          Vibration.vibrate();
                        }
                        // Trả về barcode và đóng popup
                        setState(() {
                          selectedCustomerCode = values;
                          nameCustomerController.text = values; // fallback if QR includes name
                        });
                        Navigator.of(bottomSheetContext, rootNavigator: true).pop();
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text("Tìm kiếm khách hàng"),
              onTap: () {
                Navigator.pop(context);
                _showCustomerSearchDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomerSearchDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Tìm khách hàng"),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Nhập tên hoặc SĐT",
                  ),
                  onChanged: (value) => onSearchDebounce.debounce(
                        () {
                      context.read<HomeCubit>().searchCustomer(value);
                    },
                  ),
                ),
                const SizedBox(height: 10),

                // BlocBuilder để hiển thị danh sách
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is SearchCustomerSuccess) {
                      final customers = state.infoCustomer.data.items;

                      if (customers.isEmpty) {
                        return const Text("Không tìm thấy khách hàng nào, bạn có thể nhập tên KH tại đây",style: TextStyle(color: Colors.black,fontSize: 12.5),);
                      }
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: customers.length,
                          itemBuilder: (context, index) {
                            final customer = customers[index];
                            return ListTile(
                              title: Text("${customer.code} - ${customer.name}"),
                              subtitle: Text(customer.phoneNumber.toString()),
                              onTap: () {
                                setState(() {
                                  selectedCustomerCode = customer.id.toString();
                                  nameCustomerController.text = customer.name.toString();
                                  diemKH = customer.point??0;
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      );
                    } else if (state is HomeLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is HomeError) {
                      return Text("Lỗi: ${state.message}");
                    } else {
                      return const SizedBox.shrink(); // default
                    }
                  },
                ),

              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Huỷ'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  nameCustomerController.text = controller.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );
  }


  List<CommonDetail> mapToCheckProductionDetails(List<ProductionDetailData> items) {
    return items.map((item) {
      final int quantity = item.quantity;
      final double salePriceDouble = item.salePrice;
      // final int salePrice = salePriceDouble.round(); // hoặc .floor()/.toInt() tùy chính sách làm tròn

      final double total = quantity * salePriceDouble;

      return CommonDetail(
        productId: item.id,
        quantity: quantity,
        salePrice: salePriceDouble,//salePrice,
        total: total,
      );
    }).toList();
  }

  List<AddPromotionDetail> mapToAddPromotionToOrderDetails(List<ProductionDetailData> items) {
    return items.map((item) {
      final int quantity = item.quantity;
      final double salePriceDouble = item.salePrice;
      final double salePrice = salePriceDouble;//.round(); // hoặc .floor()/.toInt() tùy chính sách làm tròn

      return AddPromotionDetail(
        productId: item.id,
        quantity: quantity,
        salePrice: salePrice,
      );
    }).toList();
  }

  void addMissingFromBtoA({
    required List<ProductionDetailData> listA,
    required List<DetailTransactionItem> listB,
  }) {
    // Lấy danh sách id đã có trong listA
    final existingIds = listA.map((e) => e.id).toSet();

    for (final b in listB) {
      if (!existingIds.contains(b.productId)) {
        final newItem = ProductionDetailData(
          id: b.productId,
          code: '', // nếu cần map từ nguồn khác
          name: b.productName.toString(),
          categoryId: '',
          categoryName: '',
          weight: 0,
          unit: '',
          manufactureDate: DateTime.now(),
          expiryDate: DateTime.now(),
          importPrice: 0,
          salePrice: b.salePrice,
          shopId: '',
          quantity: b.quantity,
          images: b.productImages??[],
          attributes: [],
          productMaterials: [],
          stockQuantityByShops: [],
          isGift: b.isGift,
          total: b.total,
          promotionIds: b.promotionIds ?? '',
          disCount: b.discount,
        );
        listA.add(newItem);
        existingIds.add(b.productId);
      }
    }
  }

  // removed duplicate initState (merged above)

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is HomeError) {
            Utils.showCenterMessage(context, "Có lỗi xảy ra: ${state.message}", isError: true);
          }
          else if(state is ScanBarcodeSuccess){
            if(state.productionDetailModel.data.id.toString().replaceAll('null', '').isNotEmpty){
              handleScan(state.productionDetailModel.data);
            }else{
              print('err');
            }
          }
          else if(state is CheckVoucherSuccess){
            listPromotion.add(state.voucherModelResponse.data!.id.toString());
            AddPromotionToOrderModelRequest request = AddPromotionToOrderModelRequest(
                shopId: Const.shopId,
                customerId: Const.userId,
                promotionIds: listPromotion,
                details: mapToAddPromotionToOrderDetails(scannedProducts)
            );
            context.read<HomeCubit>().addPromotionToOrder(request);
          }
          else if(state is AddPromotionToOrderSuccess){
            discountAmount = state.infoBill.data?.disCount??0;
            scannedProducts.map((itemB) {
              final match = state.infoBill.data?.details.firstWhere(
                    (itemA) => itemA.productId == itemB.id,
                orElse: () => AddPromotionToOrderDetail(
                  productId: itemB.id,
                  isGift: 0,
                  quantity: 0,
                  salePrice: 0,
                  salePriceDisCount: 0,
                  promotionIds: '',
                  total: 0,
                  disCount: 0,
                ),
              );
              return itemB.copyWith(
                isGift: match?.isGift,
                total: match?.total,
                promotionIds: match?.promotionIds,
                disCount: match?.disCount,
              );
            }).toList();
          }
          else if(state is CreateOrderSuccess){
            Utils.showFadeCenterMessage(context, 'Tạo đơn thành công');
            _askToPrintBill(context);
          }
          else if(state is UpdateOrderSuccess){
            Utils.showFadeCenterMessage(context, 'Cập nhật thành công');
            _askToPrintBill(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                title: const Text("Thanh toán"),
              centerTitle: true,
              actions: [
                IconButton(
                  tooltip: 'Xem trước hoá đơn',
                  onPressed: scannedProducts.isEmpty ? null : () => _showBillPreview(context),
                  icon: const Icon(Icons.preview),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      builder: (bottomSheetContext) => SizedBox(
                          height: 300,
                          child: BarcodeScannerWidget(
                            onBarcodeDetected: (values) async {
                              if ((await Vibration.hasVibrator())) {
                                Vibration.vibrate();
                              }
                              // Trả về barcode và đóng popup
                              context.read<HomeCubit>().scanBarcode(values.toString().split("_").first);
                              // handleScan(values);
                              //Navigator.of(bottomSheetContext, rootNavigator: true).pop();
                            },
                          )
                      ),
                    );
                  }, icon: const Icon(Icons.qr_code_scanner)),
                ),
              ],
            ),
            body: buildBody(state)
          );
        });
  }

  Future<void> _askToPrintBill(BuildContext context) async {
    final shouldPrint = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('In hoá đơn'),
        content: const Text('Đơn hàng đã tạo thành công. Bạn có muốn xem trước và in hoá đơn không?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Không')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Xem trước')),
        ],
      ),
    );
    if (shouldPrint == true) {
      await _showBillPreview(context);
    }
    if (mounted) context.go(RouteNames.homepage);
  }

  Future<void> _showBillPreview(BuildContext context) async {
    final cache = getIt<CacheService>();
    final items = scannedProducts.map((p) => MenuItem(name: p.name, quantity: p.quantity, unitPrice: p.salePrice.toInt())).toList();
    
    final billData = generateBillPreview(
      items: items,
      customerName: nameCustomerController.text,
      totalAmountOverride: finalAmount.toInt(),
      bankName: cache.getString(CacheKeys.bankName),
      bankAccountName: cache.getString(CacheKeys.bankAccountName),
      bankAccountNumber: cache.getString(CacheKeys.bankAccountNumber),
    );

    if (!mounted) return;
    
    await showDialog(
      context: context,
      builder: (ctx) => BillPreviewWidget(
        billData: billData,
        onCancel: () => Navigator.pop(ctx),
        onPrint: () async {
          Navigator.pop(ctx);
          await _printCurrentBill(context);
        },
      ),
    );
  }

  Future<void> _printCurrentBill(BuildContext context) async {
    final cache = getIt<CacheService>();
    final ip = cache.getString(CacheKeys.printerIp);
    if (ip.isEmpty) {
      Utils.showFadeCenterMessage(context, 'Chưa cấu hình IP máy in trong Cài đặt', isError: true);
      return;
    }
    final items = scannedProducts.map((p) => printer.MenuItem(name: p.name, quantity: p.quantity, unitPrice: p.salePrice.toInt())).toList();
    final result = await printer.printReceipt(
      ip: ip,
      items: items,
      customerName: nameCustomerController.text,
      totalAmountOverride: finalAmount.toInt(),
      bankName: cache.getString(CacheKeys.bankName),
      bankAccountName: cache.getString(CacheKeys.bankAccountName),
      bankAccountNumber: cache.getString(CacheKeys.bankAccountNumber),
    );
    if (mounted) {
      Utils.showCenterMessage(context, result, isError: !result.contains('✅'));
    }
  }

  buildBody(HomeState state){
    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: scannedProducts.length,
                itemBuilder: (context, index) {
                  final product = scannedProducts[index];
                  return ListTile(
                      leading: product.images.isNotEmpty
                          ?
                      CachedNetworkImage(
                        imageUrl: product.images.first.startsWith("http")
                            ?product.images.first
                            : "http://hangangramyeon.vn${product.images.first}",
                        fit: BoxFit.cover, width: 40,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                        ),
                      )
                          : const Icon(Icons.image),
                      title: Text(product.name.toString(),style: const TextStyle(fontSize: 13,color: Colors.black),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      subtitle: Text("Đơn giá: ${Utils.formatMoneyStringToDouble(product.salePrice)}đ",style: const TextStyle(fontSize: 12.5,color: Colors.black),),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: Const.isManager,
                            child: IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  final currentItem = scannedProducts[index];
                                  final newQuantity = (currentItem.quantity - 1).clamp(0, 999);

                                  if (newQuantity == 0) {
                                    scannedProducts.removeAt(index);
                                  } else {
                                    scannedProducts[index] = currentItem.copyWith(quantity: newQuantity);
                                  }
                                });
                              },
                            ),
                          ),
                          Text('${Const.isManager ? product.quantity : 'SL: ${product.quantity}'}'),
                          Visibility(
                            visible: Const.isManager,
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  scannedProducts[index] =
                                      scannedProducts[index].copyWith(quantity: scannedProducts[index].quantity + 1);
                                });
                              },
                            ),
                          ),
                          Visibility(
                            visible: Const.isManager,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  scannedProducts.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ],
                      )
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  const Icon(Icons.perm_contact_calendar_outlined,color: Colors.blue,),
                  Expanded(
                    child: inputWidget(title:'',hideText: "Tên khách hàng",controller: nameCustomerController,focusNode: nameCustomerFocus, textInputAction: TextInputAction.done,
                        onTap:  ()=>_showCustomerSelection(context),
                        note: false,isEnable: true,iconSuffix: Icons.search),
                  ),
                ],
              ),
            ),
            // Voucher & Promotion
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap:() async{
                      final result =  await context.push<List<dynamic>>(RouteNames.voucherSelectionScreen,extra: {
                        'listProduction': mapToCheckProductionDetails(scannedProducts),
                      });
                      if (result != null && result.length == 2 && result[0] == true) {
                        final selectedVoucher = result[1] as PromotionData;
                        setState(() {
                          voucherSelectedName = selectedVoucher.name;
                          voucherSelectedId = selectedVoucher.id;
                        });
                        listPromotion.add(voucherSelectedId);
                        AddPromotionToOrderModelRequest request = AddPromotionToOrderModelRequest(
                            shopId: Const.shopId,
                            customerId: Const.userId,
                            promotionIds: listPromotion,
                            details: mapToAddPromotionToOrderDetails(scannedProducts)
                        );
                        context.read<HomeCubit>().addPromotionToOrder(request);
                      }
                      else if(result != null && result.length == 2 && result[0] == false){
                        voucherSelectedName = result[1].toString().toUpperCase();
                        CheckVoucherModelRequest voucherModelRequest = CheckVoucherModelRequest(
                            shopId: Const.shopId,
                            customerId: Const.userId,
                            voucherCode: voucherSelectedName,
                            details: mapToCheckProductionDetails(scannedProducts)
                        );
                        context.read<HomeCubit>().checkVoucher(voucherModelRequest);
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(MingCute.sale_fill,color: Colors.red,),
                            SizedBox(width: 5,),
                            Text('Voucher',style: TextStyle(fontSize: 13,color: Colors.black),)
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(voucherSelectedName.replaceAll('null', '').isNotEmpty ? voucherSelectedName.toString().replaceAll('null', '') : 'Chọn voucher',
                                  style: TextStyle(fontSize: 13,color: voucherSelectedName.replaceAll('null', '').isNotEmpty ? Colors.red : Colors.grey),maxLines: 1,textAlign: TextAlign.right,),
                              ),
                              const SizedBox(width: 5,),
                              voucherSelectedName.replaceAll('null', '').isNotEmpty ?
                              InkWell(
                                  onTap: (){
                                    setState(() {
                                      discountAmount = 0;
                                      voucherSelectedName = '';
                                      voucherSelectedId = '';
                                    });
                                  },
                                  child: const Icon(MingCute.delete_2_fill,color: Colors.red,size: 20,)) :
                              const Icon(MingCute.right_line,color: Colors.grey,size: 20,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Divider(),
                  const SizedBox(height: 4),
                  Visibility(
                    visible: diemKH > 0,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          if(isUserPoint){
                            isUserPoint = false;
                            discountAmount = discountAmount - (diemKH * Const.pointValue);
                          }else{
                            if(totalPrice > (discountAmount + (diemKH * Const.pointValue))){
                              isUserPoint = true;
                              discountAmount = discountAmount + (diemKH * Const.pointValue);
                            }else{
                              Utils.showFadeCenterMessage(context, 'Không thể áp dụng. Số tiền KM lớn hơn tổng thanh toán',isError: true);
                            }
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Tích luỹ: ${Utils.formatMoneyStringToDouble(diemKH * Const.pointValue)} đ",
                              style: const TextStyle(color: Colors.green,fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          Icon(isUserPoint ? MingCute.delete_2_fill : MingCute.copy_2_fill,color: Colors.green,size: 20,),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tổng tiền:"),
                      Text("${Utils.formatMoneyStringToDouble(totalPrice)}đ"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Khuyến mãi:"),
                      Text("-${Utils.formatMoneyStringToDouble(discountAmount)}đ"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Tổng thanh toán:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${Utils.formatMoneyStringToDouble(finalAmount)}đ",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Visibility(
                    visible: Const.isManager,
                    child: ElevatedButton(
                      onPressed: () {
                        if(widget.isUpdateOrder == true){
                          if(scannedProducts.isNotEmpty){
                            List<Detail> details = [];
                            for (var element in scannedProducts) {
                              Detail item = Detail(
                                  productId: element.id,
                                  productName: element.name,
                                  quantity: element.quantity,
                                  salePrice: element.salePrice,
                                  total: element.total,
                                  isGift: element.isGift,
                                  discount: element.disCount,
                              );
                              details.add(item);
                            }
                            UpdateOrderRequest createOrderRequest = UpdateOrderRequest(
                                id: widget.detailTransactionData!.id.toString(),
                                shopId: Const.shopId.toString(),
                                invoiceCode: widget.detailTransactionData!.invoiceCode.toString(),
                                saleDate: DateTime.now().toLocal(),
                                customerPaid: finalAmount,
                                totalAmount: finalAmount,
                                changeAmount: 0,
                                totalDisCount: discountAmount,
                                totalPayment: finalAmount,
                                promotionIds: listPromotion.join(','),
                                total: finalAmount,
                                discount: discountAmount,
                                note: '',
                                customerId: selectedCustomerCode.toString().replaceAll('null', '').isNotEmpty ? selectedCustomerCode.toString() : null,
                                voucherCodeId: voucherSelectedId.toString().replaceAll('null', '').isNotEmpty ? voucherSelectedId.toString() : null,
                                Lot: widget.detailTransactionData!.invoiceCode.toString(),
                                totalCount: scannedProducts.length,
                                pointUsed: diemKH,
                                details: details,
                                changeDisCount: changeDisCount,
                                changeDisCountValue: changeDisCountValue,
                                changeDisCountType: changeDisCountType,
                            );
                            context.read<HomeCubit>().updateOrder(widget.detailTransactionData!.id.toString(),createOrderRequest);
                          }
                          else{
                            Utils.showFadeCenterMessage(context, 'Vui lòng thêm sản phẩm vào đơn hàng',isError: true);
                          }
                        }else{
                          if(scannedProducts.isNotEmpty){
                            List<DetailItem> details = [];
                            for (var element in scannedProducts) {
                              DetailItem item = DetailItem(
                                  id: element.id,
                                  productId: element.id,
                                  name: element.name,
                                  quantity: element.quantity,
                                  salePrice: element.salePrice,
                                  total: element.total,
                                  isGift: element.isGift,
                                  disCount: element.disCount
                              );
                              details.add(item);
                            }
                            CreateOrderRequest createOrderRequest = CreateOrderRequest(
                                invoiceCode: '',
                                shopId: Const.shopId.toString(),
                                saleDate: DateTime.now().toLocal(),
                                discount: discountAmount,
                                note: '',
                                Lot: '-',
                                totalCount: scannedProducts.length,
                                total: finalAmount,
                                promotionIds: listPromotion.join(','),
                                pointUsed: diemKH,
                                customerPaid: finalAmount,
                                details: details,
                                changeDisCount: changeDisCount,
                                changeDisCountValue: changeDisCountValue,
                                changeDisCountType: changeDisCountType,
                                totalPayment: finalAmount,
                                totalDisCountLine: 0,
                                totalDisCount: discountAmount,
                                voucherCodeId: voucherSelectedId,
                                voucherCode: voucherSelectedName.toString()

                            );
                            context.read<HomeCubit>().createOrder(createOrderRequest);
                          }else{
                            Utils.showFadeCenterMessage(context, 'Vui lòng thêm sản phẩm vào đơn hàng',isError: true);
                          }
                        }
                      },
                      child: Center(child: Text(widget.isUpdateOrder == true ? 'Cập nhật' : "Xác nhận thanh toán")),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        Visibility(
          visible: state is HomeLoading,
          child:  const AppCircularIndicator(),
        )
      ],
    );
  }
}
