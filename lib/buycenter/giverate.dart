import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Giverate extends StatefulWidget {
  const Giverate({super.key, required this.rate, required this.onratingupdate});
  final double rate;
  final Function( double change) onratingupdate;
  @override
  State<Giverate> createState() => _GiverateState();
}

class _GiverateState extends State<Giverate> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      tapOnlyMode: true,
      itemPadding: const EdgeInsets.only(top: 5),
      initialRating: widget.rate,
      maxRating: 5,
      minRating: 1,
      itemSize: 28,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.grey,
      itemBuilder: (context, index) {
        return const Icon(
          Icons.star_outlined,
          color: Colors.amber,
        );
      },
      onRatingUpdate:widget.onratingupdate,
    );
  }
}
