// To parse this JSON data, do
//
//     final cartmodel = cartmodelFromJson(jsonString);

import 'dart:convert';

Cartmodel cartmodelFromJson(String str) => Cartmodel.fromJson(json.decode(str));

String cartmodelToJson(Cartmodel data) => json.encode(data.toJson());

class Cartmodel {
  String id;
  List<String> image;
  String productname;
  String discription;
  String price;
  String quantity;
  String catergory;
  String productnameId;
  int cartquantity;

  Cartmodel({
    required this.id,
    required this.image,
    required this.productname,
    required this.productnameId,
    required this.discription,
    required this.price,
    required this.quantity,
    required this.catergory,
    required this.cartquantity,
  });

  factory Cartmodel.fromJson(Map<String, dynamic> json) => Cartmodel(
        id: json["_id"],
        image: List<String>.from(json["image"].map((x) => x)),
        productname: json["productname"],
        productnameId: json["productnameId"],
        discription: json["discription"],
        price: json["price"],
        quantity: json["quantity"],
        catergory: json["catergory"],
        cartquantity: json["cartquantity"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": List<dynamic>.from(image.map((x) => x)),
        "productname": productname,
        "productnameId": productnameId,
        "discription": discription,
        "price": price,
        "quantity": quantity,
        "catergory": catergory,
        "cartquantity": cartquantity,
      };
}
