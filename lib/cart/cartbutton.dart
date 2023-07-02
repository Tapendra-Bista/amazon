import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../url/url.dart';
import 'dart:convert';

class Quantitybutton extends StatefulWidget {
  const Quantitybutton(
      {super.key, required this.number, required this.productname});

  final int number;
  final String productname;
  @override
  State<Quantitybutton> createState() => _QuantitybuttonState();
}

class _QuantitybuttonState extends State<Quantitybutton> {
  late int quantity = widget.number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, top: 12, bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 50,
        width: 145,
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.black12.withOpacity(0.2), width: 2),
            borderRadius: BorderRadius.circular(9),
            color: Colors.black12.withOpacity(0.2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => {
                setState(() {
                  quantity--;

                  decrementfunction();
                }),
              },
              child: const Icon(
                Icons.remove,
                size: 24,
              ),
            ),
            Container(
                height: 48,
                width: 52,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white),
                child: Center(
                    child: Text(
                  quantity.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ))),
            InkWell(
              onTap: () => {
                setState(() {
                   quantity++;
                  incrementfunction();
                }),
              },
              child: const Icon(
                Icons.add,
                size: 24,
              ),
            )
          ],
        ),
      ),
    );
  }

  // increment or decrement
  Future incrementfunction() async {
    var body = {
      "productname": widget.productname,
    };
    debugPrint("productname is ${widget.productname}");
    try {
      var response = await http.patch(Uri.parse(incrementurl),
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        debugPrint("increment");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  //
  Future decrementfunction() async {
    var body = {
      "productname": widget.productname,
    };
    debugPrint("productname is ${widget.productname}");
    try {
      var response = await http.patch(Uri.parse(decrementurl),
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        debugPrint("decrement");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
