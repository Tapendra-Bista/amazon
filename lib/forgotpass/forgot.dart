

import 'package:amazon/common/footer.dart';
import 'package:amazon/constans/cons.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/materialb.dart';
import '../common/textfield.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({super.key});

  @override
  State<Forgotpass> createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {
  final TextEditingController _emailforforgot = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset(
          "image/am.png",
          height: 163,
          width: 163,
        ),
      ),
      backgroundColor: Globalvariable.backgroundcolor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            RichText(
                text: TextSpan(
                    text: "Password assistance",
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    children: [
                  TextSpan(
                    text:
                        "\n\nEnter the email associated with your Amazon account to change your password. ",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                ])),
            const SizedBox(
              height: 10,
            ),
            Customtextfield(
           
                keyboardtype: TextInputType.multiline,
              boolvalue: false,
              controller: _emailforforgot,
              myhint: "Email",
            ),
            const SizedBox(
              height: 10,
            ),
            Custommaterialbutton(
                width: double.maxFinite,
                borderclr: Colors.black,
              radius:3,
              color: Globalvariable.secondarycolor,
              name: "Continue",
              function: () {},
            ),
            const SizedBox(
              height: 30,
            ),
            RichText(
                text: TextSpan(
                    text: "Has your email or number changed?",
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    children: [
                  TextSpan(
                    text:
                        "\n\nIf you no longer use the email or mobile number associated with your Amazon account , you may contact",
                    style: TextStyle(
                        fontSize: 17, color: Colors.black.withOpacity(1)),
                  ),
                  const TextSpan(
                    text: " Customer Service ",
                    style: TextStyle(
                        fontSize: 19,
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                  const TextSpan(
                    text: "for help restoring access to your account.",
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                    ),
                  ),
                ])),
            const SizedBox(
              height: 230,
            ),
            const Customfooter()
          ],
        ),
      )),
    );
  }
}
