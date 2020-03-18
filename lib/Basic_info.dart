import 'package:flutter/material.dart';
import 'Animation/FadeAnimation.dart';
import 'textfieldcustom.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  DateTime _dateTime;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Color ktextcolor = Color.fromRGBO(143, 148, 251, 1);
  DateTime fromDate = new DateTime.now();
  DateTime toDate = new DateTime.now().add(Duration(days: 1));
  String fromDay = 'Today';
  String toDay = 'Tomorrow';
  String name;
  String email;
  String supEmail;
  String dept;
  String div;
  String project;

  selectDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDate,
        initialLastDate: toDate,
        firstDate: (new DateTime.now()).subtract(new Duration(days: 1)),
        lastDate: new DateTime(2022)
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        fromDate = picked[0];
        toDate = picked[1];
        fromDay = whichDay(picked[0]);
        toDay = whichDay(picked[1]);
      });
    }
  }

  String whichDay(DateTime date) {
    if (DateFormat.yMMMd().format(date).toString() ==
        DateFormat.yMMMd().format(DateTime.now()).toString()) {
      return 'Today';
    } else if (DateFormat.yMMMd().format(date).toString() == DateFormat.yMMMd()
        .format(DateTime.now().add(Duration(days: 1)))
        .toString()) {
      return 'Tomorrow';
    } else {
      return new DateFormat.E().format(date).toString();
    }
  }
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
                            onsaved: (value){
                              name=value;
                              print(name);
                            },
                          ),
                          TextFieldCustom(
                            title: 'Email',
                            keyboardstyle: TextInputType.emailAddress,
                            text: 'Traveler\'s Email: ',
                            validator: [FormBuilderValidators.required()],
                            onsaved: (value){
                              email=value;
                            },
                          ),
                          TextFieldCustom(
                            title: 'Department',
                            keyboardstyle: TextInputType.text,
                            text: 'Department:',
                            validator: [
                              FormBuilderValidators.required(),
                            ],
                            onsaved: (value){
                              dept=value;
                              print(dept);
                            },
                          ),
                          TextFieldCustom(
                            title: 'Supervisor\'s Email',
                            keyboardstyle: TextInputType.emailAddress,
                            text: 'Supervisor\'s Email: ',
                            validator: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email(),
                            ],
                            onsaved: (value){
                              setState(() {
                                supEmail=value;
                                print(supEmail);
                              });

                            },
                          ),
                          TextFieldCustom(
                            title: 'Division',
                            keyboardstyle: TextInputType.text,
                            text: 'Division:',
                            validator: [FormBuilderValidators.required()],
                            onsaved: (value){
                              div=value;
                              print(div);
                            },
                          ),
                          TextFieldCustom(
                            title: 'Project',
                            keyboardstyle: TextInputType.text,
                            text: 'Project:',
                            validator: [FormBuilderValidators.required()],
                            onsaved: (value){
                              project=value;
                              print(project);
                            },
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
                                  Container(
                                    height: 35,
                                    padding: EdgeInsets.symmetric(horizontal: 7),
//                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ])),
                                    child: Center(
                                      child: Text(
                                        DateFormat.d().format(fromDate).toString()+' ' +DateFormat.MMM().format(fromDate).toString()+', '+DateFormat.y().format(fromDate).toString(),
                                      style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Text(fromDay,style: TextStyle(color: Colors.blueGrey[700],fontWeight: FontWeight.w600)),
                                ],
                              ),
                              GestureDetector(
                                onTap: selectDate,
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ]),
                                    border: Border.all(
                                      color: Color.fromRGBO(143, 148, 251, 8), //                   <--- border color
                                      width: 3.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(toDate.difference(fromDate).inDays.toString()+' N',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
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
                                  Container(
                                    height: 35,
                                    padding: EdgeInsets.symmetric(horizontal: 7),
//                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(colors: [
                                          Color.fromRGBO(143, 148, 251, 1),
                                          Color.fromRGBO(143, 148, 251, .6),
                                        ])),
                                    child: Center(
                                      child: Text(
                                      DateFormat.d().format(toDate).toString()+' ' +DateFormat.MMM().format(toDate).toString()+', '+DateFormat.y().format(toDate).toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    ),
                                  ),
                                  Text(toDay,style: TextStyle(color: Colors.blueGrey[700],fontWeight: FontWeight.w600),),

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
                                child: RaisedButton(
                                  padding: EdgeInsets.all(8),
                                  onPressed: (){
                                    if (_fbKey.currentState.saveAndValidate()) {
                                      print(_fbKey.currentState.value);
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                          content: Text('Processing Data')));
                                    }
                                  },
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  shape: StadiumBorder(),
                                  child: Text(
                                    "Next",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
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
