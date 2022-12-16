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


*/