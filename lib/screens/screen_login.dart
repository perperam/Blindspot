import 'package:flutter/material.dart';
import 'screen_home.dart';
import 'package:blindspot/reusable/widgets/text_field.dart';
import 'package:blindspot/reusable/funktions/user_login_request.dart';
import 'package:blindspot/screens/screen_create_account.dart';
import 'package:blindspot/reusable/widgets/firebase_ui_button.dart';
import 'package:blindspot/reusable/widgets/massage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'tabs_home/tab_settings.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MyLogin extends StatefulWidget {
  //final bool value;
  //const MyLogin({Key? key, required this.value}) : super(key: key);
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLogin createState() => _MyLogin();
}

class _MyLogin extends State<MyLogin> {
  User? user; //track the authenticated user here
  final emailInput = TextEditingController(text: '');
  final passInput = TextEditingController(text: '');
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    //if (user eingeloggt, dann){
    //
    //}
    return Scaffold(
        body: Container(
            //color: CustomColors.Background,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 20, 20, 0),
                  child: Column(children: <Widget>[
                    const SizedBox(height: 15),
                    Text("Welcome to Blindspot!",
                        style: const TextStyle(
                          fontSize: 28,
                        )),
                    const Image(
                        image: AssetImage('assets/logo.png'),
                        width: 200,
                        height: 200),
                    text_field("Enter Email adress", Icons.person_outline,
                        false, emailInput),
                    const SizedBox(height: 15),
                    text_field(
                        "Enter password", Icons.lock_outline, true, passInput),
                    const SizedBox(height: 15),
                    firebase_ui_button(context, "Login with Email", () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailInput.text, password: passInput.text)
                          .then((value) {
                            FirebaseFirestore.instance.collection("user").doc(FirebaseAuth.instance.currentUser?.uid).get().then(
                                    (DocumentSnapshot doc) {
                                    final data = doc.data() as Map<String, dynamic>;
                                    final cloudDarkMode = data["darkMode"];
                                    Hive.box(themeBox).put('darkMode', cloudDarkMode);
                                    print(cloudDarkMode);
                                });
                      })
                          .onError((error, stackTrace) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(massage("Error ${error.toString()}"));
                        print("Error ${error.toString()}");
                      });
                      user_login_request(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) {
                                  return const HomeRoute();
                                },
                                settings: RouteSettings(name: 'HomeRoute')));
                      }, () {});
                    }),
                    firebase_ui_button(context, 'Create Acount', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) {
                                return const CreateAccountScreen();
                              },
                              settings:
                                  RouteSettings(name: 'CreateAccountScreen')));
                    }),
                    firebase_ui_button(context, "To Homescreen without Login",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) {
                                return HomeRoute();
                              },
                              settings: RouteSettings(name: 'HomeScreen')));
                    }),
                    SignInButton(Buttons.Google, onPressed: () {
                      loginWithGoogle()
                          .then((value) {})
                          .onError((error, stackTrace) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(massage("Error ${error.toString()}"));
                        print("Error ${error.toString()}");
                        user_login_request(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) {
                                    return HomeRoute();
                                  },
                                  settings: RouteSettings(name: 'HomeScreen')));
                        }, () {});
                      });
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
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
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
