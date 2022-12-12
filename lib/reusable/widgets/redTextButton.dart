import 'package:flutter/material.dart';

redTextButton(String name, Function() onTap) {
  return OutlinedButton(
    child: Text(name, style: const TextStyle(color: Colors.red)),
    onPressed: () async {
      onTap();
    },
  );
}
