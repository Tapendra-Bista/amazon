import 'package:flutter/material.dart';

class Custommaterialbutton extends StatefulWidget {
  const Custommaterialbutton(
      {super.key,
      required this.width,
      required this.function,
      required this.name,
      required this.color,
      required this.borderclr,
      required this.radius});
  final String name;
  final Function function;
  final Color color;
  final Color borderclr;
  final double radius;
  final double width;
  @override
  State<Custommaterialbutton> createState() => _CustommaterialbuttonState();
}

class _CustommaterialbuttonState extends State<Custommaterialbutton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: widget.width,
      height: 55,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          side: BorderSide(width: 0.8, color: widget.borderclr)),
      color: widget.color,
      onPressed: () {
        setState(() {
          widget.function();
        });
      },
      child: Text(
        widget.name,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}
