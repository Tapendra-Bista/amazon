import 'dart:io';
import 'package:amazon/admin/create/create.dart';
import 'package:amazon/constans/cons.dart';
import 'package:amazon/forgotpass/forgot.dart';
import 'package:amazon/navigationbar/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firstpage/firstpage.dart';
import 'home/home.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark, statusBarColor: Colors.white));
  runApp(MaterialApp(
    theme: Globalvariable.mytheme,
    title: 'Amazon',
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      "/createpage": (context) => const Createpage(),
      "/": (context) => const Viewpageuser(),
      "/firstpage": (context) => const Firstpage(),
      "/forgotpass": (context) => const Forgotpass(),
      "/homepage": (context) => const Homepage(),
      "/Viewpageuser": (context) => const Viewpageuser(),
    },
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// note easy way to SHA-1 
/*
1 go to terminal of android folder in flutter 
2 in cmd run
3 gradlew signingReport  
4 find SHA-1

*/