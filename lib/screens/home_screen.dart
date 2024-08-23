import 'package:cricklyzer/Screens/calculate_pace.dart';
import 'package:cricklyzer/widgets/appbar.dart';
import 'package:cricklyzer/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cricklyzer/widgets/bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> imageUrls = [
    'https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_1200,q_50/lsci/db/PICTURES/CMS/383000/383003.jpg',
    'https://images.hindustantimes.com/img/2022/05/20/1600x900/image_-_2022-05-20T175125.385_1653049289821_1653049294581.jpg',
    'https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_1200,q_50/lsci/db/PICTURES/CMS/56500/56593.jpg',
    'https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_1200,q_50/lsci/db/PICTURES/CMS/95000/95077.jpg',
    'https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_960,q_50/lsci/db/PICTURES/CMS/105100/105142.jpg',
    'https://img1.hscicdn.com/image/upload/f_auto,t_ds_w_1200,q_50/lsci/db/PICTURES/CMS/383900/383994.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    const selectedIndex = 0;
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Text(
                      'Welcome, ${user?.displayName ?? "Guest User"}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  CarouselSlider.builder(
                    itemCount: imageUrls.length,
                    options: CarouselOptions(
                      height: MediaQuery.sizeOf(context).height*0.3,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      viewportFraction: 0.9,
                    ),
                    itemBuilder: (context, index, realIndex) {
                      final imageUrl = imageUrls[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Want to know your Pace?',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CalculatePace(),
                              ),
                            );
                          },
                          text: 'Calculate Pace',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavigationBar(selectedIndex: selectedIndex),
          ),
        ],
      ),
    );
  }
}

