import 'dart:convert';
import 'package:amazon/url/url.dart';
import 'package:flutter/material.dart';
import '../common/materialb.dart';
import '../model/total.dart';
import 'package:http/http.dart' as http;

class Upperpart extends StatefulWidget {
  const Upperpart({
    super.key, required this.function,
  });
  final Function() function;
  @override
  State<Upperpart> createState() => _UpperpartState();
}

class _UpperpartState extends State<Upperpart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: totalfun(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 1,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: RichText(
                            text: TextSpan(
                                text: "Subtotal : ",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w300),
                                children: [
                              TextSpan(
                                  text: list[index].amount.toString(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700))
                            ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, bottom: 15, right: 10),
                        child: Custommaterialbutton(
                            width: 380,
                            function: widget.function,
                            name: "Proceed to Buy (${list[index].items} items)",
                            color: Colors.amber,
                            borderclr: Colors.black,
                            radius: 8),
                      ),
                    ],
                  );
                });
          }
          {
            return const Center(child: Row());
          }
        });
  }

  // all items
  List<Totalmodel> list = [];

  Future<List<Totalmodel>> totalfun() async {
    try {
      var response = await http.get(
        Uri.parse(totalurl),
        headers: {"Content-Type": "application/json"},
      );
      var jsresponse = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        for (Map<String, dynamic> index in jsresponse) {
          list.add(Totalmodel.fromJson(index));
        }
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    return list;
  }
}
