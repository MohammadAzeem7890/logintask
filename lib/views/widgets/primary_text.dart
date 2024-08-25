import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  double? fontSize;
  Color color;
  TextAlign? align;
  FontWeight? fontWeight;
  PrimaryText({super.key, this.align, required this.text, this.fontWeight, this.fontSize, this.color = AppColors.headingColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color),
    );
  }
}
