import 'package:flutter/material.dart';

class ButtonAndicon extends StatefulWidget {
  const ButtonAndicon(
      {super.key,
      required this.width,
      required this.function,
      required this.color,
      required this.borderclr,
      required this.radius,
      required this.nameOfpay,
     required this.icon});

  final Function function;
  final Color color;
  final Color borderclr;
  final double radius;
  final double width;
  final String nameOfpay;

  final Widget icon;
  @override
  State<ButtonAndicon> createState() => _ButtonAndiconState();
}

class _ButtonAndiconState extends State<ButtonAndicon> {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Buy with ",
            style: TextStyle(fontSize: 20),
          ),
          widget.icon,
          Text(widget.nameOfpay, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
