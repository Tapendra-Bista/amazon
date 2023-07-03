import 'package:flutter/material.dart';
import '../constans/cons.dart';

class Textdata extends StatelessWidget {
  const Textdata({super.key, required this.discription, required this.price, required this.quantity});

  final String discription;
  final String price;
  final String quantity;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Deal Price:",
            style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                wordSpacing: 1),
            children: [
          TextSpan(
              text: " \$$price",
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  wordSpacing: 1)),
          TextSpan(
            text: "\nTotal quantity : $quantity",
            style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w700,
                wordSpacing: 1),
          ),
          TextSpan(
              text: int.parse(quantity).toInt() == 0
                  ? "\nOut Stock"
                  : "\nIn Stock",
              style: TextStyle(
                  fontSize: 18,
                  color: int.parse(quantity).toInt() == 0
                      ? Colors.red
                      : Globalvariable.selectednavbarcolor,
                  fontWeight: FontWeight.w700,
                  wordSpacing: 1)),
          TextSpan(
              text: "\n\n$discription",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.7),
                  wordSpacing: 1)),
        ]));
  }
}
