import 'package:flutter/material.dart';

class CentralImage extends StatelessWidget {
  final String imageUrl;
  CentralImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(imageUrl, fit: BoxFit.fill, width: width * 0.7),
    );
  }
}
