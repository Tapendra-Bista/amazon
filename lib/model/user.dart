// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  
    String token;
    String id;
    String username;
    String email;
    String password;
    String address;
    String type;


    User({
      
        required this.token,
        required this.id,
        required this.username,
        required this.email,
        required this.password,
        required this.address,
        required this.type,
     
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
      
        token: json["token"],
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
        type: json["type"],
    
    );

    Map<String, dynamic> toJson() => {
     
        "token": token,
        "_id": id,
        "username": username,
        "email": email,
        "password": password,
        "address": address,
        "type": type,
      
    };
}
