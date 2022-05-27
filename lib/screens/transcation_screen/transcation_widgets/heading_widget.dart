import 'package:flutter/material.dart';

class HeadingMethod extends StatelessWidget {
  String headtext;
  String amount;
  HeadingMethod({
    Key? key,
    required this.headtext,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          headtext,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          amount,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        )
      ],
    );
    
  }
}