import 'package:cinema/core/constant/color.dart';
import 'package:cinema/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cinema/features/auth/presentation/widgets/buttons.dart';
import 'package:cinema/features/auth/presentation/widgets/input_field.dart';
import 'package:cinema/features/auth/presentation/widgets/loadingbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.success) {
              Navigator.pushReplacementNamed(context, '/home');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registration successful!')),
              );
            } else if (state.status == AuthStatus.failed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Image.asset(
                    'assets/images/background.jpg',
                    width: width * 0.8,
                    height: height * 0.4,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  InputField(controller: nameController, hintText: "Full Name"),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InputField(
                    controller: emailController,
                    hintText: "Email",
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  InputField(
                    controller: passwordController,
                    hintText: "Password",
                    isPassword: true,
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    if (state.status == AuthStatus.loading) {
                      return Loadingbutton();
                    } else {
                      return Buttons(
                          onPressed: () {
                            context.read<AuthBloc>().add(RegisterEvent(
                                fullName: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                confirmPassword: passwordController.text));
                          },
                          text: "Sign up");
                    }
                  }),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(color: AppColor.lightRed),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              color: AppColor.lightRed,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.lightRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
