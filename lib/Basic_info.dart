import 'package:flutter/material.dart';
import 'package:tar_form/travelItinerary.dart';
import 'textfieldcustom.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

class BasicInfo extends StatefulWidget {
  static String id = 'basic_info';

  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Map formDetails = {};
  Color kTextColor = Color.fromRGBO(143, 148, 251, 1);
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  DateTime RequestedOn =DateTime.now();
  String fromDay = 'Today';
  String toDay = 'Tomorrow';
  int noOfDays = 1;

  String name;
  String email;
  String supEmail;
  String dept;
  String div;
  String project;
  bool allGood = true;
  String TANo;

  selectDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDate,
        initialLastDate: toDate,
        firstDate: (new DateTime.now()).subtract(new Duration(days: 1)),
        lastDate: new DateTime(2030));
    if (picked != null && picked.length == 2) {
      setState(() {
        fromDate = picked[0];
        toDate = picked[1];
        fromDay = whichDay(picked[0]);
        toDay = whichDay(picked[1]);
        noOfDays = (toDate.difference(fromDate).inDays + 1);
      });
    } else if (picked != null && picked.length == 1) {
      setState(() {
        fromDate = picked[0];
        toDate = picked[0];
        fromDay = whichDay(picked[0]);
        toDay = whichDay(picked[0]);
        noOfDays = (toDate.difference(fromDate).inDays + 1);
      });
    }
  }

  String whichDay(DateTime date) {
    if (DateFormat.yMMMd().format(date).toString() ==
        DateFormat.yMMMd().format(DateTime.now()).toString()) {
      return 'Today';
    } else if (DateFormat.yMMMd().format(date).toString() ==
        DateFormat.yMMMd()
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
        leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          'Traveler\'s Information',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                LinearProgressIndicator(
                  value: 0.25,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.orangeAccent.shade200),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(

                        children: <Widget>[
                          Text('TA No.:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: kTextColor),),
                          SizedBox(width: 2,),
                          Container(
//                                padding: EdgeInsets.only(left:5.0),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: kTextColor,
                                //                   <--- border color
                                width: 2.0,
                              ),
                            ),
                            child: Text('HA-23458',style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 14
                            ),),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text('Requested on:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: kTextColor),),
                          SizedBox(width: 2,),
                          Container(
//                                padding: EdgeInsets.only(left:5.0),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: kTextColor,
                                //                   <--- border color
                                width: 2.0,
                              ),
                            ),
                            child: Text(DateFormat.d().format(RequestedOn).toString() +
                                ' ' +
                                DateFormat.MMM()
                                    .format(RequestedOn)
                                    .toString() +
                                ' ' +
                                DateFormat.y()
                                    .format(RequestedOn)
                                    .toString(),style: TextStyle(
                                fontSize: 14
                            ),),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('NOTE: All field must be filled correctly to proceed. To make changes, refer to the \'Edit Profile\' page.',style: TextStyle(
                    fontWeight: FontWeight.w600,color: Colors.red, fontSize: 13
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FormBuilder(
                    key: _fbKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFieldCustom(
                          height: allGood? 56 : 71,
                          attribute: 'name',
                          hint: 'Name',
                          keyboardstyle: TextInputType.text,
                          text: 'Traveler\'s Name: ',
                          validator: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(3),
                          ],
                          onsaved: (value) {
                            name = value;
                          },
                        ),
                        TextFieldCustom(
                          height: allGood? 56 : 71,

                          attribute: 'email',
                          hint: 'Email',
                          keyboardstyle: TextInputType.emailAddress,
                          text: 'Traveler\'s Email: ',
                          validator: [FormBuilderValidators.required()],
                          onsaved: (value) {
                            email = value;
                          },
                        ),
                        TextFieldCustom(
                          height: allGood? 56 : 71,

                          attribute: 'department',
                          hint: 'Department',
                          keyboardstyle: TextInputType.text,
                          text: 'Department:',
                          validator: [
                            FormBuilderValidators.required(),
                          ],
                          onsaved: (value) {
                            dept = value;
                          },
                        ),
                        TextFieldCustom(
                          height: allGood? 56 : 71,

                          attribute: 'supervisor email',
                          hint: 'Supervisor\'s Email',
                          keyboardstyle: TextInputType.emailAddress,
                          text: 'Supervisor\'s Email: ',
                          validator: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ],
                          onsaved: (value) {
                            setState(() {
                              supEmail = value;
                            });
                          },
                        ),
                        TextFieldCustom(
                          height: allGood? 56 : 71,

                          attribute: 'division',
                          hint: 'Division',
                          keyboardstyle: TextInputType.text,
                          text: 'Division:',
                          validator: [FormBuilderValidators.required()],
                          onsaved: (value) {
                            div = value;
                          },
                        ),
                        TextFieldCustom(                          height: allGood? 56 : 71,


                          attribute: 'project',
                          hint: 'Project',
                          keyboardstyle: TextInputType.text,
                          text: 'Project:',
                          validator: [FormBuilderValidators.required()],
                          onsaved: (value) {
                            project = value;
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
                                      color: kTextColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  height: 35,
                                  padding: EdgeInsets.symmetric(horizontal: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Color.fromRGBO(143, 148, 251, 8),
                                      width: 3.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat.d()
                                              .format(fromDate)
                                              .toString() +
                                          ' ' +
                                          DateFormat.MMM()
                                              .format(fromDate)
                                              .toString() +
                                          ' ' +
                                          DateFormat.y()
                                              .format(fromDate)
                                              .toString(),
                                      style: TextStyle(color: kTextColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: selectDate,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
//
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ]),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Select Dates',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 19),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'No of days : ' + noOfDays.toString(),
                                  style: TextStyle(
                                      color: Colors.blueGrey[700],
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  'End Date:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: kTextColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  height: 35,
                                  padding: EdgeInsets.symmetric(horizontal: 7),
//                                    width: 150,

                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(143, 148, 251, 8),
                                      width: 3.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Center(
                                    child: Text(
                                      DateFormat.d().format(toDate).toString() +
                                          ' ' +
                                          DateFormat.MMM()
                                              .format(toDate)
                                              .toString() +
                                          ' ' +
                                          DateFormat.y()
                                              .format(toDate)
                                              .toString(),
                                      style: TextStyle(color: kTextColor),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 150),
                            onPressed: () {
                              if (_fbKey.currentState.saveAndValidate()) {
                                formDetails = _fbKey.currentState.value;
                                formDetails['from date'] = fromDate;
                                formDetails['to date'] = toDate;
//
//                                Navigator.popAndPushNamed(context, TravelItinerary.id,arguments: formDetails);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) => TravelItinerary(basicFormInfo: formDetails,),
                              ),);
                              }else{
                                setState(() {
                                  allGood =false;
                                });
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
                        ),
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
