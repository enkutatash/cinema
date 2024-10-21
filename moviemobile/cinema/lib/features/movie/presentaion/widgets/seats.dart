import 'package:cinema/core/constant/color.dart';
import 'package:flutter/material.dart';

class SeatLayout extends StatelessWidget {
  const SeatLayout({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> rows = [4, 5, 6, 7, 8, 9];
    double width = MediaQuery.of(context).size.width;
    double contSize =
        (width * 0.8) / (rows.reduce((a, b) => a > b ? a : b).toDouble());
    return ListView.builder(
      itemCount: rows.length, // Number of rows
      itemBuilder: (context, rowIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              rows[rowIndex], // Number of seats in the current row
              (seatIndex) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Seats(
                    rowIndex: rowIndex,
                    seatIndex: seatIndex,
                    contSize: contSize),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Seats extends StatelessWidget {
  final int rowIndex;
  final int seatIndex;
  final double contSize;

  const Seats({
    super.key,
    required this.rowIndex,
    required this.seatIndex,
    required this.contSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: contSize,
      height: contSize,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          '${rowIndex + 1}-${String.fromCharCode(65 + seatIndex)}', // Label each seat with row and seat number
          style: const TextStyle(color: AppColor.lightRed, fontSize: 12),
        ),
      ),
    );
  }
}

class SeatKey extends StatelessWidget {
  const SeatKey({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColor.lightPrimaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '1-A', // Label each seat with row and seat number
              style: const TextStyle(color: AppColor.lightRed, fontSize: 12),
            ),
          ),
        ),
        Text(
          "Taken",
          style: TextStyle(color: AppColor.lightRed),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '1-A', // Label each seat with row and seat number
              style: const TextStyle(color: AppColor.lightRed, fontSize: 12),
            ),
          ),
        ),
        Text(
          "Available",
          style: TextStyle(color: AppColor.lightRed),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: AppColor.secondaryColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '1-A', // Label each seat with row and seat number
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
        Text(
          "Selected",
          style: TextStyle(color: AppColor.lightRed),
        ),
      ],
    );
  }
}
