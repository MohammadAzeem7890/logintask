import 'package:flutter/material.dart';
import 'package:login_task/views/login_screen/login_components/login_error_message.dart';

import '../../../utils/app_colors.dart';

class LoginProgressWidget extends StatelessWidget {
  final String message;
  const LoginProgressWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: AppColors.headingColor,
          ),
          const SizedBox(
            height: 15,
          ),
          LoginErrorMessage(message: message),
        ],
      ),
    );
  }
}
