import 'package:flutter/material.dart';

class CustomSalesWidget extends StatelessWidget {
  CustomSalesWidget({Key? key, required this.key1, required this.value})
      : super(key: key);
  String key1;
  String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(key1),
        ),
        const SizedBox(
          width: 30,
          child: Text("-"),
        ),
        SizedBox(
          width: 180.0,
          child: Text(value),
        )
      ],
    );
  }
}
