import 'package:flutter/material.dart';
import '../buycenter/details.dart';
import '../common/singlepro.dart';
import '../constans/cons.dart';

class Itemcatory extends StatefulWidget {
  const Itemcatory(
      {super.key,
      required this.itemscateroryname,
      required this.future,
      required this.itemcount});
  final String itemscateroryname;
  final Future<List> future;
  final List itemcount;
  @override
  State<Itemcatory> createState() => _ItemcatoryState();
}

class _ItemcatoryState extends State<Itemcatory> {
  bool expandView = false;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Globalvariable.selectednavbarcolor,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: Container(
        height: expandView ? 1100 : 300,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 9,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.itemscateroryname,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  widget.itemscateroryname.compareTo("YOU MIGHT LIKE THIS") == 0
                      ? const Row()
                      : InkWell(
                          onTap: () {
                            setState(() {
                              if (expandView == false) {
                                expandView = true;
                              } else {
                                expandView = false;
                              }
                            });
                          },
                          child: Text(
                            expandView ? "" : "See all items",
                            style: TextStyle(
                                color: Globalvariable.selectednavbarcolor,
                                fontSize: 18),
                          ),
                        ),
                ],
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            FutureBuilder(
                future: widget.future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: expandView ? 1000 : 250,
                      width: double.infinity,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: expandView ? 2 : 1,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: expandView ? 10 : 0),
                          itemCount: widget.itemcount.length,
                          scrollDirection:
                              expandView ? Axis.vertical : Axis.horizontal,
                          itemBuilder: (context, index) {
                            return RefreshIndicator(
                              onRefresh: () async {
                                widget.future;
                              },
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Details(
                                              id: widget.itemcount[index].id,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: expandView ? 150 : 210,
                                      width: 215,
                                      child: Singleproduct(
                                          imagewidget: Image.network(
                                        widget.itemcount[index].image[0],
                                      )),
                                    ),
                                    Text(
                                      "price :\$${widget.itemcount[index].price}",
                                      style: const TextStyle(
                                          fontSize: 17, color: Colors.black),
                                    ),
                                    Text(
                                      widget.itemcount[index].productname,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black.withOpacity(0.6)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                  {
                    return const Center(child: Row());
                  }
                }),
            const SizedBox(
              height: 10,
            ),
            expandView
                ? InkWell(
                    onTap: () {
                      setState(() {
                        if (expandView == false) {
                          expandView = true;
                        } else {
                          expandView = false;
                        }
                      });
                    },
                    child: Text(
                      "Minimize Size",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Globalvariable.selectednavbarcolor,
                          fontSize: 18),
                    ),
                  )
                : const Row()
          ],
        ),
      ),
    );
  }
}
