import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema/core/constant/color.dart';
import 'package:cinema/features/movie/presentaion/widgets/movie_schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDisplayPage extends StatelessWidget {
  const MovieDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> movieList = [
      {
        'image': 'assets/images/joker.jpg',
        'name': 'Joker',
      },
      {
        'image': 'assets/images/deadpool_and_wolverine.jpg',
        'name': 'Deadpool & Wolverine',
      },
      {
        'image': 'assets/images/joker.jpg',
        'name': 'Joker',
      },
      {
        'image': 'assets/images/deadpool_and_wolverine.jpg',
        'name': 'Deadpool & Wolverine',
      },
    ];

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        leading: Icon(
          CupertinoIcons.bars,
          color: AppColor.lightRed,
        ),
        title: Text(
          'Cinema',
          style: TextStyle(color: AppColor.lightRed),
        ),
        centerTitle: true,
        actions: [
          Icon(
            CupertinoIcons.search,
            color: AppColor.lightRed,
          ),
          SizedBox(width: 10),
          Icon(
            CupertinoIcons.calendar,
            color: AppColor.lightRed,
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: height * 0.4,
                  enlargeCenterPage: true, // Enlarges the center image
                  viewportFraction: 0.6, // Show two images
                  onPageChanged: (index, reason) {
                    print('Current page index: $index');
                  },
                ),
                itemCount: movieList.length,
                itemBuilder: (context, index, realIndex) {
                  final movie = movieList[index];
                  return Column(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              movie['image']!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        movie['name']!,
                        style: TextStyle(
                          color: AppColor.lightRed,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Upcoming ",
                    style: TextStyle(color: AppColor.lightRed, fontSize: 20)),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return MovieSchedule();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
