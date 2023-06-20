import 'package:flutter/material.dart';

class Appbaritem1 extends StatelessWidget {
  const Appbaritem1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "image/amazon_in.png",
            width: 100,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_outlined,
                      size: 28,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_outlined,
                      size: 28,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
