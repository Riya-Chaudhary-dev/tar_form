import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'textfieldcustom.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditProfile extends StatefulWidget {
  static String id = 'edit_profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool showSpinner = false;
  Firestore _firestore = Firestore.instance;
  Map formDetails = {};
  Color kTextColor = Color.fromRGBO(143, 148, 251, 1);

  String name;
  bool hasData = false;
  String documentNo;
  String empID;
  String dept;
  String div;
  String designation;
  bool allGood = true;
  List Designation = [
    'GM and Above',
    'DGM/Sr. Manager/Manager',
    'Asst Manager/Sr Engineer',
    'Engineer/Asst Engineer/Trainee',
    'All Grade'
  ];

  Future getInfo() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var info = await Firestore.instance.collection('users').getDocuments();
    for (var q in info.documents) {
      if (q.data['email'] == user.email) {
        hasData = true;
        print(q.documentID);
        documentNo = q.documentID;
        name = q.data['name'];
        empID = user.email;
        designation = q.data['designation'];
        dept = q.data['department'];
        div = q.data['division'];
      }
    }
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getInfo(),
        builder: (BuildContext context, AsyncSnapshot user) {
          if (user.connectionState == ConnectionState.done) {
            return Stack(
              children: <Widget>[
                Scaffold(
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
                        child: Column(
                          children: <Widget>[
                            LinearProgressIndicator(
                              value: 0.3,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.orangeAccent.shade200),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: FormBuilder(
                                key: _fbKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextFieldCustom(
                                      initialValue: name,
                                      autovalidate: allGood ? false : true,
                                      height: allGood ? 56 : 71,
                                      attribute: 'name',
                                      hint: 'Name',
                                      keyboardstyle: TextInputType.text,
                                      text: 'Name: ',
                                      validator: [
                                        FormBuilderValidators.required(),
                                        FormBuilderValidators.minLength(3),
                                      ],
                                      onsaved: (value) {
                                        name = value;
                                      },
                                    ),
                                    TextFieldCustom(
                                      initialValue: empID,
                                      autovalidate: allGood ? false : true,
                                      height: allGood ? 56 : 71,
                                      attribute: 'employee id',
                                      hint: 'employee id',
                                      keyboardstyle: TextInputType.text,
                                      text: 'employee id: ',
                                      validator: [
                                        FormBuilderValidators.required()
                                      ],
                                      onsaved: (value) {
                                        empID = value;
                                      },
                                    ),
                                    TextFieldCustom(
                                      initialValue: dept,
                                      autovalidate: allGood ? false : true,
                                      height: allGood ? 56 : 71,
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
                                      initialValue: div,
                                      autovalidate: allGood ? false : true,
                                      height: allGood ? 56 : 71,
                                      attribute: 'division',
                                      hint: 'Division',
                                      keyboardstyle: TextInputType.text,
                                      text: 'Division:',
                                      validator: [
                                        FormBuilderValidators.required()
                                      ],
                                      onsaved: (value) {
                                        div = value;
                                      },
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Designation',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromRGBO(
                                                  143, 148, 251, 1),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5.0),
                                          height: 65,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        143, 148, 251, .2),
                                                    blurRadius: 15.0,
                                                    offset: Offset(0, 10))
                                              ]),
                                          child: Center(
                                            child: FormBuilderDropdown(
                                              initialValue: designation,
                                              attribute: "designation",
//                                              onChanged: (val) {
//                                                setState(() {
//                                                  designation = val;
//                                                });
//                                              },
                                              onSaved: (val) {
                                                setState(() {
                                                  designation = val;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              // initialValue: 'Male',
                                              hint: Text('Select designation'),
                                              validators: [
                                                FormBuilderValidators.required()
                                              ],
                                              items: Designation.map((mode) =>
                                                      DropdownMenuItem(
                                                          value: mode,
                                                          child: Text("$mode")))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
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
                                        onPressed: () async {
                                          if (_fbKey.currentState
                                              .saveAndValidate()) {
                                            formDetails =
                                                _fbKey.currentState.value;
                                            print(formDetails);
                                            setState(() {
                                              showSpinner = true;
                                            });
                                            try {
                                              if (hasData == false) {
                                                await _firestore
                                                    .collection('users')
                                                    .add(_fbKey
                                                        .currentState.value);
                                              }
                                              await _firestore
                                                  .collection('users')
                                                  .document(documentNo)
                                                  .updateData(_fbKey
                                                      .currentState.value);
                                              setState(() {
                                                showSpinner = false;
                                              });
                                            } catch (e) {
                                              setState(() {
                                                showSpinner = false;
                                              });
                                              print(e);
                                            }
                                          } else {
                                            setState(() {
                                              allGood = false;
                                            });
                                          }
                                        },
                                        color: Color.fromRGBO(143, 148, 251, 1),
                                        shape: StadiumBorder(),
                                        child: Text(
                                          "Save",
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
                ),
                showSpinner
                    ? Container(
                        color: Colors.black,
                        child: Center(
                          child: SpinKitWave(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            );
          } else if (user.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.black,
              child: Center(
                child: SpinKitWave(
                  color: Colors.white,
                ),
              ),
            );
          }
          return Text('Unknown error occured! Please contact support.');
        });
  }
}
