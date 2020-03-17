import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import 'textfieldcustom.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  DateTime _dateTime;
  final _formKey = GlobalKey<FormState>();
  Color ktextcolor = Color.fromRGBO(143, 148, 251, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          'Tarvel Authorization Form',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                FadeAnimation(
                  1.8,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFieldCustom(
                          title: 'Name',
                          keyboardstyle: TextInputType.text,
                          text: 'Traveler\'s Name: ',
                          validator: (value){

                          },
                        ),
                        TextFieldCustom(
                          title: 'Email',
                          keyboardstyle: TextInputType.emailAddress,
                          text: 'Traveler\'s Email: ',
                        ),
                        TextFieldCustom(
                          title: 'Department',
                          keyboardstyle: TextInputType.text,
                          text: 'Department:',
                        ),
                        TextFieldCustom(
                          title: 'Supervisor\'s Email',
                          keyboardstyle: TextInputType.emailAddress,
                          text: 'Supervisor\'s Email: ',
                        ),

                        TextFieldCustom(
                          title: 'Division',
                          keyboardstyle: TextInputType.text,
                          text:  'Division:',
                        ),
                        TextFieldCustom(
                          title: 'Project',
                          keyboardstyle: TextInputType.text,
                          text:  'Project:',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(

                              children: <Widget>[
                                Text(
                                  'Start Date:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ktextcolor,
                                      fontWeight: FontWeight.w600),
                                ),
                                RaisedButton(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  shape: StadiumBorder(),
                                  child: Text(
                                    'Pick a date',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: _dateTime == null
                                            ? DateTime.now()
                                            : _dateTime,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2021))
                                        .then((date) {
                                      setState(() {
                                        _dateTime = date;
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'End Date:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ktextcolor,
                                      fontWeight: FontWeight.w600),
                                ),
                                RaisedButton(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  shape: StadiumBorder(),
                                  child: Text(
                                    'Pick a date',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    showDatePicker(
                                        context: context,
                                        initialDate: _dateTime == null
                                            ? DateTime.now()
                                            : _dateTime,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2021))
                                        .then((date) {
                                      setState(() {
                                        _dateTime = date;
                                      });
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            2,
                            Center(
                              child: Container(
                                height: 45,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Next",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
