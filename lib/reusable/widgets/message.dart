import 'package:flutter/material.dart';

SnackBar massage (String massage){
  return SnackBar(
    content: Text(massage),
    behavior: SnackBarBehavior.floating,
  );
}