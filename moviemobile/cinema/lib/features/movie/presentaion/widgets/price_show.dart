import 'package:cinema/core/constant/color.dart';
import 'package:flutter/material.dart';

class PriceShow extends StatelessWidget {
  const PriceShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.03,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 66, 109, 68),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          "10 \$",
          style: TextStyle(fontSize: 15, color: AppColor.white),
        ),
      ),
    );
  }
}
