import 'package:flutter/material.dart';

import '../../../widgets/primary_button.dart';

class LoginButton extends StatelessWidget {
  final Function() onPressed;
  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: PrimaryButton(
          text: "Login",
          onPressed: onPressed),
    );
  }
}
