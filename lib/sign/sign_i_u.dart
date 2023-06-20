import 'package:amazon/constans/cons.dart';
import 'package:amazon/sign/midpart1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/footer.dart';
import 'midpart2.dart';

enum Auth {
  signin,
  signup,
}

class Signpage extends StatefulWidget {
  const Signpage({super.key, required this.enumbool});
  final bool enumbool;

  @override
  State<Signpage> createState() => _SignpageState();
}

class _SignpageState extends State<Signpage> {
  late Auth _auth = widget.enumbool ? Auth.signin : Auth.signup;

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
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Wellcome",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  tileColor:
                      _auth == Auth.signup ? Colors.white : Colors.transparent,
                  leading: Radio(
                      activeColor: Globalvariable.secondarycolor,
                      value: Auth.signup,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                  title: RichText(
                      text: TextSpan(
                          text: "Create account",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          children: [
                        TextSpan(
                          text: ". New to Amazon?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ]))),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1),
                    borderRadius: _auth == Auth.signup
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))
                        : const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    _auth == Auth.signup ? const Signuppart() : const Row(),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              ListTile(
                  shape: const RoundedRectangleBorder(),
                  leading: Radio(
                      activeColor: Globalvariable.secondarycolor,
                      value: Auth.signin,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      }),
                  title: RichText(
                      text: TextSpan(
                          text: "Sign in",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                          children: [
                        TextSpan(
                          text: ". Already a customer?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                      ])),
                  tileColor:
                      _auth == Auth.signin ? Colors.white : Colors.transparent),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: _auth == Auth.signin
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: _auth == Auth.signin
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            bottomRight: Radius.circular(5))
                        : const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    _auth == Auth.signin ? const Signinpart() : const Row(),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _auth == Auth.signin ? 175 : 107,
              ),
              const Customfooter(),
            ],
          ),
        ),
      )),
    );
  }
 
}
