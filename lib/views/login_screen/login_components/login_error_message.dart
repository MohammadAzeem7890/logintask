import 'package:flutter/material.dart';
import 'package:login_task/utils/app_colors.dart';

import '../../../widgets/primary_text.dart';

class LoginErrorMessage extends StatelessWidget {
  String message;
  LoginErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return PrimaryText(
      align: TextAlign.center,
      color: AppColors.headingColor,
      text: message,
    );
  }
}
