import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
