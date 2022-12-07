import 'package:blindspot/screens/screen_create_account.dart';
import 'package:blindspot/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'screen_home.dart';
import 'package:blindspot/Settings/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'tabs_home/tab_settings.dart';
import 'package:hive/hive.dart';

class MyLogin extends StatefulWidget {
  final bool value;
  const MyLogin({Key? key, required this.value}) : super(key: key);
  @override
  MyLoginState createState() => MyLoginState();
}


class MyLoginState extends State<MyLogin> {
  //final bool value;
  //const MyLoginState({Key? key, required this.value}) : super(key: key);
  User? user; //track the authenticated user here
  final emailInput = TextEditingController(text: '');
  final passInput = TextEditingController(text: '');
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return Scaffold(
        body: Container(
          color: CustomColors.Background,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                50, 20, 20, 0),
              child: Column(
                    children: <Widget> [
                  Text("Welcome to Blindspot! \nplease choose a Login-method", style: TextStyle(
                    color: CustomColors.Text, fontSize: 28,
                  )),
                  const Image(
                      image: AssetImage('assets/logo.png'),
                      width: 200,
                      height: 200),

                  reusableTextField("Enter Email adress", Icons.person_outline, false,
                      emailInput),
                  const SizedBox(height: 15),
                  reusableTextField("Enter password", Icons.lock_outline, true,
                      passInput),
                  const SizedBox(height: 15),

                  firebaseUIButton(context, "Login with Email", () {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailInput.text,
                      password: passInput.text).then((value) {})
                      .onError((error, stackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(
                          Massage("Error ${error.toString()}"));
                          print("Error ${error.toString()}");
                      });
                    reusableUserRequest((){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeRoute()));
                    }, (){});
                  }),

                  firebaseUIButton(context, 'Create Acount' , () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountScreen(value: darkMode)));
                  }),

                  firebaseUIButton(context, "To Homescreen without Login", (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeRoute()));
                  }),

                SignInButton(
                Buttons.Google,
                onPressed: () {
                  loginWithGoogle().then((value) {})
                      .onError((error, stackTrace) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        Massage("Error ${error.toString()}"));
                    print("Error ${error.toString()}");
                    reusableUserRequest((){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeRoute()));
                    },(){});
                  });
                }),
    ])),)));
  }

  Future<UserCredential?> loginWithEmail(String email, String pass) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: pass);
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
    final GoogleSignInAuthentication googleAuth = await googleUser!
        .authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
