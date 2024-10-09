import 'package:cinema/core/constant/color.dart';
import 'package:cinema/features/movie/presentaion/widgets/screen_curve.dart';
import 'package:cinema/features/movie/presentaion/widgets/seats.dart';
import 'package:cinema/features/movie/presentaion/widgets/total_ticket_price.dart';
import 'package:flutter/material.dart';

class BuyTicketsPage extends StatelessWidget {
  const BuyTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: height * 0.05,
          ),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
              SizedBox(
                width: width * 0.2,
              ),
              Text(
                "Select Seat",
                style: TextStyle(color: AppColor.lightRed, fontSize: 20),
              )
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          SeatKey(),
          SizedBox(
            height: height * 0.1,
          ),
          CurvedLine(),
          // SizedBox(
          //   height: height * 0.1,
          // ),
          Expanded(child: SeatLayout()),
          SizedBox(
            height: height * 0.05,
          ),

          SizedBox(
            height: height * 0.01,
          ),
          TotalTicketPrice()
        ],
      ),
    );
  }
}
