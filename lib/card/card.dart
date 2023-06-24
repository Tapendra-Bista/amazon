import 'dart:io';

import 'package:flutter/material.dart';

class Cardpage extends StatefulWidget {
  const Cardpage({super.key});

  @override
  State<Cardpage> createState() => _CardpageState();
}

class _CardpageState extends State<Cardpage> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [    Image.file(File(
        '/data/user/0/com.example.amazon/cache/cdbd8b55-2d40-4fc4-b37e-aa671c50bc4f/71O-cxiBEKL._AC_UF1000,1000_QL80_FMwebp_.webp')),],);
  }
}
