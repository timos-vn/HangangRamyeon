import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hangangramyeon/core/constants/app_assets.dart';
import 'package:hangangramyeon/core/router/app_router.dart';
import 'package:hangangramyeon/core/utils/utils.dart';
import 'package:hangangramyeon/features/auth/blocs/authentication/authentication_cubit.dart';
import 'package:hangangramyeon/features/auth/presentation/screens/sign_up/widgets/sign_up_form.dart';

import '../../../../../core/constants/app_sizes.dart';
import '../../../../../core/theme/app_styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSuccessState) {
          Utils.showCenterMessage(context, 'Đăng ký tài khoản thành công');
          context.go(RouteNames.homepage);
        } else if (state is AuthenticationErrorState) {
          Utils.showCenterMessage(context, "Có lỗi xảy ra: ${state.error}", isError: true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: AppSizes.defaultPaddingMobile,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Đăng ký',
                    style: AppTypography.bold24().copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppSizes.gapH12,
                  Text(
                    'Chào cưng, Hãy nhập đủ thông tin nhé!',
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
                  const SignUpForm(),
                  AppSizes.gapH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cưng đã có tài khoản? ',
                        style: AppTypography.medium13(),
                      ),
                      InkWell(
                        onTap: () => context.pop(),
                        child: Text(
                          'Đăng nhập nhé',
                          style: AppTypography.medium13(
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
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
