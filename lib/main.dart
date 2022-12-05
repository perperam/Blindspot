import 'package:flutter/material.dart';
import 'screens/Login/screen_login.dart';
import 'screens/screen_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(title: 'Blindspot', home: MyLogin()));
}



/*
void main() async{
  runApp(  YourApp() );
  }

class YourApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
          if (snapshot.hasData){
            FirebaseUser user = snapshot.data; // this is your user instance
            /// is because there is user already logged
            return HomeRoute();
          }
          /// other way there is no user logged.
          return MyLogin();
        }
    );
  }
}
*/