import 'package:cinema/core/constant/color.dart';
import 'package:cinema/features/movie/presentaion/widgets/buy_ticker.dart';
import 'package:cinema/features/movie/presentaion/widgets/price_show.dart';
import 'package:cinema/features/movie/presentaion/widgets/trailer_button.dart';
import 'package:flutter/material.dart';

class MovieSchedule extends StatelessWidget {
  const MovieSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.23,
      width: width * 0.9,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/images/joker.jpg",
                  fit: BoxFit.cover,
                  width: width * 0.26,
                  height: height * 0.16,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text('Image not found'),
                    );
                  },
                ),
              ),
              SizedBox(width: width * 0.07),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Joker", // Movie title
                      style: TextStyle(
                          color: AppColor.lightRed,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: height * 0.01),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Genre: ', 
                            style: TextStyle(
                              color: AppColor.lightRed,
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.bold, 
                            ),
                          ),
                          TextSpan(
                            text:
                                'Action, Adventure', 
                            style: TextStyle(
                              color: AppColor.lightRed,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.007),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Duration: ', 
                            style: TextStyle(
                              color: AppColor.lightRed,
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.bold, 
                            ),
                          ),
                          TextSpan(
                            text: '2h 2m',
                            style: TextStyle(
                              color: AppColor.lightRed,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.007),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Time: ', 
                            style: TextStyle(
                              color: AppColor.lightRed,
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.bold, 
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
                    SizedBox(height: height * 0.025),
                    Row(
                      children: [
                        TrailerButton(
                          onPressed: () {},
                        ),
                        SizedBox(width: 10),
                        BuyTicker(onPressed: () {}, text: "Buy Ticket"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 5,
            right: 5,
            child: PriceShow(),
          ),
        ],
      ),
    );
  }
}
