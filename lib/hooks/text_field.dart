import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String name;
  Icon icon;
  TextInputType type;
  bool obsecureText;
  TextEditingController? customController;
  CustomTextField(
      {Key? key,
      required this.name,
      required this.icon,
      required this.type,
      required this.obsecureText,
      this.customController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: customController,
      cursorColor: Colors.red,
      obscureText: obsecureText,
      keyboardType: type,
      textInputAction: TextInputAction.next,
      style: const TextStyle(fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        label: Text(name),
        labelStyle: const TextStyle(color: Colors.grey),
        focusColor: Colors.red,
        prefixIcon: icon,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
