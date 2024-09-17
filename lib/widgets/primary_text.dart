import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class PrimaryText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final TextAlign? align;
  final int? maxLines;
  final FontWeight? fontWeight;
  const PrimaryText(
      {super.key,
      this.align,
        this.maxLines,
      required this.text,
      this.fontWeight,
      this.fontSize,
      this.color = AppColors.headingColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style:
          TextStyle(fontWeight: fontWeight, fontSize: fontSize, color: color),
    );
  }
}
