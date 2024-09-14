import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_task/utils/app_colors.dart';
import 'package:login_task/utils/constants.dart';
import 'package:login_task/views/home_screen/models/todo_list_model.dart';

import '../firebase_options.dart';
import '../views/home_screen/bloc/home_bloc.dart';
import '../views/home_screen/models/todo_list_helper_model.dart';
import '../views/home_screen/view/home_screen.dart';
import '../views/list_details/bloc/list_details_bloc.dart';
import '../views/list_details/view/list_details_screen.dart';
import '../views/login_screen/login_bloc.dart';
import '../views/login_screen/login_screen.dart';
import '../widgets/primary_text.dart';

void showSnackBar(message, BuildContext context) {
  final snackBar = SnackBar(
    content: PrimaryText(
      text: message,
      color: Colors.white,
    ),
    backgroundColor: AppColors.headingColor,
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

initializeHive() async {
  // initialize hive
  await Hive.initFlutter();


  // register hive adapter
  Hive.registerAdapter(ToDoListItemModelAdapter());

  // open hive box
  Hive.openBox<ToDoListItemModel>(Constants.toDoBox);

}


getThemeData() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.headingColor),
    iconTheme: const IconThemeData(color: AppColors.buttonColor),
    useMaterial3: true,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.buttonTextColor),
    primaryColor: AppColors.headingColor,
    appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: AppColors.headingColor)),
    platform: TargetPlatform.iOS,
  );
}

getRoutes() {
  return {
    '/': (context) => const LoginScreen(),
    '/home': (context) => const HomeScreen(),
    '/list_details': (context) => const ListDetailsScreen(),
  };
}

getAppBlocs() {
  return [
    BlocProvider(create: (context) => LoginCubit()),
    BlocProvider(create: (context) => HomeBloc()),
    BlocProvider(create: (context) => ListDetailsBloc()),
  ];
}

setVerticalOrientation() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

setStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.headingColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

PreferredSizeWidget appBarWidget(
    {required String title,
    bool isBackIconVisible = false,
    Function()? onBack}) {
  return AppBar(
    backgroundColor: AppColors.headingColor,
    leading: Visibility(
      visible: isBackIconVisible,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressed: onBack,
      ),
    ),
    title: PrimaryText(
      text: title,
      color: AppColors.whiteColor,
    ),
  );
}
