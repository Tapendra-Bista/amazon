import 'package:amazon/constans/cons.dart';
import 'package:flutter/material.dart';
import 'adminhome/adminhome.dart';
class Adminmainpage extends StatefulWidget {
  const Adminmainpage({super.key});

  @override
  State<Adminmainpage> createState() => _AdminmainpageState();
}

class _AdminmainpageState extends State<Adminmainpage> {
  List<Widget> items = [
    const Adimhomepage(),
    const Adimhomepage(),
    const Adimhomepage(),
  ];
  int index = 0;
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
            // for analytics
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
                  child: const Icon(Icons.analytics_outlined),
                )),
            // for  all_inbox
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
                  child: const Icon(Icons.all_inbox_outlined),
                ))
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/createpage");
        },
        tooltip: "add a product",
        child: const Icon(Icons.add),
      ),
    );
  }
}
