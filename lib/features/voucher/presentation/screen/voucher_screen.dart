import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:hangangramyeon/core/widgets/app_circular_indicator.dart';
import 'package:hangangramyeon/features/voucher/blocs/voucher_cubit.dart';
import 'package:hangangramyeon/features/voucher/blocs/voucher_state.dart';
import 'package:hangangramyeon/features/voucher/models/check_promotion_model_request.dart';
import 'package:hangangramyeon/features/voucher/models/check_promotion_model_response.dart';
import 'package:hangangramyeon/features/voucher/models/common_detail.dart';

class VoucherSelectionScreen extends StatefulWidget {
  const VoucherSelectionScreen({super.key, this.listProduction});

  final  List<CommonDetail>? listProduction;

  @override
  State<VoucherSelectionScreen> createState() => _VoucherSelectionScreenState();
}

class _VoucherSelectionScreenState extends State<VoucherSelectionScreen> {

  List<PromotionData> listPromotionData = [];
  String? selectedVoucherId;
  int indexSelectedVoucher = -1;
  TextEditingController voucherInput = TextEditingController();
  FocusNode voucherNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.listProduction?.isNotEmpty ?? false) {
      CheckPromotionModelRequest request = CheckPromotionModelRequest(
        shopId: Const.shopId.toString().replaceAll('null', '').isNotEmpty ? Const.shopId : null,
        customerId: Const.userId.toString().replaceAll('null', '').isNotEmpty ? Const.userId : null,
        details: widget.listProduction!
      );
      context.read<VoucherCubit>().checkPromotion(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoucherCubit, VoucherState>(
        listener: (context, state) {

          if(state is VoucherError) {
            print(state.message);
          }
          else if (state is CheckPromotionSuccess) {
            listPromotionData = state.promotionModelResponse.data.where((e) => e.voucherCode.toString().replaceAll('null', '').isEmpty).toList();
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Chọn hoặc nhập Voucher'),
              leading: const BackButton(),
            ),
            body: buildBody(state),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (selectedVoucherId != null) {
                    final selectedVoucher = listPromotionData.firstWhere(
                          (v) => v.id == selectedVoucherId,
                    );
                    Navigator.pop(context, [true,selectedVoucher]); // trả về object
                  }
                },
                child: const Text('Xác nhận', style: TextStyle(color: Colors.white)),
              ),
            ),
          );
        });
  }

  buildBody(VoucherState state){
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Vui lòng nhập mã voucher',
                  suffixIcon: TextButton(
                    onPressed: () {
                      if(voucherInput.text.toString().replaceAll('null', '').isNotEmpty){
                        Navigator.pop(context, [false,voucherInput.text.trim().toUpperCase()]);
                      }else{
                        if(indexSelectedVoucher >= 0){
                          Navigator.pop(context, [false,listPromotionData[indexSelectedVoucher]]);
                        }else{
                          //Show thoong bao
                        }
                      }
                    },
                    child: const Text('Áp dụng'),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                controller: voucherInput,
                focusNode: voucherNode,
              ),
              const SizedBox(height: 24),
              const Text(
                'Voucher khả dụng',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  itemCount: listPromotionData.length,
                  itemBuilder: (context, index) {
                    final voucher = listPromotionData[index];
                    return Card(
                      elevation: 1,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: voucher.imageUrl.toString().replaceAll('null', '').isNotEmpty ? CachedNetworkImage(
                          imageUrl:  "http://hangangramyeon.vn${voucher.imageUrl.toString()}",
                          fit: BoxFit.cover,
                          width: 50,
                          height: 100,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                          ),
                        ) : const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                        title: Text(voucher.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                'Hết hạn trong: ${voucher.endDate.toString().replaceAll('null', '').isNotEmpty
                                    ? '${DateTime.parse(voucher.endDate.toString()).difference(DateTime.now()).inDays} ngày'
                                    : "Không thời hạn" }',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        trailing: Radio<String>(
                          value: voucher.id,
                          groupValue: selectedVoucherId,
                          onChanged: (value) {
                            setState(() {
                              selectedVoucherId = value;
                              indexSelectedVoucher = index;
                              voucherInput.text ='';
                              voucherNode.unfocus();
                            });
                          },
                        ),
                        onTap: (){
                          setState(() {
                            selectedVoucherId = selectedVoucherId == voucher.id ? null : voucher.id;
                            indexSelectedVoucher = -1;
                          });
                        },
                      ),
                    );
                  },
                )
              ),
              const Divider(height: 32),
            ],
          ),
        ),
        Visibility(
          visible: state is VoucherLoading,
          child:  const AppCircularIndicator(),
        )
      ],
    );
  }
}
