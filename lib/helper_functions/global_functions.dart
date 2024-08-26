import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_task/utils/app_colors.dart';
import 'package:login_task/views/widgets/primary_text.dart';

import '../firebase_options.dart';

void showSnackBar(message, BuildContext context) {
  final snackBar = SnackBar(
    content: PrimaryText(text: message),
    backgroundColor: AppColors.whiteColor,
    duration:
        const Duration(seconds: 2), // Duration for the SnackBar to be visible
  );

  // show the SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

setStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.backgroundColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
}
