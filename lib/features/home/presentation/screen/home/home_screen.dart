import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:hangangramyeon/core/utils/extensions.dart';
import 'package:hangangramyeon/core/widgets/app_circular_indicator.dart';
import 'package:hangangramyeon/features/home/blocs/home_cubit.dart';
import 'package:hangangramyeon/features/home/blocs/home_state.dart';
import 'package:hangangramyeon/features/home/models/banner_and_post_model.dart';
import 'package:hangangramyeon/features/home/models/response/setting_response.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/widgets/banner_slider.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/widgets/post_list.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:hangangramyeon/core/services/shared_prefs_service.dart';
import 'package:hangangramyeon/core/di/dependency_injection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<BannerItem> listBannerItem = [];
  List<BannerItem> listPostItem = [];

  @override
  void initState() {
    context.read<HomeCubit>().infoAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: context.theme.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeError) {
        }else if(state is InfoAccountSuccess){
          context.read<HomeCubit>().getUserId(state.userId);
          context.read<HomeCubit>().getSetting();
        }else if(state is GetSettingSuccess){
          Const.pointValue = int.tryParse(
            state.settingResponse.data?.data
                .firstWhere(
                  (item) => item.key == "PointValue",
              orElse: () => SettingItem(key: "PointValue", value: "0"),
            )
                .value ??
                "0",
          ) ?? 0;
          // Persist pointValue
          getIt<CacheService>().setInt(CacheKeys.pointValue, Const.pointValue);
        }
        else if(state is HomeUserSuccess){
          Const.userId = state.userModel.data.userId.toString().trim();
          Const.userName = state.userModel.data.userName.toString().trim();
          Const.point = state.userModel.data.point;
          Const.level = state.userModel.data.pointName.toString();
          Const.isManager = state.userModel.data.roles.isNotEmpty ? state.userModel.data.roles[0].roleName.toString().contains('Manager') : false;
          Const.shopId = state.userModel.data.shops?.firstOrNull?.shopId?.toString() ?? "";
          // Persist core user info to cache for next launch
          final cache = getIt<CacheService>();
          cache.setString(CacheKeys.userId, Const.userId);
          cache.setString(CacheKeys.userName, Const.userName);
          cache.setInt(CacheKeys.point, Const.point);
          cache.setString(CacheKeys.level, Const.level);
          cache.setBool(CacheKeys.isManager, Const.isManager);
          cache.setString(CacheKeys.shopId, Const.shopId);
          context.read<HomeCubit>().getBanner(1,100);
        }else if(state is BannerSuccess){
          listBannerItem = state.bannerAndPostModel.data.items.where((e) => e.isFeatured).toList();
          listPostItem = state.bannerAndPostModel.data.items.where((e) => !e.isFeatured).toList();

        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headerSection(state),
                    listBannerItem.isEmpty
                        ?
                    const SizedBox()
                        :
                    Padding(
                      padding: const EdgeInsets.only(top: 70,left: 16,right: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Icon(MingCute.gift_2_fill,color: context.theme.primaryColor),
                                const Text('  Ưu đãi đỉnh cao',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 13),)
                              ],
                            ),
                          ),
                          BannerSlider(
                            items: listBannerItem,
                            onTap: (item) {
                              // Xử lý khi nhấn vào banner
                              print("Tapped: ${item.title}");
                            },
                          ),
                        ],
                      ),
                    ),
                    listPostItem.isEmpty
                        ?
                    const SizedBox()
                        :
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20,left: 15),
                          child: Row(
                            children: [
                              Icon(MingCute.news_fill,color: context.theme.primaryColor),
                              const Text('  Bài viết mới (news)',style: TextStyle(fontWeight: FontWeight.w800,fontSize: 13),)
                            ],
                          ),
                        ),
                        BannerGrid(items: listPostItem),
                        const SizedBox(height: 60,),
                      ],
                    )
                  ],
                ),
                const Positioned(
                  top: 170,
                  left: 0,
                  right: 0,
                  child: _QuickActionCard(),
                ),
                Visibility(
                  visible: state is HomeLoading,
                  child:  const AppCircularIndicator(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget headerSection(HomeState state){
    return Container(
      height: 220,
      width: double.infinity,
      color: context.theme.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            'Ngày mới tốt lành nha!',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                Const.userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              Visibility(
                visible: !Const.level.toString().toUpperCase().replaceAll('null', '').contains('KHÔNG'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    Const.level,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ),
              ),
              const Spacer(),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications_none, color: Colors.white,size: 32,),
                  Positioned(
                    right: 0,top: -10,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                      child: const Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  Text(
                  '${Const.point} P',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ActionItem(icon: MingCute.shopping_bag_1_fill, label: Const.isManager ? 'Đặt đơn' : 'Sản phẩm',onTap: (){
              print(Const.isManager);
              if(Const.isManager){
                context.push(RouteNames.scanCheckoutScreen);
              }else{
                context.push(RouteNames.productionScreen);
              }
            },),
            _ActionItem(icon: Icons.location_on, label: 'Tìm cửa hàng', onTap: (){
              context.push(RouteNames.storeFinder);
            }),
             _ActionItem(icon: Icons.receipt_long, label: 'Giao dịch',onTap: (){
              context.push(RouteNames.transactionScreen);
            },),
            _ActionItem(icon: Icons.card_giftcard, label: 'Quà của bạn', onTap: (){
              context.push(RouteNames.gifts);
            }),
          ],
        ),
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function()? onTap;

  const _ActionItem({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.red.withOpacity(0.1),
            child: Icon(icon, color: context.theme.primaryColor),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
