import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class Swipewithimage extends StatefulWidget {
  const Swipewithimage({super.key, required this.image});
  final List<String> image;
  @override
  State<Swipewithimage> createState() => _SwipewithimageState();
}

class _SwipewithimageState extends State<Swipewithimage> {
    int imageindex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: []),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 300,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: Swiper(
            onIndexChanged: (value) {
              setState(() {
                imageindex = value;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Image.network((widget.image[imageindex]));
            },
            itemCount: widget.image.length,
            pagination: const SwiperPagination(),
          ),
        ));
  }
}
