import 'package:flutter/material.dart';
import 'textfieldcustom.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class BasicInfo extends StatefulWidget {
  static String id = 'basic_info';

  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  Map formDetails = {};
  Color kTextColor = Color.fromRGBO(143, 148, 251, 1);

  String name;
  String supemail;
  String dept;
  String div;
  String designation;
  List Designation=['GM and Above','DGM/Sr. Manager/Manager','Asst Manager/Sr Engineer','Engineer/Asst Engineer/Trainee','All Grade'];



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
                          attribute: 'email',
                          hint: 'Email',
                          keyboardstyle: TextInputType.emailAddress,
                          text: 'Supervisor\'s Email: ',
                          validator: [FormBuilderValidators.required()],
                          onsaved: (value) {
                            supemail = value;
                          },
                        ),
                        TextFieldCustom(
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
                          attribute: 'division',
                          hint: 'Division',
                          keyboardstyle: TextInputType.text,
                          text: 'Division:',
                          validator: [FormBuilderValidators.required()],
                          onsaved: (value) {
                            div = value;
                          },
                        ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Designation',
                          style: TextStyle(
                              fontSize: 18, color: Color.fromRGBO(143, 148, 251, 1), fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5.0),
                          height: 65,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 15.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Center(
                            child: FormBuilderDropdown(
                              attribute: "designation",
                              onChanged: (val) {
                                setState(() {
                                  designation = val;
                                });
                              },
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
                              validators: [FormBuilderValidators.required()],
                              items: Designation.map((mode) => DropdownMenuItem(
                                  value: mode, child: Text("$mode"))).toList(),
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
                            onPressed: () {
                              if (_fbKey.currentState.saveAndValidate()) {
                                formDetails = _fbKey.currentState.value;

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
