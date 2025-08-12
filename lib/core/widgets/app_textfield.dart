import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hangangramyeon/core/theme/app_thems.dart';
import 'package:hangangramyeon/core/utils/extensions.dart';
import 'package:hangangramyeon/core/widgets/text_field_widget2.dart';

import '../theme/app_styles.dart';

class AppTextfield extends StatelessWidget {
  final IconData? suffixIcon;
  final bool? obscureText;
  final String hint;
  final FormFieldValidator<String>? validator;
  final TextEditingController? textEditingController;
  final TextInputType keyboardType;
  final int? maxLength;
  final FocusNode? focusNode;
  final void Function(String)? onChange;
  final void Function(String)? onSubmit;
  final VoidCallback? onSuffixIconTap;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color? filledColor;
  final Color? textColor;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final double? verticalPadding;
  final String? errorText;
  final String? initialValue;
  final TextInputAction? textInputAction;
  const AppTextfield({
    super.key,
    required this.hint,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.focusNode,
    this.obscureText = false,
    this.textEditingController,
    this.maxLength,
    this.onChange,
    this.onSubmit,
    this.onTapOutside,
    this.onSuffixIconTap,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.filledColor,
    this.textColor,
    this.prefixIcon,
    this.prefixIconColor,
    this.verticalPadding,
    this.errorText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    final textField = TextFormField(
      readOnly: readOnly,
      textCapitalization: TextCapitalization.none,
      maxLines: 1,
      maxLength: maxLength,
      keyboardType: keyboardType,
      controller: textEditingController,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTapOutside: onTapOutside,
      obscureText: obscureText!,
      onTap: readOnly ? onTap : null,
      textInputAction: textInputAction,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTypography.medium11(color: Colors.grey.shade500),
        fillColor: Colors.grey.shade200,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: verticalPadding != null ? verticalPadding!.h : 15.h,
        ),
        // ❌ Bỏ errorText ra
        prefixIcon: prefixIcon == null
            ? null
            : Icon(
          prefixIcon,
          color: prefixIconColor ?? context.theme.primaryColor,
        ),
        suffixIcon: suffixIcon == null
            ? null
            : IconButton(
          onPressed: onSuffixIconTap,
          icon: Icon(
            suffixIcon!,
            color: context.theme.primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Colors.grey[600]!,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Colors.grey[600]!,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: kSteelBlueColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(
            color: kSteelBlueColor,
          ),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: AppTypography.medium12(),
      cursorColor: kSteelBlueColor,
      initialValue: initialValue,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textField,
        if (errorText != null && errorText!.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: 4.w, top: 8.h), // sát viền
            child: Text(
              errorText!,
              style: AppTypography.medium10(color: Colors.red),
            ),
          ),
      ],
    );
  }
}

Widget inputWidget({String? title,String? hideText,IconData? iconPrefix,IconData? iconSuffix, bool? isEnable,
  TextEditingController? controller,Function? onTapSuffix, Function? onSubmitted,FocusNode? focusNode,VoidCallback? onTap,
  TextInputAction? textInputAction,bool inputNumber = false,bool note = false,bool isPassWord = false}){
  return Padding(
    padding: const EdgeInsets.only(top: 0,left: 10,right: 0,bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title.toString().isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title??'',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13,color: Colors.black),
                ),
                Visibility(
                  visible: note == true,
                  child: const Text(' *',style: TextStyle(color: Colors.red),),
                )
              ],
            ),
          ),
        ),
        Container(
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFieldWidget2(
                  controller: controller!,
                  // suffix: iconSuffix,
                  textInputAction: textInputAction!,
                  isEnable: isEnable ?? true,
                  keyboardType: inputNumber == true ? TextInputType.phone : TextInputType.text,
                  hintText: hideText,
                  focusNode: focusNode,
                  onSubmitted: (text)=> onSubmitted,
                  isPassword: isPassWord,
                  isNull: true,
                  color: Colors.blueGrey,
                ),
              ),
              IconButton(onPressed:onTap, icon: Icon(iconSuffix))
            ],
          ),
        ),
      ],
    ),
  );
}
