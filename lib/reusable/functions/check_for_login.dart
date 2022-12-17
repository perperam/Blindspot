import 'package:firebase_auth/firebase_auth.dart';

dynamic checkForLogin({required dynamic hasUser, required dynamic noUser}) {
  final String? currentUser = FirebaseAuth.instance.currentUser?.email;

  if (currentUser == null) {
    return noUser;
  } else {
    return hasUser;
  }
}