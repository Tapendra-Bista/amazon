import 'package:flutter/material.dart';
import '../buycenter/details.dart';
import '../common/singlepro.dart';
import '../constans/cons.dart';
import '../rating/rating.dart';
import 'cartbutton.dart';
class Maindata extends StatefulWidget {
  const Maindata({super.key, required this.future, required this.itemcount});
  final Future<List> future;
  final List itemcount;

  @override
  State<Maindata> createState() => _MaindataState();
}

class _MaindataState extends State<Maindata> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FutureBuilder(
            future: widget.future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 1200,
                  width: double.infinity,
                  child: ListView.builder(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.itemcount.length,
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
                                              id: widget.itemcount[index].productnameId,
                                              catergory: widget
                                                  .itemcount[index].catergory,
                                              productname: widget
                                                  .itemcount[index].productname,
                                              discription: widget
                                                  .itemcount[index].discription,
                                              price:
                                                  widget.itemcount[index].price,
                                              quantity: widget
                                                  .itemcount[index].quantity,
                                              image: widget
                                                  .itemcount[index].image)));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 210,
                                      width: 200,
                                      child: Singleproduct(
                                          imagewidget: Image.network((widget
                                              .itemcount[index].image[0]
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
                                            widget.itemcount[index].productname,
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
                                            productid: widget
                                                .itemcount[index].productnameId,
                                            size: 25,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "\$${widget.itemcount[index].price}",
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
                                              int.parse(
                                                              widget
                                                                  .itemcount[
                                                                      index]
                                                                  .quantity)
                                                          .toInt() !=
                                                      0
                                                  ? "In Stock"
                                                  : "Out Stock",
                                              style: TextStyle(
                                                  fontSize: 19,
                                                  color: int.parse(widget
                                                                  .itemcount[
                                                                      index]
                                                                  .quantity)
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
                                productname:
                                    widget.itemcount[index].productname,
                                number: widget.itemcount[index].cartquantity,
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
}
