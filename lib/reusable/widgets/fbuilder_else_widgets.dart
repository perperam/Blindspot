import 'package:flutter/material.dart';

class ElseError extends StatelessWidget {
  const ElseError({super.key, this.massage="Error!"});
  final String massage;


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
  const ElseWaiting({super.key, this.massage="loading..."});
  final String massage;

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