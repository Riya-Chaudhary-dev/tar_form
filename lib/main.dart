import 'package:flutter/material.dart';
import 'package:tar_form/Basic_info.dart';
import 'package:tar_form/SummaryPage.dart';
import 'package:tar_form/hotelItinerary.dart';
import 'package:tar_form/login_page.dart';
import 'package:tar_form/registration.dart';
import 'package:tar_form/travelItinerary.dart';
import 'package:tar_form/travel_log.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.light,
          primaryColor: Color.fromRGBO(143, 148, 251, 1),
          accentColor: Color.fromRGBO(143, 148, 251, 1),
          splashColor: Color.fromRGBO(143, 148, 251, 1),
        ),
        home: SummaryPage(),
        routes: {
          RegistrationPage.id: (context) => RegistrationPage(),
          LoginPage.id: (context) => LoginPage(),
          BasicInfo.id: (context) => BasicInfo(),
          TravelItinerary.id: (context) => TravelItinerary(),
          HotelItinerary.id: (context) => HotelItinerary(),
        });
  }
}
