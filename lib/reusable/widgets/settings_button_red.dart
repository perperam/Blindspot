import 'package:flutter/material.dart';

settingsButtonRed(String name, Function() onTap) {
  return SizedBox(
      width: 200.0,
      height: 20.0,
      child: OutlinedButton(
        child: Text(name, style: const TextStyle(color: Colors.red)),
        onPressed: () async {
          onTap();
        },
      ));
}
