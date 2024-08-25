import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/utils/app_assets.dart';
import 'package:login_task/utils/app_colors.dart';
import 'package:login_task/validations/validations.dart';
import 'package:login_task/views/home_screen/home_screen.dart';
import 'package:login_task/views/login_screen/login_bloc.dart';
import 'package:login_task/views/login_screen/login_state.dart';
import 'package:login_task/views/widgets/primary_button.dart';
import 'package:login_task/views/widgets/primary_text.dart';
import 'package:login_task/views/widgets/primary_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginCubit loginController = LoginCubit();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: PrimaryText(
                text: "Log in!",
                fontSize: 44,
                align: TextAlign.left,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.09,
            ),
            PrimaryTextField(
              controller: _emailController,
              hintText: "Email",
              prefixIcon: AppAssets.emailIcon,
              validator: Validations.validateEmail,
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryTextField(
              controller: _passwordController,
              hintText: "Password",
              onSubmit: (value) {
                debugPrint("hit");
                final loginCubit = context.read<LoginCubit>();
                loginCubit.validateLogin(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                  context,
                );
              },
              prefixIcon: AppAssets.passwordIcon,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
              validator: Validations.validatePassword,
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
              if (state is LoginLoading) {
                return const CircularProgressIndicator(
                  color: AppColors.whiteColor,
                );
              } else if (state is LoginFailure) {
                return PrimaryText(
                  align: TextAlign.center,
                  color: Colors.red,
                  text: state.errorMessage,
                );
              }
              return Container();
            }, listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            }),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
                text: "Login",
                onPressed: () {
                  debugPrint("hit");
                  final loginCubit = context.read<LoginCubit>();
                  loginCubit.validateLogin(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                    context,
                  );
                }),
          ],
        ),
      ),
    ));
  }
}
