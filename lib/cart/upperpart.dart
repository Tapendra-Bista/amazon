import 'package:flutter/material.dart';
import '../common/materialb.dart';

class Upperpart extends StatelessWidget {
  const Upperpart(
      {super.key,
      required this.totalamout,
      required this.function,
      required this.number});
  final String totalamout;
  final Function() function;
  final int number;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: RichText(
              text: TextSpan(
                  text: "Subtotal",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w300),
                  children: [
                TextSpan(
                    text: totalamout,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700))
              ])),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 15, right: 10),
          child: Custommaterialbutton(
              width: 380,
              function: function,
              name: "Proceed to Buy ($number items)",
              color: Colors.amber,
              borderclr: Colors.black,
              radius: 8),
        ),
      ],
    );
  }
}
