
import 'package:flutter/material.dart';
import '../buycenter/details.dart';
import '../common/singlepro.dart';
import '../constans/cons.dart';
import 'getapisell.dart';

class DealofDay extends StatelessWidget {
  const DealofDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Deal of the day",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        FutureBuilder(
            initialData: const [],
            future: getdataapi(),
            key: const PageStorageKey(InitialRouteListFactory),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: 250,
                  width: 510,
                  child: GridView.builder(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(
                                        id: data[Globalvariable.itemindex].id,
                                        catergory: data[Globalvariable.itemindex]
                                            .catergory,
                                        productname: data[Globalvariable.itemindex]
                                            .productname,
                                        discription: data[Globalvariable.itemindex]
                                            .discription,
                                        price: (int.parse(
                                                    data[Globalvariable.itemindex]
                                                        .price) -
                                                (int.parse(data[Globalvariable.itemindex].price) *
                                                        Globalvariable
                                                            .discount) /
                                                    100)
                                            .ceil()
                                            .toString(),
                                        quantity: data[Globalvariable.itemindex]
                                            .qantity,
                                        image: data[Globalvariable.itemindex].image)));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 210,
                                    width: 200,
                                    child: Singleproduct(
                                        imagewidget: Image.network((
                                            data[Globalvariable.itemindex]
                                                .image[0]
                                                ))),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 210,
                                    width: 186,
                                    decoration: const BoxDecoration(),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("SPECIAL OFFER",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.red)),
                                        Container(
                                          height: 60,
                                          width: 60,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green),
                                          child: Center(
                                            child: Text(
                                                "${Globalvariable.discount}%",
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                )),
                                          ),
                                        ),
                                        const Text("Discount",
                                            style: TextStyle(
                                              fontSize: 20,
                                            )),
                                        Text(
                                          "Acutal price :\$${data[Globalvariable.itemindex].price}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              RichText(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                      text:
                                          "New price :\$${(int.parse(data[Globalvariable.itemindex].price) - (int.parse(data[Globalvariable.itemindex].price) * Globalvariable.discount) / 100).ceil()}",
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text:
                                              "\n${data[Globalvariable.itemindex].productname}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                        )
                                      ])),
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Globalvariable.selectednavbarcolor),
                  ),
                );
              }
            }),
      ],
    );
  }
}
