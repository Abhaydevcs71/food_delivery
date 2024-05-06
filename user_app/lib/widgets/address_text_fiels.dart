

import 'package:flutter/material.dart';

class AddressTextField extends StatelessWidget {
  String? hint;
  TextEditingController? controller;
   AddressTextField({super.key,this.hint,this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration.collapsed(
        border: const OutlineInputBorder(borderSide: BorderSide(width: 2)),
        hintText: hint,),
      validator: (value) => value!.isEmpty ? "Field Cannot be empty" : null,
    );
  }
}