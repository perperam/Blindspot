import 'package:flutter/material.dart';

import '../../reusable/functions/local_storage.dart';
import '../../reusable/widgets/settings_button_red.dart';

class DeleteAllDataSetting extends StatelessWidget {
  const DeleteAllDataSetting({super.key, required this.callback});
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return RedSettingsButton(
        text: 'Delete all Data',
        onPressed: () {
          deleteAllImageData();
          callback();
        });
  }
}