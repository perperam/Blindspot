import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blindspot/Settings/colors.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    //cursorColor: CustomColors.Text,
    style: TextStyle(color: CustomColors.Text.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      labelText: text,
      //labelStyle: TextStyle(color: CustomColors.Text.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      //fillColor: CustomColors.Text.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title, /*
       style: const TextStyle(
          color: CustomColors.Black, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return CustomColors.Black;
            }
            return CustomColors.Text;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
              */
      ),
    ),
  );
}

SnackBar Massage (String Massage){
  return SnackBar(
    content: Container(
      //Icon(Icons.error, color: CustomColors.Text,);
      child: Text(Massage),
    ),
    behavior: SnackBarBehavior.floating,
  );
}


