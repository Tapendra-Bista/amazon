import 'dart:convert';
import 'package:amazon/cart/card.dart';
import 'package:amazon/constans/cons.dart';
import 'package:amazon/home/home.dart';
import 'package:amazon/person/person.dart';
import 'package:amazon/url/url.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:http/http.dart' as http;
import '../model/total.dart';

class Viewpageuser extends StatefulWidget {
  const Viewpageuser({super.key});

  @override
  State<Viewpageuser> createState() => _ViewpageuserState();
}

class _ViewpageuserState extends State<Viewpageuser> {
  List<Widget> items = [const Homepage(), const Personpage(), const Cardpage()];
  int index = 0;
  @override
  void initState() {
    cartnumber;
    cartfun();
    super.initState();
  }

// all items

  String? myresponse;
  List<Totalmodel> cartnumber = [];

  Future<List<Totalmodel>> cartfun() async {
    try {
      var response = await http.get(
        Uri.parse(totalurl),
        headers: {"Content-Type": "application/json"},
      );
      var jsresponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        for (Map<String, dynamic> index in jsresponse) {
          cartnumber.add(Totalmodel.fromJson(index));
        }
      }
      if (response.statusCode == 404) {
        setState(() {
          myresponse = jsresponse['message'];
        });
      
      }
         debugPrint(myresponse.toString());

    } catch (error) {
      debugPrint(error.toString());
    }

    return cartnumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[index],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
          selectedItemColor: Globalvariable.selectednavbarcolor,
          unselectedItemColor: Globalvariable.unselectednavbarcolor,
          backgroundColor: Globalvariable.backgroundcolor,
          iconSize: 28,
          items: [
            // for home
            BottomNavigationBarItem(
                label: "",
                icon: Container(
                  width: 42,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: index == 0
                                  ? Globalvariable.selectednavbarcolor
                                  : Globalvariable.backgroundcolor,
                              width: 5))),
                  child: const Icon(Icons.home_outlined),
                )),
            // for account
            BottomNavigationBarItem(
                label: "",
                icon: Container(
                  width: 42,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: index == 1
                                  ? Globalvariable.selectednavbarcolor
                                  : Globalvariable.backgroundcolor,
                              width: 5))),
                  child: const Icon(Icons.person_outline),
                )),
            // for card
            BottomNavigationBarItem(
                label: "",
                icon: Container(
                    width: 42,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: index == 2
                                    ? Globalvariable.selectednavbarcolor
                                    : Globalvariable.backgroundcolor,
                                width: 5))),
                    child:  myresponse!=null?  const Icon(Icons.shopping_cart_outlined) :FutureBuilder(
                        future: cartfun(),
                        builder: (
                          context,
                          snapshot,
                        ) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount:1,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => badges.Badge(
                                  badgeContent:
                                      Text(cartnumber[index].items.toString()),
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeColor: Colors.transparent),
                                  child:
                                      const Icon(Icons.shopping_cart_outlined)),
                            );
                          } else {
                            return const Row();
                          }
                        })))
          ]),
    );
  }
}
