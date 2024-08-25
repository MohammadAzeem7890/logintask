import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:login_task/utils/app_assets.dart';
import 'package:login_task/utils/app_colors.dart';
import 'package:login_task/views/widgets/primary_svg_image.dart';

class PrimaryTextField extends StatelessWidget {
  TextEditingController controller;
  String? Function(String?)? validator, onSubmit;
  TextInputAction textInputAction;
  TextInputType textInputType;

  String? label, hintText, prefixIcon;
  bool obscureText;
  PrimaryTextField(
      {super.key,
      this.hintText,
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
      borderSide: BorderSide(color: AppColors.whiteColor),
    );
    InputBorder errorBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        obscuringCharacter: "#",
        autocorrect: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(color: AppColors.whiteColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.whiteColor),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(bottom: 17, top: 10, left: 10),
            child: PrimarySvgImage(assetName: prefixIcon.toString()),
          ),
          border: inputBorder,
          enabledBorder: inputBorder,
          disabledBorder: inputBorder,
          errorBorder: errorBorder,
          focusedBorder: inputBorder,
        ),
        validator: validator,
        onFieldSubmitted: onSubmit,
      ),
    );
  }
}
