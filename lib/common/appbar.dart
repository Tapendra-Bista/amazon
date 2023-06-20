import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constans/cons.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({
    super.key,
    required this.forappbar,
  });
  final Widget forappbar;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Color.fromARGB(255, 71, 204, 198),
      ),
      flexibleSpace: Container(
        decoration:
            const BoxDecoration(gradient: Globalvariable.appbargradient),
        child: forappbar,
      ),
    );
  }
}
