import 'package:flutter/material.dart';

class Customexpandtext extends StatelessWidget {
  const Customexpandtext(
      {super.key, required this.controller, required this.hinttext});

  final TextEditingController controller;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: TextFormField(
        expands: true,
        maxLines: null,
        controller: controller,
        cursorColor: Colors.black87.withOpacity(0.5),
        style: const TextStyle(color: Colors.black87),
        validator: (value) {
          return value;
        },
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(top: 15, left: 15, bottom: 5, right: 0),
            isDense: false,
            isCollapsed: true,
            hintText: hinttext,
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
      ),
    );
  }
}
