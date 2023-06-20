import 'package:amazon/constans/cons.dart';
import 'package:amazon/sign/sign_i_u.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/materialb.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        systemOverlayStyle:
            const SystemUiOverlayStyle( statusBarIconBrightness: Brightness.dark,statusBarColor: Color(0xFF65CBCD)),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Globalvariable.backgroundcolor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(image: AssetImage("image/am.png")),
            const Align(
              alignment: Alignment.center,
              child: Text("Sign in to your account",
                  style: TextStyle(fontSize: 30, color: Colors.black)),
            ),
            const SizedBox(
              height: 15,
            ),
            RichText(
                text: const TextSpan(
                    text: "\t\t\tView your wish List",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                    children: [
                  TextSpan(
                    text: "\n\n\t\t\tFind & recorder past purchasee",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  TextSpan(
                    text: "\n\n\t\t\tTrack your purchases",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ])),
            const SizedBox(
              height: 30,
            ),
            Custommaterialbutton(
              width: double.maxFinite,
                borderclr: Colors.black,
              radius:3,
              color: Globalvariable.secondarycolor,
              name: "Already a customer? Sign in",
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Signpage(enumbool: true)));
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Custommaterialbutton(
                width: double.maxFinite,
                borderclr: Colors.black,
              radius:3,
              color: Globalvariable.backgroundcolor,
              name: "New to Amazon.com? Create an account",
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Signpage(enumbool: false)));
              },
            ),
          ],
        ),
      )),
    );
  }
}
