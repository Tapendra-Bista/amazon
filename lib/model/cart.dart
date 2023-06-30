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
    int cartqauntity;

    Cartmodel({
        required this.id,
        required this.image,
        required this.productname,
        required this.discription,
        required this.price,
        required this.quantity,
        required this.catergory,
        required this.cartqauntity,
    });

    factory Cartmodel.fromJson(Map<String, dynamic> json) => Cartmodel(
        id: json["_id"],
        image: List<String>.from(json["image"].map((x) => x)),
        productname: json["productname"],
        discription: json["discription"],
        price: json["price"],
        quantity: json["quantity"],
        catergory: json["catergory"],
        cartqauntity: json["cartqauntity"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "image": List<dynamic>.from(image.map((x) => x)),
        "productname": productname,
        "discription": discription,
        "price": price,
        "quantity": quantity,
        "catergory": catergory,
        "cartqauntity": cartqauntity,
    };
}
