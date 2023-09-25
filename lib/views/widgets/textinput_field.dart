import 'package:flutter/material.dart';

import 'package:shorts/constants.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labeltext;
  final IconData icon;
  final bool isObscure;

  TextInputField({
    Key? key,
    required this.controller,
    required this.labeltext,
    required this.icon,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: isObscure,
        controller: controller,
        decoration: InputDecoration(
          labelText: labeltext,
          prefixIcon: Icon(icon),
          labelStyle: const TextStyle(fontSize: 25),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(color: borderColor)),
        ));
  }
}
