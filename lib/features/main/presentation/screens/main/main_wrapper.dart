import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hangangramyeon/core/utils/const.dart';
import 'package:hangangramyeon/core/utils/extensions.dart';
import 'package:hangangramyeon/features/main/blocs/main/bottom_nav_cubit.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';


class MainWrapper extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, currentIndex) {
        print(navigationShell.currentIndex);
        return WillPopScope(
          onWillPop: () async {
            if (navigationShell.currentIndex != 0) {
              context.read<BottomNavCubit>().changeSelectedIndex(0);
              navigationShell.goBranch(0);
              return false;
            }
            return true;
          },
          child: PersistentTabView.router(
            navigationShell: navigationShell,
            backgroundColor: Colors.white,
            tabs: [
               PersistentRouterTabConfig(
                item: ItemConfig(
                  icon: const Icon(Icons.home),
                  title: 'Home',
                ),
              ),
              PersistentRouterTabConfig(
                item: ItemConfig(
                  icon: const Icon(Icons.qr_code_scanner),
                  title: 'My Id',
                ),
              ),
               PersistentRouterTabConfig(
                item: ItemConfig(
                  icon: const Icon(Icons.person),
                  title: 'Tôi',
                ),
              ),
            ],
            navBarBuilder: (navBarConfig) {
              return Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade300, width: 1),
                        right: BorderSide(color: Colors.grey.shade300, width: 1),
                        left: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 12,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          splashFactory: NoSplash.splashFactory,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                        ),
                        child: BottomNavigationBar(
                          currentIndex: navigationShell.currentIndex >= 1
                              ? navigationShell.currentIndex + 1
                              : navigationShell.currentIndex,
                          onTap: (index) {
                            if (index == 1) {
                              _showQrDialog(context);
                            } else {
                              final realIndex = index > 1 ? index - 1 : index;
                              navBarConfig.onItemSelected(realIndex);
                              context.read<BottomNavCubit>().changeSelectedIndex(realIndex);
                            }
                          },
                          items: [
                            BottomNavigationBarItem(
                              icon: navBarConfig.items[0].icon,
                              label: navBarConfig.items[0].title,
                            ),
                            const BottomNavigationBarItem(
                              icon: SizedBox.shrink(), // placeholder cho QR
                              label: '',
                            ),
                            BottomNavigationBarItem(
                              icon: navBarConfig.items[2].icon,
                              label: navBarConfig.items[2].title,
                            ),
                          ],
                          selectedItemColor: Theme.of(context).primaryColor,
                          unselectedItemColor: Colors.brown,
                          backgroundColor: Colors.white,
                          type: BottomNavigationBarType.fixed,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: GestureDetector(
                      onTap: () {
                        _showQrDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.qr_code_scanner,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _showQrDialog(BuildContext context) {
    String userName = Const.userName;
    String userId = Const.userId;
    final String qrData = jsonEncode({'userName': userName, 'userId': userId});

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (BuildContext context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('My ID', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              SizedBox(height: 12.h),
              Text(userName.toString()),
              Visibility(
                  visible: !Const.level.toString().toUpperCase().replaceAll('null', '').contains('KHÔNG'),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text('Cấp bậc thành viên: ${Const.level}'),
                  )),
              SizedBox(height: 16.h),
              SizedBox(
                width: 200,
                height: 200,
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                  gapless: false,
                ),
              ),
              SizedBox(height: 12.h),
              const Text('Đưa mã QR này cho nhân viên, để tích điểm khi mua hàng', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.black54)),
              SizedBox(height: 12.h),
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Đóng')),
            ],
          ),
        ),
      ),
    );
  }
}

