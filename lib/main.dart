import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/utils/app_colors.dart';
import 'package:login_task/views/home_screen/bloc/home_bloc.dart';
import 'package:login_task/views/home_screen/view/home_screen.dart';
import 'package:login_task/views/list_details/bloc/list_details_bloc.dart';
import 'package:login_task/views/list_details/view/list_details_screen.dart';
import 'package:login_task/views/login_screen/login_bloc.dart';
import 'package:login_task/views/login_screen/login_screen.dart';

import 'helper_functions/global_functions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setStatusBarColor();
  setVerticalOrientation();
  initializeFirebase();
  initializeHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: getAppBlocs(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDos',
        routes: getRoutes(),
        theme: getThemeData(),
      ),
    );
  }
}
