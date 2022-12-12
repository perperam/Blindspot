import 'package:flutter/material.dart';


TextField textField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    //cursorColor: CustomColors.Text,
    //style: TextStyle(color: CustomColors.Text.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      labelText: text,
      //labelStyle: TextStyle(color: CustomColors.Text.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      //fillColor: CustomColors.Text.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}