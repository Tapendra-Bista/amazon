// To parse this JSON data, do
//
//     final sellmodel = sellmodelFromJson(jsonString);

import 'dart:convert';

Sellmodel sellmodelFromJson(String str) => Sellmodel.fromJson(json.decode(str));

String sellmodelToJson(Sellmodel data) => json.encode(data.toJson());

class Sellmodel {
    String id;
    List<String> image;
    String productname;
    String discription;
    String price;
    String quantity;
    String catergory;
 

    Sellmodel({
        required this.id,
        required this.image,
        required this.productname,
        required this.discription,
        required this.price,
        required this.quantity,
        required this.catergory,
     
    });

    factory Sellmodel.fromJson(Map<String, dynamic> json) => Sellmodel(
        id: json["_id"],
        image: List<String>.from(json["image"].map((x) => x)),
        productname: json["productname"],
        discription: json["discription"],
        price: json["price"],
        quantity: json["quantity"],
        catergory: json["catergory"],
      
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "image": List<dynamic>.from(image.map((x) => x)),
        "productname": productname,
        "discription": discription,
        "price": price,
        "quantity": quantity,
        "catergory": catergory,
       
    };
}
