import 'package:blindspot/screens/screen_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../reusable_widget.dart';
import 'package:blindspot/Settings/colors.dart';
import 'package:flutter/material.dart';
import 'tabs_home/tab_settings.dart';
import 'package:hive/hive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class CreateAccountScreen extends StatefulWidget {
  final bool value;
  const CreateAccountScreen({Key? key, required this.value}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {

  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        //backgroundColor: Colors.transparent,
        //elevation: 0,
        title: const Text(
          "Create Account",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    reusableTextField("Enter UserName", Icons.person_outline, false,
                        _userNameTextController),
                    const SizedBox(
                      height: 15,
                    ),
                    reusableTextField("Enter Email Adress", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 15,
                    ),
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 15,
                    ),
                    firebaseUIButton(context, "Create Account", () {
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) {
                        print("Created New Account");
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyLogin()));
                      }).onError((error, stackTrace) {
                        ScaffoldMessenger.of(context).showSnackBar(Massage("Error ${error.toString()}"));
                        print("Error ${error.toString()}");
                    });
                  })
                ],),
              ))),
    );
  }
}