import 'package:flutter/material.dart';

import '../rating/rating.dart';

class Upperpartdetails extends StatelessWidget {
  const Upperpartdetails({
    super.key,
    required this.id,
    required this.productid,
  });
  final String id;
  final String productid;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          id,
          style: TextStyle(
              letterSpacing: 0.1,
              fontSize: 14,
              color: Colors.black.withOpacity(0.6)),
        ),
        Container(
            height: 25,
            width: 170,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: CustomRating(
                productid: productid,
                size: 20,
              ),
            ))
      ],
    );
  }
}
