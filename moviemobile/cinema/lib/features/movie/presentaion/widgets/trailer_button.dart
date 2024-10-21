import 'package:cinema/core/constant/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TrailerButton extends StatelessWidget {
  VoidCallback onPressed;

  TrailerButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.height * 0.04,
          decoration: BoxDecoration(
            // color: AppColor.lightRed,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.lightRed),
          ),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_circle_outline_outlined,
                color: AppColor.lightRed,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Trailer",
                style: TextStyle(
                  color: AppColor.lightRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ))),
    );
  }
}
