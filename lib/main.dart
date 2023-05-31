import 'package:chatting_app/consts/colors.dart';
import 'package:chatting_app/screens/auth%20screens/auth_control_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: AllColors.appBarColor,
        ),
        scaffoldBackgroundColor: AllColors.scaffoldBackgroundColor,
      ),
      home: const AuthControlPage(),
    );
  }
}
