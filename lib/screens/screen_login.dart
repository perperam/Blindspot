import 'package:blindspot/reusable/functions/relaod_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import project functions and widgets
import 'package:blindspot/config/config.dart';
import 'package:blindspot/screens/screen_create_account.dart';
import 'package:blindspot/screens/screen_home.dart';
import 'package:blindspot/reusable/widgets/text_field.dart';
import 'package:blindspot/reusable/functions/user_login_request.dart';
import 'package:blindspot/reusable/widgets/firebase_ui_button.dart';
import 'package:blindspot/reusable/widgets/message.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key, this.user});
  final User? user; //track the authenticated user here
  final emailInput = TextEditingController(text: '');
  final passInput = TextEditingController(text: '');
  final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            //color: CustomColors.Background,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(children: <Widget>[
                    const SizedBox(height: 15),
                    const Text("Welcome to Blindspot!",
                        style: TextStyle(
                          fontSize: 28,
                        )),
                    const Image(
                        image: AssetImage('assets/logo.png'),
                        width: 200,
                        height: 200),
                    textField("Enter Email adress", Icons.person_outline, false,
                        emailInput),
                    const SizedBox(height: 15),
                    textField(
                        "Enter password", Icons.lock_outline, true, passInput),
                    const SizedBox(height: 15),
                    firebaseUiButton(context, "Login with Email", () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailInput.text, password: passInput.text)
                          .then((value) {
                        FirebaseFirestore.instance
                            .collection("user")
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .get()
                            .then((DocumentSnapshot doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          final cloudDarkMode = data["darkMode"];
                          Hive.box(themeBox).put('darkMode', cloudDarkMode);
                        });
                      }).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(massage("Error ${error.toString()}"));
                      });
                      userLoginRequest(() {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) {
                                  return HomeScreen();
                                },
                                settings:
                                    const RouteSettings(name: 'HomeScreen')));
                      }, () {});
                    }),
                    firebaseUiButton(context, 'Create Account', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) {
                                return  CreateAccountScreen();
                              },
                              settings: const RouteSettings(
                                  name: 'CreateAccountScreen')));
                    }),
                    firebaseUiButton(context, "To Homescreen without Login",
                        () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) {
                                return  HomeScreen();
                              },
                              settings:
                                  const RouteSettings(name: 'HomeScreen')));
                    }),
                    SignInButton(Buttons.Google, onPressed: () {
                      loginWithGoogle()
                          .then((value) {})
                          .onError((error, stackTrace) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(massage("Error ${error.toString()}"));
                      });
                      userLoginRequest(() {
                        //reloadToHomeScreen(Navigator.of(context));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) {
                                  return  HomeScreen();
                                },
                                settings:
                                const RouteSettings(name: 'HomeScreen')));

                      }, () {});
                    }),
                  ])),
            )));
  }

  Future<UserCredential?> loginWithEmail(String email, String pass) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {
      }
      return Future.value(null);
    }
  }

  Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
