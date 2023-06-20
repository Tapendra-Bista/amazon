import 'package:flutter/material.dart';

class Customfieldwithinitialvalue extends StatefulWidget {
  const Customfieldwithinitialvalue({
    super.key,
    required this.boolvalue,
    required this.keyboardtype,
    required this.initalvalue, required this.onChanged,
   
   
  });

  final bool boolvalue;
  final TextInputType keyboardtype;
  final String initalvalue;
  final Function(String value) onChanged;

   

  @override
  State<Customfieldwithinitialvalue> createState() =>
      _CustomfieldwithinitialvalueState();
}

class _CustomfieldwithinitialvalueState
    extends State<Customfieldwithinitialvalue> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged:widget.onChanged,
      initialValue: widget.initalvalue,
      keyboardType: widget.keyboardtype,
      obscureText: widget.boolvalue,
      cursorColor: Colors.black87.withOpacity(0.5),
      style: const TextStyle(color: Colors.black87),
      validator: (value) {
        return value;
      },
      decoration: InputDecoration(
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
