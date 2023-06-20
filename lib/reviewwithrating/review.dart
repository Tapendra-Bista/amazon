import 'dart:convert';
import 'package:amazon/model/ratingm.dart';
import 'package:amazon/url/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

class ReviewandRating extends StatefulWidget {
  const ReviewandRating({super.key, required this.productid});
  final String productid;
  @override
  State<ReviewandRating> createState() => _ReviewandRatingState();
}

class _ReviewandRatingState extends State<ReviewandRating> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      width: double.infinity,
      child: FutureBuilder(
          future: getrating(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rating.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 3, bottom: 3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(rating[index].ratingGiver),
                              SizedBox(
                                height: 25,
                                width: 124,
                                child: RatingBarIndicator(
                                  rating: double.parse(rating[index].rating),
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 22.6,
                                  direction: Axis.horizontal,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(rating[index].review),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Column();
          })),
    );
  }

  // fresh items
  List<Rating> rating = [];

  Future<List<Rating>> getrating() async {
    var client = http.Client();
    var response = await client.get(
      Uri.parse("$ratingurl${widget.productid}"),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        rating.add(Rating.fromJson(index));
      }
    }
    rating.toSet();
    return rating;
  }

  @override
  void initState() {
    rating;
    getrating();
    super.initState();
  }
}
