import 'dart:convert';
import 'package:amazon/common/flash.dart';
import 'package:amazon/constans/cons.dart';
import 'package:amazon/url/url.dart';
import 'package:flashtoast/flash_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../common/appbar.dart';
import '../../common/expandtextwithvalid.dart';
import '../../common/materialb.dart';
import "package:http/http.dart" as http;
import '../../common/textwithvalid.dart';

class Editsell extends StatefulWidget {
  const Editsell(
      {super.key,
      required this.itemname,
      required this.itemprice,
      required this.itemquantity,
      required this.itemdiscription,
      required this.id});

  final String itemname;
  final String itemprice;
  final String itemquantity;
  final String itemdiscription;
  final String id;
  @override
  State<Editsell> createState() => _EditsellState();
}

class _EditsellState extends State<Editsell> {
  late String sellid = widget.id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(

          // to maintained appbar hieght
          preferredSize: const Size.fromHeight(85),
          child: Customappbar(
            forappbar: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10)
                          .copyWith(top: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              CupertinoIcons.back,
                              size: 26,
                            )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 45, left: 120),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Edit item",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 15,
              ),
              Customfieldwithinitialvalue(
                  onChanged: (String value) {
                    setState(() {
                      newname = value;
                    });
                  },
                  initalvalue: widget.itemname,
                  keyboardtype: TextInputType.multiline,
                  boolvalue: false),
              const SizedBox(
                height: 15,
              ),
              Customexpandedtextwithvalid(
                onChanged: (String value) {
                  setState(() {
                    newdiscription = value;
                  });
                },
                initial: widget.itemdiscription,
              ),
              const SizedBox(
                height: 15,
              ),
              Customfieldwithinitialvalue(
                  onChanged: (String value) {
                    setState(() {
                      newprice = value;
                    });
                  },
                  initalvalue: widget.itemprice,
                  keyboardtype: TextInputType.number,
                  boolvalue: false),
              const SizedBox(
                height: 15,
              ),
              Customfieldwithinitialvalue(
                  onChanged: (String value) {
                    setState(() {
                      newquantity = value;
                    });
                  },
                  initalvalue: widget.itemquantity,
                  keyboardtype: TextInputType.number,
                  boolvalue: false),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(7)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    iconEnabledColor: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    menuMaxHeight: 285,
                    dropdownColor: Globalvariable.backgroundcolor,
                    value: curentcatergory,
                    items: category
                        .map<DropdownMenuItem<String>>((String myvalue) =>
                            DropdownMenuItem<String>(
                              value: myvalue,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 11),
                                child: Center(
                                  child: Text(
                                    myvalue,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (mydropstring) {
                      setState(() {
                        curentcatergory = mydropstring ?? "";
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Custommaterialbutton(
                  width: double.infinity,
                  function: () {
                   
                      patchsell(context);
                   
                  },
                  name: 'Edit',
                  color: Globalvariable.secondarycolor,
                  borderclr: Colors.black.withOpacity(0.3),
                  radius: 7)
            ],
          ),
        ),
      ),
    );
  }
  // function

  String curentcatergory = "Catergory";
  List<String> category = [
    "Catergory",
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];

//  post data for sell
  String newname = "";
  String newprice = "";
  String newdiscription = "";
  String newquantity = "";
  Future patchsell(context) async {
    var client = http.Client();
    var sellboby = {
      "productname": newname,
      "discription": newdiscription,
      "price": newprice,
      "quantity": newquantity,
      "catergory": curentcatergory,
    };
    var response = await client.patch(
      Uri.parse("$patchsellurl/$sellid"),
      body: jsonEncode(sellboby),
      headers: {"Content-Type": "application/json"},
    );
    // var jsresponse = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      flashfunction(
          context, "Sell Item", "edit successfully", FlashType.success);
      Navigator.pushReplacementNamed(context, "/");
    } else {
      flashfunction(context, "Invalid", "Invalid error", FlashType.error);
    }
  }


}
