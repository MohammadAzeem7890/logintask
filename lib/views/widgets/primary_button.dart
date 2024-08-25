import 'package:flutter/material.dart';
import 'package:login_task/views/widgets/primary_text.dart';

import '../../utils/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const PrimaryButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        ),
        child: PrimaryText(
          text: text,
          fontSize: 16.0,
          color: AppColors.buttonTextColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
