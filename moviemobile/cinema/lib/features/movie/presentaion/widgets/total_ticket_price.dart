import 'package:cinema/core/constant/color.dart';
import 'package:cinema/features/movie/presentaion/widgets/buy_ticker.dart';
import 'package:flutter/material.dart';

class TotalTicketPrice extends StatelessWidget {
  const TotalTicketPrice({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      color: AppColor.lightPrimaryColor,
      padding: EdgeInsets.symmetric(
          vertical: 10), // Padding to move container closer to seats
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: width * 0.24,
                right:
                    10), // Adjusting left padding to create space for the image
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                Text(
                  "Joker", // Movie title
                  style: TextStyle(
                      color: AppColor.lightRed,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5), // Add space between the title and time
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Time: ',
                        style: TextStyle(
                          color: AppColor.lightRed,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Today 10:30 pm',
                        style: TextStyle(
                          color: AppColor.lightRed,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15), // Add space between the time and price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Ticket Price",
                          style: TextStyle(
                            color: AppColor.lightRed,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "300.00 ETB",
                          style: TextStyle(color: AppColor.lightRed),
                        ),
                      ],
                    ),
                    SizedBox(
                        width: width * 0.15), // Space between price and button
                    BuyTicker(
                      onPressed: () {},
                      text: "Book Now",
                      height: 0.05,
                      font: 15,
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            left: 5,
            top: -40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "assets/images/joker.jpg",
                fit: BoxFit.cover,
                width: width * 0.2,
                height: height * 0.12,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text('Image not found'),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
