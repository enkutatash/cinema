import 'package:cinema/core/constant/color.dart';
import 'package:cinema/features/movie/domain/entity/movie_entity.dart';
import 'package:cinema/features/movie/presentaion/widgets/buy_ticker.dart';
import 'package:cinema/features/movie/presentaion/widgets/price_show.dart';
import 'package:cinema/features/movie/presentaion/widgets/video_play.dart';
import 'package:flutter/material.dart';

class MovieDetailPage extends StatelessWidget {
  MovieEntity movie;
   MovieDetailPage({required this.movie,super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                   movie.poster,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: height * 0.45,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text('Image not found'),
                      );
                    },
                  ),
                ),
                Positioned(
                  left: 30,
                  bottom: 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PriceShow(
                        isFull: true,
                      ),
                       Text(
                        movie.title, // Movie title
                        style: TextStyle(
                            color: AppColor.lightRed,
                            fontSize: 45,
                            fontWeight: FontWeight.w400),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Genre: ',
                              style: TextStyle(
                                color: AppColor.lightRed,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             TextSpan(
                              text: movie.genre, // Movie genre
                              style: TextStyle(
                                color: AppColor.lightRed,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 20,
                    bottom: -25,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return VideoApp();
                          },
                        );
                      },
                      icon: Icon(
                        Icons.play_circle_fill,
                        size: 50,
                        color: AppColor.lightRed,
                      ),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Description",
                style: TextStyle(
                  color: AppColor.lightRed,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.002,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              child:  Text(
               movie.description, // Movie description
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.lightRed),
              ),
            ),
            SizedBox(
              height: height * 0.002,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Cast",
                style: TextStyle(
                  color: AppColor.lightRed,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.002,
            ),
            SizedBox(
              height: height * 0.15,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/joker_cast2.webp"),
                        ),
                        const SizedBox(height: 5),
                        const Text("Scarlett Johansson"),
                        const Text("Natasha Romanoff"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: BuyTicker(
            onPressed: () {},
            text: "Buy Tickets",
            height: 0.06,
            font: 30,
          )),
    );
  }
}
