import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tbduitku/constanta.dart';
import 'package:tbduitku/pages/main_page.dart';
import 'package:tbduitku/pages/home_page.dart';
import 'constanta.dart';
import 'package:tbduitku/hidden_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HiddenDrawer(),
      theme: ThemeData(
          //nah ieu pake warna nu dijieun na constanta.dart
          scaffoldBackgroundColor: kScaffoldColor,
          bottomAppBarTheme: BottomAppBarTheme(color: kPrimaryColor),
          iconTheme: IconThemeData(color: kTextColor),
          primarySwatch: Colors.blue),
    );
  }
}
