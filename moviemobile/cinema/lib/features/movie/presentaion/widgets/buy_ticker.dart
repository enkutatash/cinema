import 'package:cinema/core/constant/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuyTicker extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  double height;
  double font;
  BuyTicker(
      {required this.onPressed,
      required this.text,
      this.height = 0.04,
      this.font = 20,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * height,
          decoration: BoxDecoration(
              color: AppColor.lightRed,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColor.lightRed.withOpacity(0.5),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ]),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: font,
              fontWeight: FontWeight.bold,
            ),
          ))),
    );
  }
}
