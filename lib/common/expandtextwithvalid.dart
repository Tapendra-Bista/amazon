import 'package:flutter/material.dart';

class Customexpandedtextwithvalid extends StatefulWidget {
  const Customexpandedtextwithvalid({
    super.key,
    required this.initial,
     required this.onChanged,
  });

  final String initial;
 
  final Function( String value) onChanged;

  @override
  State<Customexpandedtextwithvalid> createState() =>
      _CustomexpandedtextwithvalidState();
}

class _CustomexpandedtextwithvalidState
    extends State<Customexpandedtextwithvalid> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: TextFormField(
        initialValue: widget.initial,
        onChanged:widget.onChanged,
        expands: true,
        maxLines: null,
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
