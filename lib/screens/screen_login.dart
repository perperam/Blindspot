import 'package:flutter/material.dart';
import 'screen_home.dart';

class LogScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text("Login into Blindspot")
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Container(width: 150, height: 150, color: Colors.red),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your username',
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter your password',
                  ),
                ),
                ElevatedButton(onPressed: () => Navigator.push (context, MaterialPageRoute(builder: (_) => HomeRoute() )), child: Text('Login'))
              ]
        )
    );


        // Center(child:(
        //     //FlutterLogin(onLogin: ),
        //     ElevatedButton(child: Text('Login'), color: CupertinoColors.activeBlue, onPressed: () => Navigator.push (context, CupertinoPageRoute(builder: (_) => HomeScreen() )))
        // )));
  }
}

