import 'package:flutter/material.dart';

import 'package:blindspot/config/config.dart';

class AppVersionSetting extends StatelessWidget {
  const AppVersionSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Current App Version: $appVersion');
  }
}