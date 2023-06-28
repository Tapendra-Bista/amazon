import 'dart:convert';
import 'package:amazon/common/materialb.dart';
import 'package:amazon/model/cart.dart';
import 'package:amazon/url/url.dart';
import 'package:flashtoast/flash_toast.dart';
import 'package:flutter/material.dart';
import '../buycenter/details.dart';
import '../common/appbar.dart';
import '../common/flash.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:http/http.dart' as http;
import '../common/singlepro.dart';
import '../constans/cons.dart';
import '../home/customlocation.dart';
import '../rating/rating.dart';

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
    speech = stt.SpeechToText();
    super.initState();
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: RichText(
                  text: const TextSpan(
                      text: "Subtotal",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w300),
                      children: [
                    TextSpan(
                        text: "\t\$1100",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w700))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 15, right: 10),
              child: Custommaterialbutton(
                  width: 380,
                  function: () {},
                  name: "Proceed to Buy (1 items)",
                  color: Colors.amber,
                  borderclr: Colors.black,
                  radius: 8),
            ),
            responsestring2 != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 700),
                      child: Text(
                        responsestring2 ?? "",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                          future: cartproductFunction(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SizedBox(
                                height: 1100,
                                width: double.infinity,
                                child: ListView.builder(
                                    itemCount: cartproduct.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Details(
                                                        id: cartproduct[index]
                                                            .id,
                                                        catergory:
                                                            cartproduct[index]
                                                                .catergory,
                                                        productname:
                                                            cartproduct[index]
                                                                .productname,
                                                        discription:
                                                            cartproduct[index]
                                                                .discription,
                                                        price:
                                                            cartproduct[index]
                                                                .price,
                                                        qantity:
                                                            cartproduct[index]
                                                                .qantity,
                                                        image:
                                                            cartproduct[index]
                                                                .image)));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 210,
                                                    width: 200,
                                                    child: Singleproduct(
                                                        imagewidget: Image
                                                            .network((cartproduct[
                                                                    index]
                                                                .image[0]
                                                                .toString()))),
                                                  ),
                                                  Container(
                                                    height: 210,

                                                    width: 190,

                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),

                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors
                                                                .transparent),

                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          cartproduct[index]
                                                              .productname,
                                                          style: TextStyle(
                                                              fontSize: 19,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6)),
                                                          maxLines: 3,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        CustomRating(
                                                          productid:
                                                              cartproduct[index]
                                                                  .id,
                                                          size: 25,
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "\$${cartproduct[index].price}",
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                            "Eligible for FREE Shipping",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.8))),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                            int.parse(cartproduct[index]
                                                                            .qantity)
                                                                        .toInt() !=
                                                                    0
                                                                ? "In Stock"
                                                                : "Out Stock",
                                                            style: TextStyle(
                                                                fontSize: 19,
                                                                color: int.parse(cartproduct[index].qantity)
                                                                            .toInt() !=
                                                                        0
                                                                    ? Globalvariable
                                                                        .selectednavbarcolor
                                                                    : Colors
                                                                        .red)),
                                                      ],
                                                    ),

                                                    // color: Colors.transparent),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30,
                                                    top: 12,
                                                    bottom: 10),
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  height: 50,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .transparent
                                                              .withOpacity(0.2),
                                                          width: 2),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9),
                                                      color: Colors.transparent
                                                          .withOpacity(0.2)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Icon(
                                                        Icons.remove,
                                                        size: 24,
                                                      ),
                                                      Container(
                                                          height: 48,
                                                          width: 52,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              color:
                                                                  Colors.white),
                                                          child: const Center(
                                                              child: Text(
                                                            "1",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 20),
                                                          ))),
                                                      const Icon(
                                                        Icons.add,
                                                        size: 24,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            } else {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 60,
                                  ),
                                  Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Globalvariable.selectednavbarcolor),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }

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
        cartproduct.add(Cartmodel.fromJson(index));
      }
    }
    if (response.statusCode == 404) {
      responsestring2 = data['message'];

      debugPrint(" this for cart response${responsestring2.toString()}");
    }
    return cartproduct;
  }
}
