import 'package:cinema/core/constant/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Loadingbutton extends StatelessWidget {
  
  
  Loadingbutton({ super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
     
      child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: AppColor.lightRed,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: AppColor.lightRed.withOpacity(0.5),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ]),
          child: Center(child: CircularProgressIndicator())),
    );
  }
}
