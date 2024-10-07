import 'package:cinema/core/constant/color.dart';
import 'package:cinema/features/auth/presentation/widgets/buttons.dart';
import 'package:cinema/features/auth/presentation/widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
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
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Buttons(onPressed: () {}, text: "Login"),
                SizedBox(
                  height: height * 0.01,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(color: AppColor.lightRed),
                      children: [
                        TextSpan(
                          text: "Sign up",
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
        ));
  }
}
