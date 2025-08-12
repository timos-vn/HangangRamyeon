import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hangangramyeon/core/constants/app_assets.dart';
import 'package:hangangramyeon/core/constants/app_sizes.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import 'package:hangangramyeon/core/theme/app_styles.dart';
import 'package:hangangramyeon/core/theme/app_thems.dart';
import 'package:hangangramyeon/core/utils/utils.dart';
import 'package:hangangramyeon/core/widgets/app_alerts.dart';
import 'package:hangangramyeon/features/auth/blocs/authentication/authentication_cubit.dart';

import 'widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationSuccessState) {
            context.go(RouteNames.homepage);
          } else if (state is AuthenticationErrorState) {
           Utils.showCenterMessage(context, "Có lỗi xảy ra: ${state.error}", isError: true);
            context.go(RouteNames.loginpage);
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: AppSizes.defaultPaddingMobile,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Đăng nhập',
                    style: AppTypography.bold24().copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSizes.gapH12,
                  Text(
                    'Chào mừng bạn trở lại, chúng tôi đã rất nhớ bạn!',
                    style: AppTypography.medium11().copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(
                    height: 150.h,width: double.infinity.w,
                    child: Image.asset(
                      AppAssets.logo,
                      fit: BoxFit.contain,
                    ),
                  ),
                  AppSizes.gapH20,
                  const SignInForm(),
                  AppSizes.gapH64,
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(RouteNames.signuppage);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bạn chưa có tài khoản ư? ',
                          style: AppTypography.medium13(),
                        ),
                        Text(
                          'Đăng ký nhé',
                          style: AppTypography.medium13(
                            color: kSteelBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSizes.gapH24,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


