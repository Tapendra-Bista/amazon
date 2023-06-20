import 'package:flutter/material.dart';

class Customfooter extends StatelessWidget {
  const Customfooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: const TextSpan(
            text: "Condition of Use",
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w500, color: Colors.blue),
            children: [
          TextSpan(
            text: "      Privacy Notice",
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w500, color: Colors.blue),
          ),
          TextSpan(
            text: "       Help",
            style: TextStyle(
                fontSize: 19, fontWeight: FontWeight.w500, color: Colors.blue),
          ),
          TextSpan(
            text: "\n\n© 1996-2023, Amazon.com,Inc. or its affiliatess",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ]));
  }
}
