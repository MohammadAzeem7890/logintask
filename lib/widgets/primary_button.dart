import 'package:flutter/material.dart';
import 'package:login_task/widgets/primary_text.dart';

import '../../utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color textColor, buttonColor;
  final VoidCallback onPressed;
  const PrimaryButton(
      {super.key,
      this.buttonColor = AppColors.buttonTextColor,
      this.textColor = AppColors.whiteColor,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        ),
        child: PrimaryText(
          text: text,
          fontSize: 16.0,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
