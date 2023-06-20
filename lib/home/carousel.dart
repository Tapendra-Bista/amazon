
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constans/cons.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: Globalvariable.carouselImages
            .map((e) => Builder(builder: (context) {
                  return Image.network(
                    e,
                    fit: BoxFit.cover,
                    height: 200,
                  );
                }))
            .toList(),
        options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(milliseconds: 500),
            viewportFraction: 1,
            height: 200));
  }
}
