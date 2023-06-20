
import 'package:flutter/material.dart';

class Customlocation extends StatelessWidget {
  const Customlocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      height: 40,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 114, 226, 221),
        Color.fromARGB(255, 162, 236, 233),
      ], stops: [
        0.5,
        1.0
      ])),
      child: const Row(
        children: [
          Icon(Icons.location_on_outlined),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text(
              "Delivary to Nepal",
              style: TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          )),
          Padding(
            padding: EdgeInsets.only(left: 3, top: 5, right: 5),
            child: Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.black,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
