import 'dart:convert';
import 'package:amazon/common/expandtextfield.dart';
import 'package:amazon/common/flash.dart';
import 'package:amazon/common/materialb.dart';
import 'package:amazon/constans/cons.dart';
import 'package:amazon/url/url.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flashtoast/flash_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../common/appbar.dart';
import '../divider/divider.dart';
import 'package:http/http.dart' as http;
import '../home/items.dart';
import '../model/sell.dart';
import '../rating/rating.dart';
import '../reviewwithrating/review.dart';
import '../search/search.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:share_plus/share_plus.dart';

class Details extends StatefulWidget {
  const Details(
      {super.key,
      required this.id,
      required this.catergory,
      required this.productname,
      required this.discription,
      required this.price,
      required this.qantity,
      required this.image});

  final List<String> image;
  final String id;
  final String catergory;
  final String productname;
  final String discription;
  final String price;
  final String qantity;
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  Future addcart() async {
    var bodypart = {
      "productname": widget.productname,
      "usermail": "tapendrabista",
      "image": widget.image,
      "discription": widget.discription,
      "price": widget.price,
      "qantity": widget.qantity,
      "catergory": widget.catergory,
      "cartqauntity": quantity.toString()
    };
    var response = await http.post(
      Uri.parse(carturl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bodypart),
    );
    if (response.statusCode == 200) {
    
    }
  }

  TextEditingController controller = TextEditingController();
  late stt.SpeechToText speech;
  bool enablespeech = false;

  onListen(context) async {
    if (!enablespeech) {
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
          enablespeech = true;
        });
        speech.listen(
          onResult: (result) => setState(() {
            change1 = result.recognizedWords;
            changepage1 = result.recognizedWords;
            controller.text = result.recognizedWords;
            debugPrint(result.recognizedWords);
          }),
        );
      }
    } else {
      setState(() {
        enablespeech = false;
        speech.stop();
      });
    }
  }

  String? changepage1;
  String? change1;
  @override
  void initState() {
    speech = stt.SpeechToText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, "/Viewpageuser");
                      },
                      child: const Icon(
                        CupertinoIcons.back,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 50,
                      width: 257,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.transparent),
                      child: TextFormField(
                        controller: controller,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              changepage1 = value;
                            });
                          } else {
                            setState(() {
                              changepage1 = null;
                            });
                          }
                        },
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              change1 = value;
                            });
                          } else {
                            setState(() {
                              change1 = null;
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
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 0.5,
                    ),
                    IconButton(
                        onPressed: () => onListen(context),
                        icon: const Icon(
                          Icons.mic,
                          size: 25,
                        ))
                  ],
                ),
              )
            ],
          ))),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: changepage1 != null ? 0 : 10),
        child: SingleChildScrollView(
          child: changepage1 != null
              ? Searchpage(
                  searchitem: change1 ?? "",
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.id,
                          style: TextStyle(
                              letterSpacing: 0.1,
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        Container(
                            height: 25,
                            width: 170,
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: CustomRating(
                                productid: widget.id,
                                size: 20,
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      widget.productname,
                      style: TextStyle(
                          letterSpacing: 0.1,
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.9)),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 280),
                      child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            shared();
                          },
                          icon: const Icon(
                            Icons.share,
                            color: Colors.black,
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 300,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.white, boxShadow: []),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 300,
                          width: double.infinity,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Swiper(
                            onIndexChanged: (value) {
                              setState(() {
                                imageindex = value;
                              });
                            },
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network((widget.image[imageindex]));
                            },
                            itemCount: widget.image.length,
                            pagination: const SwiperPagination(),
                          ),
                        )),
                    const Customdivider(),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "Deal Price:",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                wordSpacing: 1),
                            children: [
                          TextSpan(
                              text: " \$${widget.price}",
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                  wordSpacing: 1)),
                          TextSpan(
                            text: "\nTotal quantity : ${widget.qantity}",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                wordSpacing: 1),
                          ),
                          TextSpan(
                              text: int.parse(widget.qantity).toInt() == 0
                                  ? "\nOut Stock"
                                  : "\nIn Stock",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: int.parse(widget.qantity).toInt() == 0
                                      ? Colors.red
                                      : Globalvariable.selectednavbarcolor,
                                  fontWeight: FontWeight.w700,
                                  wordSpacing: 1)),
                          TextSpan(
                              text: "\n\n${widget.discription}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.7),
                                  wordSpacing: 1)),
                        ])),
                    const Customdivider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Custommaterialbutton(
                        width: double.infinity,
                        function: () {},
                        name: "Buy Now",
                        color: Globalvariable.secondarycolor,
                        borderclr: Colors.black,
                        radius: 9),
                    const SizedBox(
                      height: 15,
                    ),
                    Custommaterialbutton(
                        width: double.infinity,
                        function: () {
                          addcart();
                          setState(() {
                            quantity++;
                          });
                        },
                        name: "Add to Cart",
                        color: Colors.yellow.shade500,
                        borderclr: Colors.black,
                        radius: 9),
                    const SizedBox(
                      height: 10,
                    ),
                    const Customdivider(),
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "Rate The Product",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                    ),
                    RatingBar.builder(
                        tapOnlyMode: true,
                        itemPadding: const EdgeInsets.only(top: 5),
                        initialRating: rate,
                        maxRating: 5,
                        minRating: 1,
                        itemSize: 28,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        unratedColor: Colors.grey,
                        itemBuilder: (context, index) {
                          return const Icon(
                            Icons.star_outlined,
                            color: Colors.amber,
                          );
                        },
                        onRatingUpdate: (change) {
                          setState(() {
                            rate = change;
                          });
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Customexpandtext(
                        controller: _reviewgive, hinttext: "review"),
                    const SizedBox(
                      height: 10,
                    ),
                    Custommaterialbutton(
                        width: double.infinity,
                        function: () {
                          ratingfunction(context);
                        },
                        name: "Submit",
                        color: Globalvariable.secondarycolor,
                        borderclr: Colors.black,
                        radius: 9),
                    const SizedBox(
                      height: 10,
                    ),
                    const Customdivider(),
                    const Center(
                        child: Text(
                      "CUSTOMER REVIEWS",
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    ReviewandRating(
                      productid: widget.id,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Customdivider(),
                    const SizedBox(
                      height: 30,
                    ),
                    Itemcatory(
                      itemscateroryname: "YOU MIGHT LIKE THIS",
                      future: similaritemsFunction(),
                      itemcount: similaritems,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  late var productid = widget.id;
  OutlineInputBorder custominput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Colors.black12, width: 1.5));
  }

  final TextEditingController _reviewgive = TextEditingController();
  double rate = 0;
  int imageindex = 0;

  // api for rating
  Future ratingfunction(context) async {
    if (_reviewgive.text.isNotEmpty) {
      var body = {
        "productid": productid,
        "rating": rate,
        "ratingGiver": "tapendrabista01@gmail.com",
        "review": _reviewgive.text,
      };
      try {
        var response = await http.post(Uri.parse(ratingurl),
            body: jsonEncode(body),
            headers: {"Content-Type": "application/json"});
        if (response.statusCode == 200) {
          _reviewgive.clear();
          setState(() {
            rate = 0;
          });
          flashfunction(
              context, "Review", "successfully reviewed", FlashType.success);
        }
      } catch (error) {
        debugPrint(error.toString());
      }
    } else {
      flashfunction(context, "Invalid", "at least one rating with review",
          FlashType.error);
    }
  }

  // we might like this
  List<Sellmodel> similaritems = [];
  Future<List<Sellmodel>> similaritemsFunction() async {
    var url = "$getreqdataurl${widget.catergory}";
    var response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        similaritems.add(Sellmodel.fromJson(index));
      }
    }
    similaritems.toSet();
    return similaritems;
  }

  Future shared() async {
    await Share.share(
        "\n${widget.productname}\n\n ${widget.image}\n\n ${widget.discription}",
        subject: "share");
  }
}
