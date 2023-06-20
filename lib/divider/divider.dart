import 'package:flutter/material.dart';

class Customdivider extends StatelessWidget {
  const Customdivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 3,
      thickness: 3,
      color: Colors.grey[350],
      indent: 1,
      endIndent: 1,
    );
  }
}