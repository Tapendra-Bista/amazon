import 'package:flutter/material.dart';

import '../common/materialb.dart';

class Personbutton extends StatelessWidget {
  const Personbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Custommaterialbutton(
                width: 170,
                borderclr: Colors.black.withOpacity(0.3),
                radius: 100,
                function: () {},
                name: "Your Orders",
                color: const Color(0xFFF5F4F6)),
            Custommaterialbutton(
                width: 170,
                borderclr: Colors.black.withOpacity(0.3),
                radius: 100,
                function: () {},
                name: "Turn Seller",
                color: const Color(0xFFF5F4F6))
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Custommaterialbutton(
                width: 170,
                borderclr: Colors.black.withOpacity(0.3),
                radius: 100,
                function: () {},
                name: "Log Out",
                color: const Color(0xFFF5F4F6)),
            Custommaterialbutton(
                width: 170,
                borderclr: Colors.black.withOpacity(0.3),
                radius: 100,
                function: () {},
                name: "Your Wish List",
                color: const Color(0xFFF5F4F6))
          ],
        ),
      ],
    );
  }
}
