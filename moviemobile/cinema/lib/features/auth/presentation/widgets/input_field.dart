import 'package:cinema/core/constant/color.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  bool isPassword;
  InputField(
      {required this.controller,
      required this.hintText,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
          color: AppColor.lightPrimaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColor.lightRed.withOpacity(0.5),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          style: TextStyle(color: AppColor.lightRed),
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
