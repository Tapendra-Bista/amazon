import 'package:flutter/material.dart';

class Appbaritem2 extends StatelessWidget {
  const Appbaritem2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: Row(
        children: [
          RichText(
              text: const TextSpan(
                  text: "Hello",
                  style: TextStyle(fontSize: 25, color: Colors.black),
                  children: [
                TextSpan(
                  text: ",Tapendra",
                  style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                )
              ]))
        ],
      ),
    );
  }
}