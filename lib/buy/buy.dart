import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../common/appbar.dart';
import '../common/buttonwithicon.dart';
import '../common/textfield.dart';
import 'package:icons_plus/icons_plus.dart';

class Buynow extends StatefulWidget {
  const Buynow({super.key});

  @override
  State<Buynow> createState() => _BuynowState();
}

class _BuynowState extends State<Buynow> {
  TextEditingController houseNumber = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          // to maintained appbar hieght
          preferredSize: const Size.fromHeight(75),
          child: Customappbar(
            forappbar: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(CupertinoIcons.back))
              ],
            ),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Customtextfield(
                boolvalue: false,
                controller: houseNumber,
                myhint: "Flat, House no.Building",
                keyboardtype: TextInputType.multiline,
              ),
              const SizedBox(
                height: 10,
              ),
              Customtextfield(
                boolvalue: false,
                controller: area,
                myhint: "Area, Street",
                keyboardtype: TextInputType.multiline,
              ),
              const SizedBox(
                height: 10,
              ),
              Customtextfield(
                boolvalue: false,
                controller: pincode,
                myhint: "Pincode",
                keyboardtype: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              Customtextfield(
                boolvalue: false,
                controller: city,
                myhint: "Town/City",
                keyboardtype: TextInputType.multiline,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonAndicon(
                icon: const Icon(
                  Icons.apple,
                  size: 27,
                ),
                nameOfpay: "Pay",
                width: double.infinity,
                function: () {},
                color: Colors.grey.shade100,
                radius: 5,
                borderclr: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonAndicon(
                icon: Logo(
                  Logos.google,
                  size: 21,
                ),
                nameOfpay: "Pay",
                width: double.infinity,
                function: () {},
                color: Colors.grey.shade100,
                radius: 5,
                borderclr: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              ButtonAndicon(
                icon: Logo(
                  Logos.cc_visa,
                  size: 30,
                ),
                nameOfpay: "Card",
                width: double.infinity,
                function: () {},
                color: Colors.grey.shade100,
                radius: 5,
                borderclr: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
