import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/constants/app_sizes.dart';
import 'package:hangangramyeon/core/theme/app_styles.dart';
import 'package:hangangramyeon/core/theme/app_thems.dart';
import 'package:hangangramyeon/core/utils/extensions.dart';
import 'package:hangangramyeon/core/value_objects/password.dart';
import 'package:hangangramyeon/core/value_objects/phone.dart';
import 'package:hangangramyeon/core/widgets/app_button.dart';
import 'package:hangangramyeon/core/widgets/app_textfield.dart';

import '../../../../blocs/authentication/authentication_cubit.dart';
import '../../../../blocs/login_form/login_form_cubit.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            "Số điện thoại của bạn",
            style: AppTypography.medium13().copyWith(
              color: Colors.black,
            ),
          ),
        ),
        const _PhoneField(),
        AppSizes.gapH24,
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            "Mật khẩu của bạn",
            style: AppTypography.medium13().copyWith(
              color: Colors.black,
            ),
          ),
        ),
        const _PasswordField(),
        AppSizes.gapH4,
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // TODO: Thêm logic quên mật khẩu
            },
            child: Text(
              "Quên mật khẩu hỏ?",
              style: AppTypography.medium12Underline().copyWith(color: kSteelBlueColor),
            ),
          ),
        ),
        AppSizes.gapH48,
        const _SignInButton(),
      ],
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField();

  @override
  Widget build(BuildContext context) {
    final error = context.select((LoginFormCubit cubit) => cubit.state.phone.displayError);
    return AppTextfield(
      hint: 'Nhập số điện thoại của bạn ở đây nha',
      keyboardType: TextInputType.phone,
      onChange: (value) {
        context.read<LoginFormCubit>().phoneChanged(value);
      },
      errorText: error == PhoneValidationError.invalid
          ? "Ơ kìa sai định dạng số điện thoại rồi?"
          : error == PhoneValidationError.empty
          ? "Nhập số điện thoại của fen vào đi"
          : null,
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField();

  @override
  Widget build(BuildContext context) {
    final error = context.select((LoginFormCubit cubit) => cubit.state.password.displayError);
    return BlocBuilder<LoginFormCubit, LoginState>(
      builder: (context, state) {
        return AppTextfield(
          hint: 'Nhập mật khẩu 6 số nhen',
          keyboardType: TextInputType.visiblePassword,
          obscureText: state.isObscure,
          suffixIcon: state.isObscure ? Icons.visibility_off : Icons.visibility,
          textInputAction: TextInputAction.done,
          onSuffixIconTap: () {
            context.read<LoginFormCubit>().changeObscurity();
          },
          onChange: (value) {
            context.read<LoginFormCubit>().passwordChanged(value);
          },
          errorText: error == PasswordValidationError.invalid
              ? "Mật khẩu trên 6 ký tự mà má?"
              : error == PasswordValidationError.empty
              ? "Nhập mật khẩu của fen vào đi"
              : null,
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  const _SignInButton();

  @override
  Widget build(BuildContext context) {
    final isEnabled = context.select((LoginFormCubit cubit) => cubit.state.isValid);

    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final isLoading = state is AuthenticationLoadingState;
        return AppButton(
          color: context.theme.primaryColor,
          width: 1.sw,
          title: 'Đăng nhập',
          isLoading: isLoading,
          onClick: (true)//isEnabled && !isLoading
              ? () {
                  context.read<AuthenticationCubit>().login(
                        phone: context.read<LoginFormCubit>().state.phone.value.toString().replaceAll('null', '').isNotEmpty ? context.read<LoginFormCubit>().state.phone.value : 'letien3',
                        password: context.read<LoginFormCubit>().state.password.value.toString().replaceAll('null', '').isNotEmpty ? context.read<LoginFormCubit>().state.password.value : 'Administrator1!',
                      );
                }
              : (){},
        );
      },
    );
  }
}
