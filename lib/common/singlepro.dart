import 'package:flutter/material.dart';

class Singleproduct extends StatelessWidget {
  const Singleproduct({
    super.key,
    required this.imagewidget,
  });
  final Widget imagewidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 1.5),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Container(padding: const EdgeInsets.all(6), child: imagewidget),
      ),
    );
  }
}
