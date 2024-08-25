import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  double? fontSize;
  FontWeight? fontWeight;
  PrimaryText({super.key, required this.text, this.fontWeight, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: AppColors.headingColor),
    );
  }
}
