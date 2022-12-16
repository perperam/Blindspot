import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../reusable/widgets/settings_button_red.dart';
import 'package:blindspot/config/config.dart';

// import settings widgets
import '../../reusable/widgets/settings_active_user.dart';
import '../../reusable/widgets/settings_dark_mode.dart';
import '../../reusable/widgets/settings_delete_all_data.dart';
import '../../reusable/widgets/settings_log_out_in.dart';
import '../../reusable/widgets/settings_app_version.dart';


class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key, required this.callback, required this.darkMode})
      : super(key: key);
  final bool darkMode;
  final Function callback;

  @override
  State<SettingsTab> createState() => _SettingsTab();
}

class _SettingsTab extends State<SettingsTab> {

  @override
  Widget build(BuildContext context) {
    Hive.box(themeBox).get('darkMode', defaultValue: false);
    return Scaffold( body: (
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ActiveUserSetting(),
              DarkModeSetting(darkMode: widget.darkMode),
              DeleteAllDataSetting(callback: widget.callback),
              const SizedBox(height: 10),
              RedSettingsButton(text: 'DO CALLBACK', onPressed: widget.callback),
              const SizedBox(height: 10),
              LogOutInSetting(),
              const SizedBox(height: 10),
              const AppVersionSetting(),
            ])
    ));
  }
}