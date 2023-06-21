import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import '../model/ratingm.dart';
import '../url/url.dart';

class CustomRating extends StatefulWidget {
  const CustomRating({super.key, required this.size, required this.productid});
  final double size;
  final String productid;
  @override
  State<CustomRating> createState() => _CustomRatingState();
}

class _CustomRatingState extends State<CustomRating> {
  @override
  Widget build(BuildContext context) {
    return initialrating == 1
        ? FutureBuilder(
            future: getrating(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 25,
                  width: 124,
                  child: ListView.builder(
                      itemCount: 1,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RatingBarIndicator(
                          rating: sum / ratingget.length,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Color.fromRGBO(255, 193, 7, 1),
                          ),
                          itemCount: 5,
                          itemSize: widget.size,
                          direction: Axis.horizontal,
                        );
                      }),
                );
              } else {
                return const Row();
              }
            })
        : Initialrate(initialrating: initialrating, widget: widget);
  }

  List<Rating> ratingget = [];
  Future<List<Rating>> getrating() async {
    var client = http.Client();
    var response = await client.get(
      Uri.parse("$ratingurl${widget.productid}"),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        ratingget.add(Rating.fromJson(index));
        sum += double.parse(Rating.fromJson(index).rating);
      }
      debugPrint(sum.toString());
       debugPrint((sum/ratingget.length).toString());
    }

    if (response.statusCode == 404) {
      setState(() {
        initialrating = double.parse(data['rate']);
      });
    }

    return ratingget;
  }

  late var totalitem = ratingget.length;
  double initialrating = 1;
  @override
  void initState() {
    ratingget;
    getrating();

    super.initState();
  }

  double sum = 0;
  double averagerate = 0;
}

class Initialrate extends StatelessWidget {
  const Initialrate({
    super.key,
    required this.initialrating,
    required this.widget,
  });

  final double initialrating;
  final CustomRating widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 124,
      child: RatingBarIndicator(
        rating: initialrating,
        itemBuilder: (context, index) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: widget.size,
        direction: Axis.horizontal,
      ),
    );
  }
}
