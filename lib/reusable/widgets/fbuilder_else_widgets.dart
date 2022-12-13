import 'package:flutter/material.dart';

class ElseError extends StatelessWidget {
  String massage;
  ElseError({super.key, this.massage="Error!"});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60),
              Text(massage)
            ]));
  }
}


class ElseWaiting extends StatelessWidget {
  String massage;
  ElseWaiting({super.key, this.massage="loading..."});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircularProgressIndicator(),
              Text(massage)
            ]));
  }
}