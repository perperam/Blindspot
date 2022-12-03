import 'package:blindspot/screens/Login/CreateAccount.dart';
//import 'package:blindspot/screens/Login/reusable_widget.dart';
import 'package:flutter/material.dart';
import '../login/reusable_widget.dart';
import '../screen_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
//import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';


class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);
  @override
  MyLoginState createState() => MyLoginState();
}


class MyLoginState extends State<MyLogin> {
  User? user; //track the authenticated user here

  final emailInput = TextEditingController(text: '');
  final passInput = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login into Blindspot")),
        body: Container(
            color: Colors.blueGrey,
            //margin: EdgeInsets.all(20),
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
                  firebaseUIButton(context, "Sign In", () {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailInput.text,
                        password: passInput.text).then((value) {
                      if ( user == null){
                        ScaffoldMessenger.of(context).showSnackBar(ErrorMassage());
                      } else{
                        Navigator.push(context,MaterialPageRoute(builder: (context) => HomeRoute()));
                      }
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  }),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountScreen()));
                        },
                      child: Text(
                        'Create Acount',
                        style: const TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.black26;
                            }
                            return Colors.white;
                          }),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                    )),
                  SignInButton(
                      Buttons.Google,
                      onPressed: () {
                        loginWithGoogle();
                        if ( user == null){
                          ScaffoldMessenger.of(context).showSnackBar(ErrorMassage());
                        } else{
                          Navigator.push(context,MaterialPageRoute(builder: (context) => HomeRoute()));
                        }
                      }
                  ),
                  // Test and message if correct

                  OutlinedButton(
                      child: Text('To Homescreen without Login', style: TextStyle(color: Colors.white70)),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomeRoute()))
    ),])],)));
  }

  Widget userInfo() {
    if (user == null)
      return Text('Not signed in.');
    else{
      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeRoute()));
      return Text('Not signed in.');
      /*
      return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        if (user.photoURL != null) Image.network(user.photoURL!, width: 50),
        Text('Signed in as ${user.displayName != null
            ? user.displayName! + ', '
            : ''}${user.email}.')
      ]);
       */
    }
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

/*
class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Login into Blindspot")),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                  image: AssetImage('assets/logo.png'),
                  width: 200,
                  height: 200),
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
              ElevatedButton(
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const HomeRoute())),
                  child: const Text('Login'))
            ]));
  }
}
 */