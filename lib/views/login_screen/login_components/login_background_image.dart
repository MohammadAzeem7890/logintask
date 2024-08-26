import 'package:flutter/material.dart';

import '../../../utils/app_assets.dart';

class LoginBackgroundImage extends StatelessWidget {
  const LoginBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Image.asset(
      AppAssets.baseImagePath + AppAssets.loginBackgroundImage,
      height: screenHeight,
      width: screenWidth,
      fit: BoxFit.cover,
    );
  }
}
