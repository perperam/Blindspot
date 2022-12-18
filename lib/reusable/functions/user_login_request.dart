import 'package:firebase_auth/firebase_auth.dart';

//return bool
//userLoginRequest

void userLoginRequest (Function userIsLoggedIn, Function userIsNotLoggedIn){

  FirebaseAuth.instance.userChanges().listen((User? user) {
    if (user != null) {
      userIsLoggedIn();
    } else {
      userIsNotLoggedIn();
    }

  });

}