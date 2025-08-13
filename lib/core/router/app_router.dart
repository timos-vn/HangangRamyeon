import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hangangramyeon/features/home/models/response/detail_transaction_response.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/home_screen.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/production_screen.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/receipt_printer_widget.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/transaction.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/widgets/order.dart';
import 'package:hangangramyeon/features/main/presentation/screens/main/main_wrapper.dart';
import 'package:hangangramyeon/features/profile/presentation/profile_screen.dart';
import 'package:hangangramyeon/features/home/models/banner_and_post_model.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/store_finder_screen.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/gifts_screen.dart';
import 'package:hangangramyeon/features/home/presentation/screen/home/news_detail_screen.dart';
import 'package:hangangramyeon/features/profile/presentation/screens/settings_screen.dart';
import 'package:hangangramyeon/features/profile/presentation/screens/account_info_screen.dart';
import 'package:hangangramyeon/features/profile/presentation/screens/change_password_screen.dart';
import 'package:hangangramyeon/core/widgets/bill_preview_demo.dart';
import 'package:hangangramyeon/features/profile/presentation/screens/contact_feedback_screen.dart';
import 'package:hangangramyeon/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:hangangramyeon/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:hangangramyeon/features/voucher/models/common_detail.dart';
import 'package:hangangramyeon/features/voucher/presentation/screen/voucher_screen.dart';
import '../../features/auth/presentation/screens/sign_in/sign_in_screen.dart';
import '../../features/auth/presentation/screens/sign_up/sign_up_screen.dart';

class RouteNames {
  // static const String onboarding = "/onboarding";
  // static const String welcomepage = "/welcome";
  static const String loginpage = "/login";
  static const String signuppage = "/signup";
  static const String mainWrapper = "/mainWrapper";
  static const String homepage = "/homepage";
  static const String notificationScreen = "/notificationScreen";
  static const String orderScreen = "/orderScreen";
  static const String scanCheckoutScreen = "/scanCheckoutScreen";
  static const String productionScreen = "/productionScreen";
  static const String voucherSelectionScreen = "/voucherSelectionScreen";
  static const String settingspage = "/settings";
  static const String contactFeedback = "/contactFeedback";
  static const String privacyPolicy = "/privacyPolicy";
  static const String printerPage = "/printer";
  static const String transactionScreen = "/transactionScreen";
  static const String storeFinder = "/storeFinder";
  static const String gifts = "/gifts";
  static const String newsDetail = "/newsDetail";
  static const String billPreviewDemo = "/billPreviewDemo";
  static const String accountInfo = "/accountInfo";
  static const String changePassword = "/changePassword";
  static const String forgotPassword = "/forgotPassword";
}

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final bool isAuthenticated;
  late final GoRouter router;

  AppRouter(this.isAuthenticated) {
    router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: isAuthenticated ? '/login' : '/login',
      routes: [
        // GoRoute(
        //   path: RouteNames.welcomepage,
        //   name: RouteNames.welcomepage,
        //   builder: (context, state) => const WelcomePage(),
        // ),
        GoRoute(
          path: RouteNames.loginpage,
          name: RouteNames.loginpage,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: RouteNames.signuppage,
          name: RouteNames.signuppage,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: RouteNames.transactionScreen,
          name: RouteNames.transactionScreen,
          builder: (context, state) => const TransactionScreen(),
        ),
        // Shell Route cho tab bar
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              MainWrapper(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/homepage',
                  builder: (context, state) => const HomeScreen(),
                ),
              ],
            ),
            // StatefulShellBranch(
            //   routes: [
            //     GoRoute(
            //       path: '/orderScreen',
            //       builder: (context, state) => const MyHomePage(),
            //     ),
            //   ],
            // ),
            // StatefulShellBranch(
            //   routes: [
            //     GoRoute(
            //       path: '/qr',
            //       builder: (context, state) => const QRCodePage(),
            //     ),
            //   ],
            // ),
            // StatefulShellBranch(
            //   routes: [
            //     GoRoute(
            //       path: '/notificationScreen',
            //       builder: (context, state) => const ProfilePage(),
            //     ),
            //   ],
            // ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/profile',
                  builder: (context, state) => const ProfileScreen(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: RouteNames.settingspage,
          name: RouteNames.settingspage,
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: RouteNames.contactFeedback,
          name: RouteNames.contactFeedback,
          builder: (context, state) => const ContactFeedbackScreen(),
        ),
        GoRoute(
          path: RouteNames.privacyPolicy,
          name: RouteNames.privacyPolicy,
          builder: (context, state) => const PrivacyPolicyScreen(),
        ),
        GoRoute(
          path: RouteNames.printerPage,
          name: RouteNames.printerPage,
          builder: (context, state) => const ReceiptPrinterWidget(),
        ),
        GoRoute(
          path: RouteNames.scanCheckoutScreen,
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return ScanCheckoutScreen(
              isUpdateOrder: extra?['isUpdateOrder'] as bool?,
              detailTransactionData: extra?['detailTransactionData'] as DetailTransactionData?,
            );
          },
        ),
        GoRoute(
          path: RouteNames.productionScreen,
          builder: (context, state) {
            return const ProductScreen();
          },
        ),
        GoRoute(
          path: RouteNames.voucherSelectionScreen,
          name: RouteNames.voucherSelectionScreen,
          builder: (context, state) {
            final data = state.extra as Map<String, dynamic>?;
            final listProduction = data?['listProduction'] as List<CommonDetail>?;
            return VoucherSelectionScreen(listProduction: listProduction);
          },
        ),
        GoRoute(
          path: RouteNames.storeFinder,
          name: RouteNames.storeFinder,
          builder: (context, state) => const StoreFinderScreen(),
        ),
        GoRoute(
          path: RouteNames.gifts,
          name: RouteNames.gifts,
          builder: (context, state) => const GiftsScreen(),
        ),
        GoRoute(
          path: RouteNames.newsDetail,
          name: RouteNames.newsDetail,
          builder: (context, state) {
            final item = state.extra as BannerItem;
            return NewsDetailScreen(item: item);
          },
        ),
        GoRoute(
          path: RouteNames.billPreviewDemo,
          name: RouteNames.billPreviewDemo,
          builder: (context, state) => const BillPreviewDemo(),
        ),
        GoRoute(
          path: RouteNames.accountInfo,
          name: RouteNames.accountInfo,
          builder: (context, state) => const AccountInfoScreen(),
        ),
        GoRoute(
          path: RouteNames.changePassword,
          name: RouteNames.changePassword,
          builder: (context, state) => const ChangePasswordScreen(),
        ),
        GoRoute(
          path: RouteNames.forgotPassword,
          name: RouteNames.forgotPassword,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
      ],
    );
  }
}
