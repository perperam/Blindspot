import 'package:flutter/material.dart';

class RedSettingsButton extends StatelessWidget {
  const RedSettingsButton({super.key, required this.text, required this.onPressed});
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200.0,
        height: 30.0,
        child: OutlinedButton(
          onPressed: () {
            onPressed();
          },
          child: Text(text, style: const TextStyle(color: Colors.red)),
        )
    );
  }
}

settingsButtonRed(String name, Function() onTap) {
  return SizedBox(
      width: 200.0,
      height: 20.0,
      child: OutlinedButton(
        child: Text(name, style: const TextStyle(color: Colors.red)),
        onPressed: () async {
          onTap();
        },
      ));
}

/*
class ActiveUserSetting extends StatelessWidget {
  const ActiveUserSetting({super.key, required this.currentUser});

  final String? currentUser;

  @override
  Widget build(BuildContext context) {
    return Text("Hello, you are logged in as:\n$currentUser\n");
  }
}

class LogOutSetting extends StatelessWidget {
  const LogOutSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return RedSettingsButton(
        text: 'Sign out',
        onPressed: () {
          userLoginRequest(() {
            massage('Logged Out successful');
          }, () {
            massage('Error with logout');
          });

          FirebaseAuth.instance.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        });
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

class DarkModeSetting extends StatelessWidget {
  const DarkModeSetting({super.key, required this.darkMode});

  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(darkMode ? 'Dark Mode' : 'Light Mode'),
      Switch(
        value: darkMode,
        onChanged: (val) {
          print('THE VALUE: $val');
          Hive.box(themeBox).put('darkMode', !darkMode);
          //reloadToHomeScreen(Navigator.of(context));
          FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .set({"darkMode": !darkMode});
        },
      ),
    ]);
  }
}
*/