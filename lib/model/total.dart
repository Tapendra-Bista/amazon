import 'dart:convert';

List<Totalmodel> totalmodelFromJson(String str) =>
    List<Totalmodel>.from(json.decode(str).map((x) => Totalmodel.fromJson(x)));

String totalmodelToJson(List<Totalmodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Totalmodel {
  String id;
  int amount;
  int items;

  Totalmodel({
    required this.id,
    required this.amount,
    required this.items,
  });

  factory Totalmodel.fromJson(Map<String, dynamic> json) => Totalmodel(
        id: json["_id"],
        amount: json["amount"],
        items: json["items"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "items": items,
      };
}
