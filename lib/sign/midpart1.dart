import 'dart:convert';
import 'package:amazon/sign/sign_i_u.dart';
import 'package:flashtoast/flash_toast.dart';
import 'package:http/http.dart' as http;
import 'package:amazon/constans/cons.dart';
import 'package:flutter/material.dart';
import '../common/flash.dart';
import '../common/materialb.dart';
import '../common/textfield.dart';
import '../url/url.dart';

class Signuppart extends StatefulWidget {
  const Signuppart({super.key});

  @override
  State<Signuppart> createState() => _SignuppartState();
}

class _SignuppartState extends State<Signuppart> {
  bool showpassword = false;
  final _signupkey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
            key: _signupkey,
            child: Column(
              children: [
                Customtextfield(
                  keyboardtype: TextInputType.multiline,
                  boolvalue: false,
                  controller: _namecontroller,
                  myhint: "Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                Customtextfield(
                  keyboardtype: TextInputType.multiline,
                  boolvalue: false,
                  controller: _emailcontroller,
                  myhint: "Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                Customtextfield(
                  keyboardtype: TextInputType.multiline,
                  boolvalue: showpassword ? false : true,
                  controller: _passwordcontroller,
                  myhint: "Password",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (showpassword == false) {
                            showpassword = true;
                          } else {
                            showpassword = false;
                          }
                        });
                      },
                      icon: showpassword
                          ? const Icon(
                              Icons.check_box_outlined,
                              size: 30,
                              color: Globalvariable.secondarycolor,
                            )
                          : const Icon(
                              Icons.check_box_outline_blank_outlined,
                              size: 30,
                            ),
                    ),
                    Text("Show password",
                        style: TextStyle(
                            fontSize: 18, color: Colors.black.withOpacity(0.6)))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Custommaterialbutton(
                  width: double.maxFinite,
                  borderclr: Colors.black,
                  radius: 3,
                  color: Globalvariable.secondarycolor,
                  name: "Sign Up",
                  function: () {
                    signupfunction(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        text: "By Creating an account, you agree to Amazon's",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                        children: [
                          TextSpan(
                            text: " Conditions of Use ",
                            style: TextStyle(fontSize: 17, color: Colors.blue),
                          ),
                          TextSpan(
                            text: "and",
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                          TextSpan(
                            text: " Privacy Notice.",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        ])),
              ],
            )),
      ],
    );
  }

  Future signupfunction(context) async {
    if (_emailcontroller.text.isNotEmpty &&
        _passwordcontroller.text.isNotEmpty &&
        _namecontroller.text.isNotEmpty) {
      var client = http.Client();
      var signupbody = {
        "username": _namecontroller.text,
        "email": _emailcontroller.text,
        "password": _passwordcontroller.text,
      };
      try {
        var response = await client.post(Uri.parse(signupurl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(signupbody));
        var jsresponse = jsonDecode(response.body.toString());
        if (response.statusCode == 200) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: ((context) => const Signpage(enumbool: true))));
          flashfunction(context, "Sign Up", jsresponse['message'].toString(),
              FlashType.success);
        } else if (response.statusCode == 409) {
          flashfunction(context, "Enter another email",
              jsresponse['message'].toString(), FlashType.error);
        } else {
          var invalidemail = jsresponse['message'];
          flashfunction(
              context,
              "Password",
              invalidemail
                  .toString()
                  .replaceAll("signdata validation failed: email:", ''),
              FlashType.error);
        }

        debugPrint(jsresponse['message'].toString());
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }

  @override
  void initState() {
    signupfunction(context);
    super.initState();
  }
}
