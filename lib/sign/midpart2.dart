import 'dart:convert';
import 'package:amazon/constans/cons.dart';
import 'package:amazon/provider/provider.dart';
import 'package:amazon/url/url.dart';
import 'package:flashtoast/flash_toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/flash.dart';
import '../common/materialb.dart';
import '../common/textfield.dart';

class Signinpart extends StatefulWidget {
  const Signinpart({super.key});

  @override
  State<Signinpart> createState() => _SigninpartState();
}

class _SigninpartState extends State<Signinpart> {
  bool showpassword1 = false;
  final _signupkey = GlobalKey<FormState>();
  final TextEditingController _emailxcontroller = TextEditingController();
  final TextEditingController _passwordxcontroller = TextEditingController();
  @override
  void dispose() {
    super.dispose();

    _emailxcontroller.dispose();
    _passwordxcontroller.dispose();
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
                  controller: _emailxcontroller,
                  myhint: "Email",
                ),
                const SizedBox(
                  height: 10,
                ),
                Customtextfield(
                  keyboardtype: TextInputType.multiline,
                  boolvalue: showpassword1 ? false : true,
                  controller: _passwordxcontroller,
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
                          if (showpassword1 == false) {
                            showpassword1 = true;
                          } else {
                            showpassword1 = false;
                          }
                        });
                      },
                      icon: showpassword1
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
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.6))),
                    const SizedBox(
                      width: 38,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/forgotpass");
                      },
                      child: const Text("Forgot Password?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue)),
                    )
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
                  name: "Sign In",
                  function: () {
                    signinfunction(context);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        text: "By continuing, you agree to Amazon's",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        children: [
                          TextSpan(
                            text: " Conditions of Use ",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                          TextSpan(
                            text: "and",
                            style: TextStyle(fontSize: 18, color: Colors.black),
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

// to store token in Sharedpreferences
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    setsharedprefrences();
    signinfunction(context);
  }

  void setsharedprefrences() async {
    _preferences = await SharedPreferences.getInstance();
  }

// function for signin http.post
  Future signinfunction(context) async {
    if (_emailxcontroller.text.isNotEmpty &&
        _passwordxcontroller.text.isNotEmpty) {
      var client = http.Client();
      var signinbody = {
        "email": _emailxcontroller.text,
        "password": _passwordxcontroller.text,
      };
      try {
        var response = await client.post(Uri.parse(signinurl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(signinbody));
        var jsresponse = jsonDecode(response.body.toString());
        if (response.statusCode == 200) {
          var token = jsresponse['token'];
          debugPrint(token);
          Provider.of<Userprovider>(context, listen: false).setUser(jsresponse);
          _preferences.setString('token', token);

          flashfunction(
              context, "Sign In", "successfully sign in", FlashType.success);
        } else if (response.statusCode == 401) {
          flashfunction(context, "Password", jsresponse['message'].toString(),
              FlashType.error);
        } else if (response.statusCode == 404) {
          flashfunction(context, "Unknown user",
              jsresponse['message'].toString(), FlashType.error);
        } else {
          debugPrint(jsresponse['message']);
        }
      } catch (error) {
        debugPrint(error.toString());
      }
    }
  }
}
