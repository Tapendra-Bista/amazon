import 'dart:convert';
import 'package:amazon/admin/editsell/edit.dart';
import 'package:amazon/common/flash.dart';
import 'package:amazon/constans/cons.dart';
import 'package:amazon/model/sell.dart';
import 'package:amazon/url/url.dart';
import 'package:flashtoast/flash_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../common/appbar.dart';
import '../../common/singlepro.dart';

class Adimhomepage extends StatefulWidget {
  const Adimhomepage({super.key});

  @override
  State<Adimhomepage> createState() => _AdimhomepageState();
}

class _AdimhomepageState extends State<Adimhomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          // to maintained appbar hieght
          preferredSize: const Size.fromHeight(85),
          child: Customappbar(
            forappbar: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10)
                      .copyWith(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "image/amazon_in.png",
                        width: 150,
                      ),
                      const Text(
                        "Admin",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
      body: FutureBuilder(
        future: getsell(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: sellitems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 7, crossAxisSpacing: 0),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10)
                        .copyWith(top: 10),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Your Item"),
                                  titlePadding: const EdgeInsets.symmetric(
                                      horizontal: 100),
                                  actions: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => Editsell(
                                                              id: sellitems[
                                                                      index]
                                                                  .id,
                                                              itemname: sellitems[
                                                                      index]
                                                                  .productname,
                                                              itemprice:
                                                                  sellitems[
                                                                          index]
                                                                      .price,
                                                              itemqantity:
                                                                  sellitems[
                                                                          index]
                                                                      .qantity,
                                                              itemdiscription:
                                                                  sellitems[
                                                                          index]
                                                                      .discription)));
                                                },
                                                icon: const Icon(
                                                    Icons.edit_document)),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    deletesell(
                                                        sellitems[index]
                                                            .productname,
                                                        context);
                                                  });
                                                },
                                                icon: const Icon(Icons.delete)),
                                          ],
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Edit"),
                                              Text("Delete"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 150,
                            width: 183,
                            child: Singleproduct(
                              imagewidget: Image.network(
                                sellitems[index].image[0],
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: RichText(
                                  maxLines: 2,
                                  text: TextSpan(
                                      text: "\$${sellitems[index].price}\t",
                                      style: TextStyle(
                                          color: Globalvariable
                                              .selectednavbarcolor),
                                      children: [
                                        TextSpan(
                                          text: sellitems[index].productname,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )
                                      ])))
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Globalvariable.selectednavbarcolor),
              ),
            );
          }
        },
      ),
    );
  }

  List<Sellmodel> sellitems = [];

  Future<List<Sellmodel>> getsell() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse(getsellurl),
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        for (Map<String, dynamic> index in data) {
          // loop
          sellitems.add(Sellmodel.fromJson(index));
        }
      }
      sellitems.toSet();
    } catch (error) {
      debugPrint(error.toString());
    }
    return sellitems;
  }

  // to delete sell items
  Future deletesell(String namebyparams, context) async {
    var client = http.Client();
    var deletebody = {
      "Productname": namebyparams,
    };
    var response = await client.delete(
      Uri.parse(deletesellurl),
      body: jsonEncode(deletebody),
      headers: {"Content-Type": "application/json"},
    );
    var jsresponse = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      flashfunction(
          context, "Sell Item", jsresponse.toString(), FlashType.success);
    }
  }

  @override
  void initState() {
    getsell();
    super.initState();
  }
}
