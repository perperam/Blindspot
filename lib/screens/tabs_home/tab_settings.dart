
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

class SettingsTab extends StatelessWidget {
  final bool value;
  final String? currentUser = FirebaseAuth.instance.currentUser?.email;
  SettingsTab({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return Scaffold( body: (
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Hello, you are logged in as:\n$currentUser\n"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(value ? 'Dark Mode' : 'Light Mode'),
                    Switch(
                      value: value,
                      onChanged: (val) {
                        Hive.box(themeBox).put('darkMode', !value);
                        //reloadToHomeScreen(Navigator.of(context));
                        FirebaseFirestore.instance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .set({"darkMode": !value});
                      },
                    ),
                    const SizedBox(height: 10),
                  ]),
              settingsButtonRed('Delete all Data', () {
                deleteAllImageData();
                // should be changed to something different ??

                final NavigatorState navigator = Navigator.of(context);
                reloadToHomeScreen(navigator);
              }),
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

/*
class SettingsTab extends StatefulWidget{
  var darkmode;
  SettingsTab({Key? key, required this.darkmode}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTab(value: darkmode);

}

class _SettingsTab extends State<SettingsTab>{
  bool value;
  bool valueUser = false;
  final String? currentUser = FirebaseAuth.instance.currentUser?.email;

  _SettingsTab({Key? key, required this.value});
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return Scaffold(
        body: (Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Hello, you are logged in as:\n$currentUser\n"),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Text(value ? 'Dark Mode' : 'Light Mode'),
                Switch(
                  value: value,
                  onChanged: (val) {
                    Hive.box(themeBox).put('darkMode', !value);
                    FirebaseFirestore.instance
                        .collection("user")
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .set({"darkMode": !value});

                  },
                )
              ]),
              const Text('AppVersion: 0.1'),
              const SizedBox(height: 10),
              settingsButtonRed('Delete all Data', () {
                deleteAllImageData();
                // should be changed to something different ??

                final NavigatorState navigator = Navigator.of(context);
                reloadToHomeScreen(navigator);
              }),
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
            ])));
  }
}
*/
// PUSH / POP issue first "if" for ever