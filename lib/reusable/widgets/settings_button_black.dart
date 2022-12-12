import 'package:flutter/material.dart';

settingsButtonBlack(String name, Function() onTap) {
  return Container(
      width: 200.0,
      height: 20.0,
      child: OutlinedButton(
        child: Text(name),
        onPressed: () async {
          onTap();
        },
      ));
}
