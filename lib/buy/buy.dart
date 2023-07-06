import 'dart:convert';

import 'package:amazon/url/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import '../common/appbar.dart';
import '../common/buttonwithicon.dart';
import '../common/materialb.dart';
import '../common/textfield.dart';
import 'credit_card.dart';
import 'package:http/http.dart' as http;

class Buynow extends StatefulWidget {
  const Buynow(
      {super.key,
      required this.image,
      required this.id,
      required this.catergory,
      required this.productname,
      required this.discription,
      required this.price,
      required this.quantity,
      required this.cartquantity});
  final List<String> image;
  final String id;
  final String catergory;
  final String productname;
  final String discription;
  final String price;
  final String quantity;
  final int cartquantity;
  @override
  State<Buynow> createState() => _BuynowState();
}

class _BuynowState extends State<Buynow> {
  TextEditingController houseNumber = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController city = TextEditingController();
  bool isTrue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          // to maintained appbar hieght
          preferredSize: const Size.fromHeight(75),
          child: Customappbar(
              forappbar: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 55, left: 15),
                child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.black,
                    )),
              ),
            ],
          ))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Customtextfield(
                  boolvalue: false,
                  controller: houseNumber,
                  myhint: "Flat, House no.Building",
                  keyboardtype: TextInputType.multiline,
                ),
                const SizedBox(
                  height: 10,
                ),
                Customtextfield(
                  boolvalue: false,
                  controller: area,
                  myhint: "Area, Street",
                  keyboardtype: TextInputType.multiline,
                ),
                const SizedBox(
                  height: 10,
                ),
                Customtextfield(
                  boolvalue: false,
                  controller: pincode,
                  myhint: "Pincode",
                  keyboardtype: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                Customtextfield(
                  boolvalue: false,
                  controller: city,
                  myhint: "Town/City",
                  keyboardtype: TextInputType.multiline,
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonAndicon(
                  icon: const Icon(
                    Icons.apple,
                    size: 27,
                  ),
                  nameOfpay: "Pay",
                  width: double.infinity,
                  function: () {},
                  color: Colors.grey.shade100,
                  radius: 5,
                  borderclr: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                ButtonAndicon(
                  icon: Logo(
                    Logos.google,
                    size: 24,
                  ),
                  nameOfpay: "Pay",
                  width: double.infinity,
                  function: () {},
                  color: Colors.grey.shade100,
                  radius: 5,
                  borderclr: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                isTrue == true
                    ? Custommaterialbutton(
                        width: double.infinity,
                        function: () {
                          setState(() {
                            if (isTrue == false) {
                              isTrue = true;
                            } else {
                              isTrue = false;
                            }
                          });
                        },
                        name: "Cancel Payment",
                        color: Colors.redAccent,
                        borderclr: Colors.grey,
                        radius: 5)
                    : ButtonAndicon(
                        icon: Logo(
                          Logos.cc_visa,
                          size: 24,
                        ),
                        nameOfpay: "Pay",
                        width: double.infinity,
                        function: () {
                          setState(() {
                            if (isTrue == false) {
                              isTrue = true;
                            } else {
                              isTrue = false;
                            }
                          });
                        },
                        color: Colors.grey.shade100,
                        radius: 5,
                        borderclr: Colors.black,
                      ),
                isTrue == true
                    ? Credit(
                        function: () {
                          addOrder();
                          postAddress();
                        },
                      )
                    : const Row()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future postAddress() async {
    if (area.text.isNotEmpty &&
        city.text.isNotEmpty &&
        pincode.text.isNotEmpty &&
        houseNumber.text.isNotEmpty) {
      try {
        var body = {
          "userEmail": "tapendrabista01@gmail.com",
          "houseNumber": houseNumber.text,
          "area": area.text,
          "city": city.text,
          "pinCode": pincode.text,
        };
        var response = await http.post(
          Uri.parse(addressurl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        );
        if (response.statusCode == 200) {
          debugPrint(jsonDecode(response.body.toString()));
        }
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }

  Future addOrder() async {
    var bodypart = {
      "productnameId": widget.id,
      "productname": widget.productname,
      "usermail": "tapendrabista",
      "image": widget.image,
      "discription": widget.discription,
      "price": widget.price,
      "quantity": widget.quantity,
      "catergory": widget.catergory,
      "cartquantity": widget.cartquantity,
    };
    var response = await http.patch(
      Uri.parse(orderurl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bodypart),
    );
    if (response.statusCode == 200) {
      debugPrint(jsonDecode(response.body.toString()));
    }
  }
}
