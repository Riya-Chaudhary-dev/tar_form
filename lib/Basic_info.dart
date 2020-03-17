import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import 'textfieldcustom.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  DateTime _dateTime;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                    1.8,
                    FormBuilder(
                      key: _fbKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFieldCustom(
                            title: 'Name',
                            keyboardstyle: TextInputType.text,
                            text: 'Traveler\'s Name: ',
                            validator: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(3),
                            ],
                          ),
                          TextFieldCustom(
                            title: 'Email',
                            keyboardstyle: TextInputType.emailAddress,
                            text: 'Traveler\'s Email: ',
                            validator: [FormBuilderValidators.required()],
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
                            validator: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ],
                          ),
                          TextFieldCustom(
                            title: 'Division',
                            keyboardstyle: TextInputType.text,
                            text: 'Division:',
                            validator: [FormBuilderValidators.required()],
                          ),
                          TextFieldCustom(
                            title: 'Project',
                            keyboardstyle: TextInputType.text,
                            text: 'Project:',
                            validator: [FormBuilderValidators.required()],
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
                              GestureDetector(
                                onTap: () {
                                  if (_fbKey.currentState.saveAndValidate()) {
                                    print('yooo');
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Processing Data')));
//                                  // If the form is valid, we want to show a Snackbar
////                                  Scaffold.of(context)
////                                      .showSnackBar(SnackBar(
////                                        content: Text('Processing Data'),
////                                      ))
////                                      .closed
////                                      .then((SnackBarClosedReason reason) {
////                                    _opennewpage();
////                                  });
                                  }
                                },
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_fbKey.currentState.saveAndValidate()) {
                                        print(_fbKey.currentState.value);
                                      }
                                    },
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
      ),
    );
  }


}
