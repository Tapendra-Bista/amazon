import 'dart:convert';

import 'package:amazon/model/sell.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../buycenter/details.dart';
import '../common/appbar.dart';
import '../common/singlepro.dart';
import '../constans/cons.dart';
import '../url/url.dart';

class Viewscreen extends StatefulWidget {
  const Viewscreen({super.key, required this.catogory});
  final String catogory;

  @override
  State<Viewscreen> createState() => _ViewscreenState();
}

class _ViewscreenState extends State<Viewscreen> {
  late String nameOfCatogory = widget.catogory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          // to maintained appbar height
          preferredSize: const Size.fromHeight(86),
          child: Customappbar(
            forappbar: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 50, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(CupertinoIcons.back)),
                        const SizedBox(
                          width: 130,
                        ),
                        Center(
                            child: Text(
                          nameOfCatogory,
                          style: const TextStyle(fontSize: 19),
                        )),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 15),
                  child: Text(
                    "Keep shopping for $nameOfCatogory",
                    style: TextStyle(
                        fontSize: 16, color: Colors.black.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
          )),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          color: Globalvariable.selectednavbarcolor,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
          },
          child: FutureBuilder(
              initialData: [
                getReqFunction(),
              ],
              future: getReqFunction(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: reqdata.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                             onTap: () {
          Navigator.push(context,MaterialPageRoute(builder:(context)=>Details(id:reqdata[index].id, catergory:reqdata[index].catergory, productname:reqdata[index].productname, discription:reqdata[index].discription, price:reqdata[index].price, qantity:reqdata[index].qantity, image: reqdata[index].image)));
        },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 141,
                                width: double.infinity,
                                child: Singleproduct(
                                    imagewidget: Image.network((
                                        reqdata[index].image[0].toString()))),
                              ),
                              Text(
                                "price :\$${reqdata[index].price}",
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              Text(
                                reqdata[index].productname,
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ],
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
              }),
        ),
      )),
    );
  }

// api
  List<Sellmodel> reqdata = [];

  Future<List<Sellmodel>> getReqFunction() async {
    var client = http.Client();
    var response = await client.get(
      Uri.parse("$getreqdataurl${widget.catogory}"),
      headers: {"Content-Type": "application/json"},
    );
    var data = jsonDecode(response.body.toString());
    for (Map<String, dynamic> index in data) {
      reqdata.add(Sellmodel.fromJson(index));
    }
    return reqdata;
  }

  @override
  void initState() {
    reqdata;
    getReqFunction();
    super.initState();
  }
}
