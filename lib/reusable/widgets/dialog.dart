import 'package:flutter/material.dart';

import 'package:blindspot/reusable/functions/local_storage.dart';
import 'package:blindspot/reusable/functions/relaod_home_screen.dart';

class SaveAlertDialog extends StatelessWidget {
  const SaveAlertDialog({super.key, required this.onSave});
  final Function onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save you Image with an Specific name'),
      content: const TextField(
          decoration: InputDecoration(hintText: 'Name InputData')
      ),
      actions: [
        SubmitButton(
            onPressed: onSave()
        ),
        const CancelButton()
      ],
    );
  }
}


class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed(),
        child: const Text('Submit'));
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {Navigator.pop(context);},
        child: const Text('Cancel'));
  }
}