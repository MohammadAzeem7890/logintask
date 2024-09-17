import 'package:flutter/material.dart';
import 'package:login_task/utils/app_colors.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator, onSubmit;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Widget? prefixIcon;
  final int? maxLines;

  final String? label, hintText;
  final bool obscureText;
  const PrimaryTextField(
      {super.key,
      this.hintText,
        this.maxLines,
      this.validator,
        required this.controller,
      this.label,
        this.textInputAction = TextInputAction.next,
        this.textInputType = TextInputType.emailAddress,
      this.obscureText = false,
      this.onSubmit,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    InputBorder inputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.headingColor),
    );
    InputBorder errorBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    );

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscuringCharacter: "#",
      autocorrect: true,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(color: AppColors.headingColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.headingColor),
        prefixIcon: prefixIcon,
        border: inputBorder,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        errorBorder: errorBorder,
        focusedBorder: inputBorder,
      ),
      validator: validator,
      onFieldSubmitted: onSubmit,
    );
  }
}
