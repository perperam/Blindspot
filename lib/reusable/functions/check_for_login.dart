import 'package:firebase_auth/firebase_auth.dart';

final String? _currentUser = FirebaseAuth.instance.currentUser?.email;

dynamic checkForLogin({required dynamic hasUser, required dynamic noUser}) {
  if (_currentUser == null) {
    return noUser;
  } else {
    return hasUser;
  }
}