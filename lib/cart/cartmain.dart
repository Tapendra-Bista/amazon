import 'dart:convert';
import 'package:flutter/material.dart';
import '../buycenter/details.dart';
import '../common/singlepro.dart';
import '../constans/cons.dart';
import '../rating/rating.dart';
import '../url/url.dart';
import 'cartbutton.dart';
import 'package:http/http.dart' as http;

class Maindata extends StatelessWidget {
  const Maindata({super.key, required this.future, required this.itemcount});
  final Future<List> future;
  final List itemcount;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 1200,
                  width: double.infinity,
                  child: ListView.builder(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: itemcount.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                              id: itemcount[index].id,
                                              catergory:
                                                  itemcount[index].catergory,
                                              productname:
                                                  itemcount[index].productname,
                                              discription:
                                                  itemcount[index].discription,
                                              price: itemcount[index].price,
                                              quantity: itemcount[index].qantity,
                                              image: itemcount[index].image)));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 210,
                                      width: 200,
                                      child: Singleproduct(
                                          imagewidget: Image.network(
                                              (itemcount[index]
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
                                            itemcount[index].productname,
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
                                            productid: itemcount[index].id,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "\$${itemcount[index].price}",
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
                                          Text(
                                              int.parse(itemcount[index]
                                                              .qantity)
                                                          .toInt() !=
                                                      0
                                                  ? "In Stock"
                                                  : "Out Stock",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  color: int.parse(itemcount[
                                                                      index]
                                                                  .qantity)
                                                              .toInt() !=
                                                          0
                                                      ? Globalvariable
                                                          .selectednavbarcolor
                                                      : Colors.red)),
                                        ],
                                      ),

                                      // color: Colors.transparent),
                                    )
                                  ],
                                ),
                              ),
                              Quantitybutton(
                                add: () => incrementfunction(
                                    context, itemcount[index].productname),
                                remove: () => decrementfunction(
                                    context, itemcount[index].productname),
                                number:
                                    itemcount[index].cartqauntity.toString(),
                              )
                            ],
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

  // increment or decrement
  Future incrementfunction(context, String productname) async {
    var body = {
      "Productname": productname,
    };
    try {
      var response = await http.patch(Uri.parse(incrementurl),
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {}
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  //
  Future decrementfunction(context, String productname) async {
    var body = {
      "productname": productname,
    };
    try {
      var response = await http.patch(Uri.parse(decrementurl),
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {}
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
