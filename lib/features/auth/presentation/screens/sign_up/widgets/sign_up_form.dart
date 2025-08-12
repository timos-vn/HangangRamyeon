import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hangangramyeon/core/constants/app_sizes.dart';
import 'package:hangangramyeon/core/theme/app_styles.dart';
import 'package:hangangramyeon/core/utils/extensions.dart';
import 'package:hangangramyeon/core/utils/utils.dart';
import 'package:hangangramyeon/core/value_objects/password.dart';
import 'package:hangangramyeon/core/value_objects/phone.dart';
import 'package:hangangramyeon/core/widgets/app_button.dart';
import 'package:hangangramyeon/core/widgets/app_textfield.dart';
import 'package:hangangramyeon/features/auth/blocs/sign_up_form/sign_up_form_cubit.dart';
import 'package:intl/intl.dart';
import '../../../../blocs/authentication/authentication_cubit.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  static var currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Text(
                "Họ và tên",
                style: AppTypography.medium13().copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                " *",
                style: AppTypography.medium13().copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const _UsernameField(),
        AppSizes.gapH12,
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Text(
                "Số điện thoại",
                style: AppTypography.medium13().copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                " *",
                style: AppTypography.medium13().copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const _PhoneField(),
        AppSizes.gapH12,
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Text(
                "Mật khẩu của bạn",
                style: AppTypography.medium13().copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                " *",
                style: AppTypography.medium13().copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const _PasswordField(),
        AppSizes.gapH12,
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Text(
                "Ngày tháng năm sinh",
                style: AppTypography.medium13().copyWith(
                  color: Colors.black,
                ),
              ),
              Text(
                " *",
                style: AppTypography.medium13().copyWith(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        const _PickDateTimeField(),
        AppSizes.gapH48,
        const _SignUpButton(),
      ],
    );
  }
}

class _PickDateTimeField extends StatelessWidget {
  const _PickDateTimeField();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    TextEditingController textEditingController = TextEditingController();
    return AppTextfield(
      textEditingController: textEditingController, //context.watch<SignUpFormCubit>().state.birthday.toString() ,
      hint: DateFormat('dd/MM/yyyy').format(date),
      onTap: ()async{
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(1980),
          lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
        );
        if (picked != null) {
          date = DateTime(
            picked.year,
            picked.month,
            picked.day,
            // date.hour,
            // date.minute,
          );
          textEditingController.text = DateFormat('dd/MM/yyyy').format(date);
          context.read<SignUpFormCubit>().birthdayChanged(DateFormat('yyyy-MM-dd').format(date).toString());
        }
      },
      readOnly: true,
    );
  }
}

class _UsernameField extends StatelessWidget {
  const _UsernameField();

  @override
  Widget build(BuildContext context) {
    final error = context
        .select((SignUpFormCubit cubit) => cubit.state.username.displayError);
    return AppTextfield(
      hint: 'Nhập tên của cưng nhé',
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      onChange: (value) {
        context.read<SignUpFormCubit>().usernameChanged(value);
      },
      errorText:
      error != null ? "Tên của cưng phải trên 3 ký tự nhé" : null,
    );
  }
}

class _PhoneField extends StatelessWidget {
  const _PhoneField();

  @override
  Widget build(BuildContext context) {
    final error = context.select((SignUpFormCubit cubit) => cubit.state.phone.displayError);
    return AppTextfield(
      hint: 'Nhập số điện thoại của bạn ở đây nha',
      keyboardType: TextInputType.phone,
      onChange: (value) {
        context.read<SignUpFormCubit>().phoneChanged(value);
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
    final error = context.select((SignUpFormCubit cubit) => cubit.state.password.displayError);
    return BlocBuilder<SignUpFormCubit, SignUpState>(
      builder: (context, state) {
        return AppTextfield(
          hint: 'Nhập mật khẩu 6 số nhen',
          keyboardType: TextInputType.visiblePassword,
          obscureText: state.isPasswordObscure,
          suffixIcon: state.isPasswordObscure ? Icons.visibility_off : Icons.visibility,
          textInputAction: TextInputAction.done,
          onSuffixIconTap: () {
            context.read<SignUpFormCubit>().changePasswordObscurity();
          },
          onChange: (value) {
            context.read<SignUpFormCubit>().passwordChanged(value);
          },
          errorText: error == PasswordValidationError.invalid
              ? "Mật khẩu phải có ít nhất 6 ký tự, 1 chữ in hoa, 1 số và 1 ký tự đặc biệt"
              : error == PasswordValidationError.empty
              ? "Nhập mật khẩu của fen vào đi"
              : null,
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    final isEnabled = context.select((SignUpFormCubit cubit) => cubit.state.isValid);

    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final isLoading = state is AuthenticationLoadingState;
        return AppButton(
          color: context.theme.primaryColor,
          width: 1.sw,
          title: 'Đăng ký',
          isLoading: isLoading,
          onClick: (isEnabled && !isLoading)
              ? () {
            print(isEnabled && !isLoading);
                  context.read<AuthenticationCubit>().register(
                        phoneNumber: context.read<SignUpFormCubit>().state.phone.value,
                        password: context.read<SignUpFormCubit>().state.password.value,
                        username: context.read<SignUpFormCubit>().state.phone.value,
                        fullName: context.read<SignUpFormCubit>().state.username.value,
                        birthDay: context.read<SignUpFormCubit>().state.birthday.value,
                      );
                }
              : (){
            Utils.showCenterMessage(context, "Hãy nhập đủ thông tin nhé cứng!!!", isError: true);
          },
        );
      },
    );
  }
}
