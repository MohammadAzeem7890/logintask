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

class LoginScreen extends StatelessWidget {
  LoginCubit loginController = LoginCubit();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              height: 400,
              width: double.maxFinite,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.headingColor.withOpacity(0),
                      spreadRadius: 0, // No spread
                      blurRadius: 30, // High blur radius for soft edges
                      offset: const Offset(0, 5)),
                ],
                gradient: LinearGradient(
                  colors: [
                    // AppColors.headingColor
                    //     .withOpacity(0.2),
                    AppColors.gradientColor2
                        .withOpacity(0.15), // Lighter blue with opacity
                    AppColors.gradientColor1.withOpacity(
                        0.1), // Even lighter blue with more opacity
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    // 0.1,
                    1,
                    1
                  ], // Stops to control the gradient spread
                ),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              PrimaryText(
                text: "Log in!",
                fontSize: 64,
                fontWeight: FontWeight.w600,
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
                  LoginCubit().login(
                      _emailController.text, _passwordController.text, context);
                },
                prefixIcon: AppAssets.passwordIcon,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                obscureText: true,
                validator: Validations.validatePassword,
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
              BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
                if (state is LoginLoading) {
                  return const CircularProgressIndicator(
                    color: AppColors.whiteColor,
                  );
                } else if (state is LoginFailure) {
                  return PrimaryText(
                    text: state.errorMessage,
                  );
                }
                return Container();
              }, listener: (context, state) {
                if (state is LoginSuccess) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              })
              // BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
              //   debugPrint("INSIDE BLOCK CONSUMER BUILDER");
              //   if (state is LoginLoadingState) {
              //     debugPrint("INSIDE BLOCK LOADING STATE");
              //     return const CircularProgressIndicator(
              //       color: AppColors.whiteColor,
              //     );
              //   }
              //   debugPrint("INSIDE BLOCK LOADER BUTTON SHOW");
              //   return PrimaryButton(
              //       text: "Login",
              //       onPressed: () {
              //         debugPrint("hit");
              //         BlocProvider.of<LoginCubit>(context).login(
              //             _emailController.text,
              //             _passwordController.text,
              //             context);
              //       });
              // }, listener: (context, state) {
              //   debugPrint("INSIDE BLOCK LISTENER");
              //   if (state is LoggedInState) {
              //     debugPrint("INSIDE BLOCK LOGGED IN STATE");
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(
              //         builder: (context) => const HomeScreen()));
              //   }
              // }),
            ],
          ),
        ],
      ),
    ));
  }
}
