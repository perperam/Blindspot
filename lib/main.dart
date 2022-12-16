import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'reusable/login_state.dart';
import 'screens/tabs_home/tab_settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:blindspot/config/config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(themeBox);
  runApp(const MaterialApp(title: 'Blindspot', home: Blindspot()));
}

class Blindspot extends StatelessWidget {
  const Blindspot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //to update the UI without using setState()
    return ValueListenableBuilder(
      valueListenable: Hive.box(themeBox).listenable(),
      builder: (context, box, widget) {//saving the value inside the hive box,
      var darkMode = Hive.box(themeBox).get('darkMode', defaultValue: false);
        return MaterialApp(
          debugShowCheckedModeBanner: false, //switching between light and dark theme,
          themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
          darkTheme: ThemeData.dark(),
          home: const LoginState(),
        );
      },
    );
  }
}
