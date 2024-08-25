import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/views/widgets/primary_text.dart';

import '../login_screen/login_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PrimaryText(text: "Welcome to the Home Screen!"),
            const SizedBox(height: 30,),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<LoginCubit>().logOut(context);
                Navigator.pushReplacementNamed(context, '/');
              },
            ),

          ],
        ),
      ),
    ));
  }
}
