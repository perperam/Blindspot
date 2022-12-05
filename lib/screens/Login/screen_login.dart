import 'package:blindspot/screens/Login/CreateAccount.dart';
import 'package:blindspot/screens/Login/reusable_widget.dart';
import 'package:flutter/material.dart';
import '../screen_home.dart';
import 'package:blindspot/Settings/Colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  MyLoginState createState() => MyLoginState();
}


class MyLoginState extends State<MyLogin> {
  User? user; //track the authenticated user here
  final emailInput = TextEditingController(text: '');
  final passInput = TextEditingController(text: '');
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: const Text("Login into Blindspot")),
        body: Container(
          color: CustomColors.Background,
          margin: EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 15,
            children: [
              Column(children: [
                const Image(
                    image: AssetImage('assets/logo.png'),
                    width: 200,
                    height: 200),

                reusableTextField("Enter Email adress", Icons.person_outline, false,
                    emailInput),
                const SizedBox(height: 20),
                reusableTextField("Enter password", Icons.lock_outline, true,
                    passInput),
                const SizedBox(height: 20),

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountScreen()));
                }),

                firebaseUIButton(context, "To Homescreen without Login", (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeRoute()));

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
                    });
                })

    ])],)));
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
