

import 'dart:convert';

List<Rating> ratingFromJson(String str) => List<Rating>.from(json.decode(str).map((x) => Rating.fromJson(x)));

String ratingToJson(List<Rating> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rating {
    String id;
    String ratingGiver;
    String review;
   String rating;
   String  productid;

    Rating({
        required this.id,
        required this.ratingGiver,
        required this.review,
        required this.rating,
        required this.productid,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["_id"],
        ratingGiver: json["ratingGiver"],
        review: json["review"],
        rating: json["rating"],
    productid: json["productid"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "ratingGiver": ratingGiver,
        "review": review,
        "rating": rating,
        "productid":productid,
    
    };
}
