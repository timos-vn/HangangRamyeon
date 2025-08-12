import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:intl/intl.dart';
import 'package:hangangramyeon/core/utils/utils.dart';
import 'package:hangangramyeon/core/widgets/app_circular_indicator.dart';
import 'package:hangangramyeon/features/home/blocs/home_cubit.dart';
import 'package:hangangramyeon/features/home/blocs/home_state.dart';
import 'package:hangangramyeon/features/home/models/response/transaction_response.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen>
    with SingleTickerProviderStateMixin {
  int lastPage = 0;
  int selectedPage = 1;
  int totalPage = 0;
  List<TransactionItem> listTransaction = [];
  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    if(Const.isManager){
      context.read<HomeCubit>().getListTransactionIsManager(selectedPage);
    }else{
      context.read<HomeCubit>().getListTransaction(selectedPage);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy HH:mm').format(date);
    } catch (_) {
      return dateStr;
    }
  }

  Widget _buildInfoRow(IconData icon, String text, {Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: color ?? Colors.blueGrey),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.nunito(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
          Utils.showCenterMessage(context, "Có lỗi xảy ra: ${state.message}",
              isError: true);
        } else if (state is GetListTransactionSuccess) {
          listTransaction = state.transactionResponse.data.items;
          lastPage = state.transactionResponse.data.totalPages;
          totalPage = state.transactionResponse.data.totalPages;
          _animationController.forward(from: 0);
        }
        else if (state is GetDetailListTransactionSuccess) {
          context.push(
            RouteNames.scanCheckoutScreen,
            extra: {
              'isUpdateOrder': true,
              'detailTransactionData': state.detailTransactionResponse.data,
            },
          );
        } else if (state is CreateOrderSuccess) {
          Utils.showFadeCenterMessage(context, 'Tạo đơn thành công');
          context.go('/');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Lịch sử giao dịch"),
            centerTitle: true,
          ),
          body: buildBody(state),
        );
      },
    );
  }

  Widget buildBody(HomeState state) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: listTransaction.length,
                itemBuilder: (context, index) {
                  final item = listTransaction[index];
                  final animation =
                  CurvedAnimation(parent: _animationController, curve: Interval(
                    (index / listTransaction.length).clamp(0.0, 1.0),
                    1.0,
                    curve: Curves.easeOut,
                  ));
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: GestureDetector(
                        onTap: (){
                          context.read<HomeCubit>().getDetailTransaction(item.id.toString());
                        },
                        child: Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(Icons.receipt_long_outlined,
                                    "Mã đơn: ${item.invoiceCode}"),
                                const SizedBox(height: 4),
                                _buildInfoRow(Icons.calendar_today_outlined,
                                    "Ngày: ${formatDate(item.saleDate.toString())}"),
                                const SizedBox(height: 4),
                                _buildInfoRow(Icons.storefront_outlined,
                                    "Cửa hàng: ${item.shopName}"),
                                const SizedBox(height: 4),
                                _buildInfoRow(
                                  Icons.payments_outlined,
                                  "Khách thanh toán: ${NumberFormat('#,###').format(item.customerPaid)} đ",
                                  color: Colors.green.shade700,
                                ),
                                if (item.note.toString().replaceAll('null', '').isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  _buildInfoRow(Icons.note_alt_outlined,
                                      "Ghi chú: ${item.note}",
                                      color: Colors.grey),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            _getDataPager(),
          ],
        ),
        Visibility(
          visible: state is HomeLoading,
          child: const AppCircularIndicator(),
        )
      ],
    );
  }

  Widget _getDataPager() {
    return Center(
      child: SizedBox(
        height: 57,
        width: double.infinity,
        child: Column(
          children: [
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16,right: 16,bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: (){
                          setState(() {
                            lastPage = selectedPage;
                            selectedPage = 1;
                          });
                          if(Const.isManager){
                            context.read<HomeCubit>().getListTransactionIsManager(selectedPage);
                          }else{
                            context.read<HomeCubit>().getListTransaction(selectedPage);
                          }
                        },
                        child: const Icon(Icons.skip_previous_outlined,color: Colors.grey)),
                    const SizedBox(width: 10,),
                    InkWell(
                        onTap: (){
                          if(selectedPage > 1){
                            setState(() {
                              lastPage = selectedPage;
                              selectedPage = selectedPage - 1;
                            });
                            if(Const.isManager){
                              context.read<HomeCubit>().getListTransactionIsManager(selectedPage);
                            }else{
                              context.read<HomeCubit>().getListTransaction(selectedPage);
                            }
                          }
                        },
                        child: const Icon(Icons.navigate_before_outlined,color: Colors.grey,)),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index){
                            return InkWell(
                              onTap: (){
                                setState(() {
                                  lastPage = selectedPage;
                                  selectedPage = index+1;
                                });
                                if(Const.isManager){
                                  context.read<HomeCubit>().getListTransactionIsManager(selectedPage);
                                }else{
                                  context.read<HomeCubit>().getListTransaction(selectedPage);
                                }
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: selectedPage == (index + 1) ?  Colors.blue : Colors.white,
                                    borderRadius: const BorderRadius.all(Radius.circular(48))
                                ),
                                child: Center(
                                  child: Text((index + 1).toString(),style: TextStyle(color: selectedPage == (index + 1) ?  Colors.white : Colors.black),),
                                ),
                              ),
                            );
                          },
                          separatorBuilder:(BuildContext context, int index)=> Container(width: 6,),
                          itemCount: totalPage > 10 ? 10 :totalPage),
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                        onTap: (){
                          if(selectedPage < totalPage){
                            setState(() {
                              lastPage = selectedPage;
                              selectedPage = selectedPage + 1;
                            });
                            if(Const.isManager){
                              context.read<HomeCubit>().getListTransactionIsManager(selectedPage);
                            }else{
                              context.read<HomeCubit>().getListTransaction(selectedPage);
                            }
                          }
                        },
                        child: const Icon(Icons.navigate_next_outlined,color: Colors.grey)),
                    const SizedBox(width: 10,),
                    InkWell(
                        onTap: (){
                          setState(() {
                            lastPage = selectedPage;
                            selectedPage = totalPage;
                          });
                          if(Const.isManager){
                            context.read<HomeCubit>().getListTransactionIsManager(selectedPage);
                          }else{
                            context.read<HomeCubit>().getListTransaction(selectedPage);
                          }
                        },
                        child: const Icon(Icons.skip_next_outlined,color: Colors.grey)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
