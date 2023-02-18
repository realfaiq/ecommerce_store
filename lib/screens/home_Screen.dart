import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_store/utils/styles.dart';
import 'package:flutter/material.dart';

import '../widgets/homeCards.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List images = [
    'https://cdn.pixabay.com/photo/2017/12/26/09/15/woman-3040029_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/11/20/08/58/books-1842261_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/11/19/11/33/footwear-1838767_960_720.jpg'
  ];

  List categories = [
    "GROCERIES",
    "COSMETICS",
    "ELECTRONICS",
    "PHARMACY",
    "GARMENTS"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                  child: Text(
                'Home Screen',
                style: EcommerceStore.boldStyle,
              )),
              CarouselSlider(
                  items: images
                      .map((e) => Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      e,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      gradient: LinearGradient(colors: [
                                        Colors.blueAccent.withOpacity(0.3),
                                        Colors.redAccent.withOpacity(0.4)
                                      ])),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'TITLE',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ))
                      .toList(),
                  options: CarouselOptions(height: 200, autoPlay: true)),
              HomeCards(title: categories[0]),
              HomeCards(title: categories[1]),
              HomeCards(title: categories[2]),
              HomeCards(title: categories[3]),
              HomeCards(title: categories[4]),
            ],
          ),
        ),
      ),
    );
  }
}
