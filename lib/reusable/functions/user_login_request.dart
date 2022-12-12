import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blindspot/screens/screen_login.dart';

//Rückgabe bool
//userLoginRequest

void user_login_request (Function user_is_logged_in, Function user_is_not_logged_in){

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseAuth.instance.userChanges().listen((User? user) {
    if (user != null) {

      user_is_not_logged_in();
    } else {

      user_is_logged_in();
    }

  });

}

/*
bool user_login_request (Function user_is_logged_in, Function user_is_not_logged_in){
  bool value = false;
  FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user != null) {
        value= true;
        user_is_not_logged_in();
      } else {
        value = false;
        user_is_logged_in();
      }

    });
  return value;
}

class user_log_request {
  Function user_is_not_logged_in;
  Function user_is_logged_in;

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseAuth.instance.userChanges().listen((User? user) {
    if (user == null) {
      return user_is_not_logged_in();
    } else {
      return user_is_logged_in();
    }
  }
  }
}

*/