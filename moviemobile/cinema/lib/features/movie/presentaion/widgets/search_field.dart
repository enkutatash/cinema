import 'package:cinema/core/constant/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  SearchField({required this.controller, required this.hintText, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
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
          style: TextStyle(color: AppColor.lightRed),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColor.lightRed),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search, color: AppColor.lightRed),
          ),
        ),
      ),
    );
  }
}
