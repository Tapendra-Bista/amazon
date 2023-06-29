import 'dart:convert';
import 'package:amazon/rating/rating.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../buycenter/details.dart';
import '../common/singlepro.dart';
import '../constans/cons.dart';
import '../model/sell.dart';
import '../url/url.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key, required this.searchitem});
  final String searchitem;

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        responsestring != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top:300),
                  child: Text(
                    responsestring ?? "",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500,color: Colors.black),
                  ),
                ),
              )
            : FutureBuilder(
                future: searchfunction(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 1100,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: search.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                              id: search[index].id,
                                              catergory:
                                                  search[index].catergory,
                                              productname:
                                                  search[index].productname,
                                              discription:
                                                  search[index].discription,
                                              price: search[index].price,
                                              quantity: search[index].qantity,
                                              image: search[index].image)));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 210,
                                      width: 200,
                                      child: Singleproduct(
                                          imagewidget: Image.network((
                                              search[index]
                                                  .image[0]
                                                  .toString()))),
                                    ),
                                    Container(
                                      height: 210,
                                      width: 190,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            search[index].productname,
                                            style: TextStyle(
                                                fontSize: 19,
                                                color: Colors.black
                                                    .withOpacity(0.6)),
                                            maxLines: 3,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          CustomRating(
                                            productid: search[index].id,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "\$${search[index].price}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text("Eligible for FREE Shipping",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withOpacity(0.8))),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(int.parse(search[index].qantity).toInt()!=0?"In Stock":"Out Stock",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  color:int.parse(search[index].qantity).toInt()!=0? Globalvariable
                                                      .selectednavbarcolor :Colors.red)),
                                        ],
                                      ),
                                      // color: Colors.transparent),
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
    );
  }

  // api to Search items
  String? responsestring;
  List<Sellmodel> search = [];
  Future<List<Sellmodel>> searchfunction() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse(
          "$searchurl${widget.searchitem}",
        ),
        headers: {"Content-Type": "application/json"},
      );
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        for (Map<String, dynamic> index in data) {
          search.add(Sellmodel.fromJson(index));
        }
      }
      if (response.statusCode == 404) {
       setState(() {
          responsestring = data['message'];
       });
        debugPrint(responsestring.toString());
      }
    } catch (error) {
      debugPrint(error.toString());
    }
    return search;
  }
}
