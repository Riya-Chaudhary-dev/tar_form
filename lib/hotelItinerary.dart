import 'package:flutter/material.dart';
import 'HotelInfo.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:tar_form/custom_expansion_tile.dart' as custom;

class TravelItinerary extends StatefulWidget {
  @override
  _TravelItineraryState createState() => _TravelItineraryState();
}

bool allGood = true;

class _TravelItineraryState extends State<TravelItinerary> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  double advAmount;
  String advDescription;
  bool checkboxValue = false;
  bool advVal = false;
  int noOfLegs = 1;

  void addLegs({int legNo}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text(
            'Tarvel Itinerary',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SafeArea(child: SingleChildScrollView())));
  }
}
