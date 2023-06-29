import 'package:flutter/material.dart';

class Quantitybutton extends StatelessWidget {
  const Quantitybutton(
      {super.key,
      required this.add,
      required this.remove,
      required this.number});
  final Function() add;
  final Function() remove;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29, top: 12, bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        height: 50,
        width: 145,
        decoration: BoxDecoration(
            border:
                Border.all(color: Colors.black12.withOpacity(0.2), width: 2),
            borderRadius: BorderRadius.circular(9),
            color: Colors.black12.withOpacity(0.2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: remove,
              child: const Icon(
                Icons.remove,
                size: 24,
              ),
            ),
            Container(
                height: 48,
                width: 52,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white),
                child: Center(
                    child: Text(
                  number,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                ))),
            InkWell(
              onTap: add,
              child: const Icon(
                Icons.add,
                size: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
