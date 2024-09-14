import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/utils/app_assets.dart';
import 'package:login_task/utils/app_colors.dart';
import 'package:login_task/validations/validations.dart';
import 'package:login_task/views/login_screen/login_bloc.dart';
import 'package:login_task/views/login_screen/login_components/login_button.dart';
import 'package:login_task/views/login_screen/login_components/login_error_message.dart';
import 'package:login_task/views/login_screen/login_components/login_progress_widget.dart';
import 'package:login_task/views/login_screen/login_state.dart';

import '../../widgets/primary_svg_image.dart';
import '../../widgets/primary_text.dart';
import '../../widgets/primary_textfield.dart';

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
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 190,
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
              const SizedBox(
                height: 80,
              ),
              PrimaryTextField(
                controller: _emailController,
                hintText: "Email",
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 17, top: 10, left: 10),
                  child: PrimarySvgImage(assetName: AppAssets.emailIcon),
                ),
                validator: Validations.validateEmail,
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryTextField(
                controller: _passwordController,
                hintText: "Password",
                maxLines: 1,
                onSubmit: (value) {
                  final loginCubit = context.read<LoginCubit>();
                  loginCubit.validateLogin(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                    context,
                  );
                  return null;
                },
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(bottom: 17, top: 10, left: 10),
                  child: PrimarySvgImage(assetName: AppAssets.passwordIcon),
                ),
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
                validator: Validations.validatePassword,
              ),
              const SizedBox(
                height: 25,
              ),
              BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
                if (state is LoginLoading) {
                  return LoginProgressWidget(message: state.message);
                } else if (state is RegisterLoading) {
                  return LoginProgressWidget(message: state.message);
                } else if (state is RegistrationSuccess) {
                  LoginProgressWidget(message: state.message);
                } else if (state is LoginFailure) {
                  return LoginErrorMessage(message: state.errorMessage);
                } else if (state is RegistrationFailure) {
                  return LoginErrorMessage(message: state.errorMessage);
                }
                return Container();
              }, listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              }),
              BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
                if (state is LoginLoading || state is RegisterLoading) {
                  return Container();
                }
                return LoginButton(onPressed: () {
                  final loginCubit = context.read<LoginCubit>();
                  loginCubit.validateLogin(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                    context,
                  );
                });
              }, listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              }),
            ],
          ),
        ),
      ),
    ));
  }
}
