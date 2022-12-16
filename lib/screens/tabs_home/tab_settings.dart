
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../reusable/functions/local_storage.dart';
import '../../reusable/functions/relaod_home_screen.dart';
import '../../reusable/functions/user_login_request.dart';
import '../../reusable/widgets/message.dart';
import '../../reusable/widgets/settings_button_red.dart';
import '../screen_login.dart';


const themeBox = 'hiveThemeBox';

class SettingsTab extends StatefulWidget {
  SettingsTab({Key? key, required this.callback, required this.darkMode})
      : super(key: key);
  final bool darkMode;
  final String? currentUser = FirebaseAuth.instance.currentUser?.email;
  final Function callback;

  @override
  State<SettingsTab> createState() => _SettingsTab();
}

class _SettingsTab extends State<SettingsTab> {
  bool testValue = true;

  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return Scaffold( body: (
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Hello, you are logged in as:\n${widget.currentUser}\n"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.darkMode ? 'Dark Mode' : 'Light Mode'),
                    Switch(
                      value: widget.darkMode,
                      onChanged: (val) {
                        Hive.box(themeBox).put('darkMode', !widget.darkMode);
                        //reloadToHomeScreen(Navigator.of(context));
                        FirebaseFirestore.instance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .set({"darkMode": !widget.darkMode});
                      },
                    ),
                    const SizedBox(height: 10),
                  ]),
              DeleteAllDataSetting(callback: widget.callback),
              const SizedBox(height: 10),
              settingsButtonRed('Sign out', () {
                userLoginRequest(() {
                  massage('Logged Out successful');
                }, () {
                  massage('Error with logout');
                });
                FirebaseAuth.instance.signOut();
                //Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return LoginScreen();
                }));
              }),

              const SizedBox(height: 10),
              const Text('AppVersion: 0.1'),
              OutlinedButton(
                child: Text(
                    'Sign out', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              )
            ])
    ));
  }
}

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