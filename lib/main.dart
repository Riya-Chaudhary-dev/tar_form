import 'package:flutter/material.dart';
import 'package:tar_form/Basic_info.dart';
import 'package:tar_form/login_page.dart';
import 'package:tar_form/registration.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: RegistrationPage(),
    );
  }
}

