import 'package:amazon/constans/cons.dart';
import 'package:flutter/material.dart';

import '../appbaritem/item1.dart';
import '../appbaritem/item2.dart';
import '../common/appbar.dart';
import '../common/singlepro.dart';
import 'button.dart';

class Personpage extends StatefulWidget {
  const Personpage({super.key});

  @override
  State<Personpage> createState() => _PersonpageState();
}

class _PersonpageState extends State<Personpage> {
  List list = [
    "image/am.png",
    "image/am.png",
    "image/am.png",
    "image/am.png",
    "image/am.png",
    "image/am.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          // to maintained appbar hieght
          preferredSize: Size.fromHeight(85),
          child: Customappbar(
            forappbar: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Appbaritem1(), Appbaritem2()],
            ),
          )),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Personbutton(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Your Orders",
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "See all",
                            style: TextStyle(
                                fontSize: 18,
                                color: Globalvariable.selectednavbarcolor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 10, right: 0),
                    height: 180,
                    child: ListView.builder(
                        itemCount: list.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Singleproduct(
                            imagewidget: Image.asset(
                              list[index],
                              fit: BoxFit.fitWidth,
                              width: 180,
                            ),
                          );
                        }),
                  )
                ],
              ))),
    );
  }
}
