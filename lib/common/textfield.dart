import 'package:flutter/material.dart';

class Customtextfield extends StatefulWidget {
  const Customtextfield(
      {super.key,
      required this.controller,
      required this.myhint,
      required this.boolvalue,
      required this.keyboardtype, });
  final TextEditingController controller;
  final String myhint;
  final bool boolvalue;
  final TextInputType keyboardtype;

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
     
      keyboardType: widget.keyboardtype,
      obscureText: widget.boolvalue,
      cursorColor: Colors.black87.withOpacity(0.5),
      style: const TextStyle(color: Colors.black87),
      validator: (value) {
        return value;
      },
      controller: widget.controller,
      decoration: InputDecoration(
          hintText: widget.myhint,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.3))),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.3))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.3))),
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.3))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black.withOpacity(0.3)))),
    );
  }
}
