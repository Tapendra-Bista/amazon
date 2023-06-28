import 'dart:convert';
import 'package:amazon/constans/cons.dart';
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
                return Container(
                  height: 25,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: ListView.builder(
                      itemCount: 1,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RatingBarIndicator(
                              rating: sum / ratingget.length,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Color.fromRGBO(255, 193, 7, 1),
                              ),
                              itemCount: 5,
                              itemSize: widget.size,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "$totalitem",
                              style: TextStyle(
                                  color: Globalvariable.selectednavbarcolor),
                            ),
                          ],
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
