import 'package:flutter/material.dart';

import '../../reusable/functions/local_storage.dart';
import '../../reusable/widgets/settings_button_red.dart';
import '../../reusable/functions/cloud_sync.dart';

class DeleteAllDataSetting extends StatelessWidget {
  const DeleteAllDataSetting({super.key, required this.callback});
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return RedSettingsButton(
        text: 'Delete all Data',
        onPressed: () {
          deleteUserCloudData();
          deleteAllImageData();
          callback();
        });
  }
}