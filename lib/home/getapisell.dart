import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../model/sell.dart';
import '../url/url.dart';

// all items
List<Sellmodel> data = [];
Future<List<Sellmodel>> getdataapi() async {


  try {
    var response = await http.get(
      Uri.parse(getsellurl),
      headers: {"Content-Type": "application/json"},
    );
    var jsresponse = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in jsresponse) {
        data.add(Sellmodel.fromJson(index));
      }
    }
    data.toSet();
  } catch (error) {
    debugPrint(error.toString());
  }
  return data;
}

// all items
List<Sellmodel> available = [];
Future<List<Sellmodel>> getavailabledata() async {


  try {
    var response = await http.get(
      Uri.parse(availableurl),
      headers: {"Content-Type": "application/json"},
    );
    var jsresponse = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in jsresponse) {
        available.add(Sellmodel.fromJson(index));
      }
    }
    available.toSet();
  } catch (error) {
    debugPrint(error.toString());
  }
  return available;
}

// expensive items
List expensive = [];
Future<List> expensiveitem() async {


  try {
    var response = await http.get(
      Uri.parse(expensiveurl),
      headers: {"Content-Type": "application/json"},
    );
    var jsresponse = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in jsresponse) {
        expensive.add(Sellmodel.fromJson(index));
      }
    }
    expensive.toSet();
  } catch (error) {
    debugPrint(error.toString());
  }

  return expensive;
}

// cheap items

List<Sellmodel> cheap = [];

Future<List<Sellmodel>> cheapitem() async {


  try {
    var response = await http.get(
      Uri.parse(cheapurl),
      headers: {"Content-Type": "application/json"},
    );
    var jsresponse = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in jsresponse) {
        cheap.add(Sellmodel.fromJson(index));
      }
    }
    cheap.toSet();
  } catch (error) {
    debugPrint(error.toString());
  }

  return cheap;
}

// fresh items
// api
List<Sellmodel> freshitem = [];
Future<List<Sellmodel>> freshitemFunction() async {

  var response = await http.get(
    Uri.parse(
      "${getreqdataurl}Grocery",
    ),
    headers: {"Content-Type":"application/json"},
  );
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    for (Map<String, dynamic> index in data) {
      freshitem.add(Sellmodel.fromJson(index));
    }
  }
  freshitem.toSet();
  return freshitem;
}
