import 'dart:convert';
import 'package:amazon/cart/upperpart.dart';
import 'package:amazon/model/cart.dart';
import 'package:amazon/url/url.dart';
import 'package:flashtoast/flash_toast.dart';
import 'package:flutter/material.dart';
import '../common/appbar.dart';
import '../common/flash.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../home/customlocation.dart';
import '../search/search.dart';
import 'cartmain.dart';

int? cartproductnumber;

class Cardpage extends StatefulWidget {
  const Cardpage({super.key});

  @override
  State<Cardpage> createState() => _CardpageState();
}

class _CardpageState extends State<Cardpage> {
  late stt.SpeechToText speech;
  bool speechEnabled = false;

  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
    cartproductFunction();
    cartproduct;
    makerequal(sum, cartproduct.length);
  }

  onListen(context) async {
    if (!speechEnabled) {
      bool available = await speech.initialize(
        onStatus: (status) {
          debugPrint(status);
        },
        onError: (errorNotification) {
          debugPrint(errorNotification.toString());
        },
      );
      if (available) {
        flashfunction(
            context, "Mic On", "Search with your voice", FlashType.success);
        setState(() {
          speechEnabled = true;
        });
        speech.listen(
          onResult: (result) => setState(() {
            onchange = result.recognizedWords;
            changepage = result.recognizedWords;
            controller.text = result.recognizedWords;
            debugPrint(result.recognizedWords);
          }),
        );
      }
    } else {
      setState(() {
        speechEnabled = false;
        speech.stop();
      });
    }
  }

  String? onchange;
  String? changepage;
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
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 23, right: 23),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 298,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.transparent),
                      child: TextFormField(
                        controller: controller,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              changepage = value;
                            });
                          } else {
                            setState(() {
                              changepage = null;
                            });
                          }
                        },
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              onchange = value;
                            });
                          } else {
                            setState(() {
                              onchange = null;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "Search Amazon.in",
                            hintStyle: const TextStyle(fontSize: 18),
                            enabledBorder: custominput(),
                            focusedBorder: custominput(),
                            errorBorder: custominput(),
                            disabledBorder: custominput(),
                            focusedErrorBorder: custominput(),
                            filled: true,
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            prefixIcon: const InkWell(
                              child: Icon(
                                Icons.search_outlined,
                                color: Colors.black87,
                              ),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 0.5,
                    ),
                    IconButton(
                        onPressed: () => onListen(context),
                        tooltip: "Search with your voice",
                        icon: const Icon(
                          Icons.mic,
                          size: 25,
                        ))
                  ],
                ),
              )
            ],
          ))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Customlocation(),
            changepage != null
                ? Searchpage(
                    searchitem: onchange ?? "",
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      responsestring2 != null ||
                              cartproductnumber == 0 ||
                              cartproductnumber == null ||
                              cartproduct.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 300, left: 100),
                              child: Text(
                                " Add Products in a cart!",
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Upperpart(
                                  number: cartproduct.length,
                                  function: () {},
                                  totalamout: "\t\$$sum",
                                ),
                                Maindata(
                                  future: cartproductFunction(),
                                  itemcount: cartproduct,
                                ),
                              ],
                            ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  int sum = 0;
  OutlineInputBorder custominput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Colors.black12, width: 1.5));
  }

  String? responsestring2;
  List<Cartmodel> cartproduct = [];
  Future<List<Cartmodel>> cartproductFunction() async {
    var response = await http.get(
      Uri.parse(
        carturl,
      ),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        sum += int.parse(Cartmodel.fromJson(index).price) *
            Cartmodel.fromJson(index).cartqauntity;

        cartproduct.add(Cartmodel.fromJson(index));
      }
    }
    if (response.statusCode == 404) {
      setState(() {
        responsestring2 = data['message'];
      });

      debugPrint(" this for cart response${responsestring2.toString()}");
    }
    makerequal(sum, cartproduct.length);
    debugPrint(" total sum is $sum");
    debugPrint(" total cart number is $cartproductnumber");

    return cartproduct;
  }

  makerequal(int x, int y) {
   setState(() {
      totalsum = x;
    cartproductnumber = y;
   });
  }

  int? totalsum;
}
