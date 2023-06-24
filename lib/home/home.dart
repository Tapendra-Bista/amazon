import 'package:amazon/common/flash.dart';
import 'package:amazon/constans/cons.dart';
import 'package:amazon/search/search.dart';
import 'package:flashtoast/flash_toast.dart';
import 'package:flutter/material.dart';
import '../catogory/cotogryapp.dart';
import '../common/appbar.dart';
import 'Carousel.dart';
import 'customlocation.dart';
import 'dealofday.dart';
import 'getapisell.dart';
import 'items.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
            controller.text =result.recognizedWords;
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
        body: RefreshIndicator(
          color: Globalvariable.selectednavbarcolor,
          onRefresh: () async {
            return await Future.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Customlocation(),

                changepage != null
                    ? Searchpage(
                        searchitem: onchange ?? "",
                      )
                    : const Homepartcustom(),
                // const Homepage(),
              ],
            ),
          ),
        ));
  }

  OutlineInputBorder custominput() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(9),
        borderSide: const BorderSide(color: Colors.black12, width: 1.5));
  }
}

class Homepartcustom extends StatelessWidget {
  const Homepartcustom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Catogory(),
          const SizedBox(
            height: 10,
          ),
          const CustomCarousel(),
          const SizedBox(
            height: 10,
          ),
          const DealofDay(),
          Itemcatory(
            itemscateroryname: "New",
            future: getdataapi(),
            itemcount: data,
          ),
          Itemcatory(
            itemscateroryname: "Fresh",
            future: freshitemFunction(),
            itemcount: freshitem,
          ),
          Itemcatory(
            itemscateroryname: "Expensive",
            future: expensiveitem(),
            itemcount: expensive,
          ),
          Itemcatory(
            itemscateroryname: "Cheap",
            future: cheapitem(),
            itemcount: cheap,
          ),
          Itemcatory(
            itemscateroryname: "Available",
            future: getavailabledata(),
            itemcount: available,
          ),
        ]);
  }
}
