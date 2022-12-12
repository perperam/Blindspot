import 'package:flutter/material.dart';

SnackBar massage (String Massage){
  return SnackBar(
    content: Container(
      //Icon(Icons.error, color: CustomColors.Text,);
      child: Text(Massage),
    ),
    behavior: SnackBarBehavior.floating,
  );
}