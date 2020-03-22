import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'Animation/FadeAnimation.dart';
import 'textfieldcustom.dart';

class DestinationPage extends StatefulWidget {
  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  String destination;
  String purpose;
  bool inttravel = false;
  double travelamt;
  double lodgeamt;
  double localamt;
  double meals;
  double businessmeals;
  String mealdescpt;
  double other;
  String otherdescription;
  String currency;
  String designation = 'GM and Above';

  @override
  List validatorLodge(designation) {
    if (designation == 'GM and Above') {
      return [
        FormBuilderValidators.required(),
        FormBuilderValidators.max(7500)
      ];
    } else if (designation == 'DGM/Sr. Manager/Manager') {
      return [
        FormBuilderValidators.required(),
        FormBuilderValidators.max(6000)
      ];
    } else if (designation == 'Asst Manager/Sr Engineer') {
      return [
        FormBuilderValidators.required(),
        FormBuilderValidators.max(5000)
      ];
    } else if (designation == 'Engineer/Asst Engineer/Trainee') {
      return [
        FormBuilderValidators.required(),
        FormBuilderValidators.max(4000)
      ];
    } else if (designation == 'All Grade') {
      return [
        FormBuilderValidators.required(),
        FormBuilderValidators.max(9000)
      ];
    }
  }

  List validatorMeal(designation) {
    if (designation == 'GM and Above' || designation == 'All Grade') {
      return [
        FormBuilderValidators.required(),
      ];
    } else {
      return [
        FormBuilderValidators.required(),
        FormBuilderValidators.max(1500)
      ];
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          'Tarvel Authorization Form',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              children: <Widget>[
                LinearProgressIndicator(
                  value: 0.4,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.orangeAccent.shade200),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: FadeAnimation(
                      1.8,
                      FormBuilder(
                        key: _fbKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFieldCustom(
                                title: 'Destination',
                                keyboardstyle: TextInputType.text,
                                text: 'Destination:',
                                validator: [
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(3),
                                ],
                                onsaved: (value) {
                                  destination = value;
                                  print(destination);
                                },
                              ),
                              Text(
                                'Purpose of Travel:',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              FadeAnimation(
                                  1.8,
                                  Container(
                                    padding: EdgeInsets.only(left: 5.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color.fromRGBO(
                                                  143, 148, 251, .2),
                                              blurRadius: 20.0,
                                              offset: Offset(0, 10))
                                        ]),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      child: FormBuilderTextField(
                                        attribute: "purpose",
//                                        onSaved: (value) {
//                                          purpose = value;
//                                          print(purpose);
//                                        },
                                        validators: [
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.minLength(3),
                                        ],
                                        keyboardType: TextInputType.text,
                                        maxLines: 6,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                                'If project related, indicate Project number and name of client OR '
                                                'Holtec Supervisor that is requesting the travel.)\n'
                                                'The traveler is required to elaborate the purpose and provide'
                                                ' brief description of the project here.',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[300],
                                                fontSize: 15)),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                child: CheckboxListTile(
                                  title: const Text('International Trip'),
                                  value: inttravel,
                                  onChanged: (bool value) {
                                    setState(() {
                                      inttravel = value;
                                    });
                                  },
                                  secondary: const Icon(
                                    Icons.card_travel,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: inttravel,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Select currency:',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    FormBuilderChoiceChip(
                                      onChanged: (val) {
                                        setState(() {
                                          currency = val;
                                          print(currency);
                                        });
                                      },
                                      spacing: 8,
                                      elevation: 2,
                                      attribute: "currency",
                                      options: [
                                        FormBuilderFieldOption(
                                            child: Text("INR"), value: "inr"),
                                        FormBuilderFieldOption(
                                            child: Text("USD"), value: "usd"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Details of Estimated Expense:',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(143, 148, 251, 1),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '*Travel (to & fro destination/in-between multiple destination):',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 120,
                                            padding: EdgeInsets.only(left: 5.0),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, .2),
                                                      blurRadius: 20.0,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, bottom: 1),
                                              child: FormBuilderTextField(
                                                attribute: "travelamt",
//                                                onSaved: (val) {
//                                                  setState(() {
//                                                    travelamt = val;
//                                                  });
//                                                },
                                                validators: [
                                                  FormBuilderValidators
                                                      .required(),
                                                  FormBuilderValidators
                                                      .numeric()
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter amount",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[300],
                                                        fontSize: 15)),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text('Terms and Conditions',
                                                  style:
                                                      TextStyle(fontSize: 13)),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.assignment,
                                                  color: Colors.redAccent,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      child: AlertDialog(
                                                          title: Text(
                                                            'HA-Travel policy(HA/16-17/001 Date:21/05/2016)\nThe limits of reimbursement are as follows:',
                                                          ),
                                                          content:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: DataTable(
                                                              columns: [
                                                                DataColumn(
                                                                    label: Text(
                                                                  'Grade',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .deepPurple,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16),
                                                                )),
                                                                DataColumn(
                                                                    label: Text(
                                                                  'Location Category',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .deepPurple,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16),
                                                                )),
                                                                DataColumn(
                                                                    label: Text(
                                                                  'Travel Mode Up Limit',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .deepPurple,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16),
                                                                )),
                                                              ],
                                                              rows: [
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'GM and above')),
                                                                  DataCell(Text(
                                                                      'Super-A/A/B/C')),
                                                                  DataCell(Text(
                                                                      'Air/Rail-AC1T/First Class ')),
                                                                ]),
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'DGM/Sr. Manager\n/Manager')),
                                                                  DataCell(Text(
                                                                      'Super-A/A/B/C')),
                                                                  DataCell(Text(
                                                                      'Air/Rail-AC2T')),
                                                                ]),
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'Asst Manager/\nSr Engineer')),
                                                                  DataCell(Text(
                                                                      'Super-A/A/B/C')),
                                                                  DataCell(Text(
                                                                      'Air/Rail-AC3T/Chair Car')),
                                                                ]),
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'Engineer/Asst \nEngineer/Trainee')),
                                                                  DataCell(Text(
                                                                      'Super-A/A/B/C')),
                                                                  DataCell(Text(
                                                                      'Air/Rail-AC3T/Sleeper Car')),
                                                                ]),
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'All Grades')),
                                                                  DataCell(Text(
                                                                      'D&E')),
                                                                  DataCell(Text(
                                                                      'Air')),
                                                                ]),
                                                              ],
                                                            ),
                                                          )
//                                                  Text('The limits of reimbursement of expenses for travel exceeding 200 km are as follows:\n'
//                                                      'Grade              Location Category              Travel Mode Up Limit'
//                                                      'GM and above        Super-A/A/B/C                  Air/Rail   '),),
                                                          ));
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Lodging/Hotel/Accommodation:',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'per day',
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 120,
                                            padding: EdgeInsets.only(left: 5.0),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, .2),
                                                      blurRadius: 20.0,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, bottom: 1),
                                              child: FormBuilderTextField(
                                                attribute: "lodgeamt",
                                                onSaved: (val) {
                                                  setState(() {
                                                   val!=null ? lodgeamt = double.parse(val) : lodgeamt = 0.0;
                                                  });
                                                },
                                                validators: [
                                                  FormBuilderValidators
                                                      .numeric(),
                                                  FormBuilderValidators
                                                      .required(),
                                                  FormBuilderValidators.max(
                                                      7500),
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter amount",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[300],
                                                        fontSize: 15)),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                'T&C',
                                                style: TextStyle(fontSize: 13,
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600),
                                              ),
//                                              IconButton(
//                                                icon: Icon(
//                                                  Icons.assignment,
//                                                  color: Colors.redAccent,
//                                                ),
//                                                onPressed: () {
//                                                  showDialog(
//                                                      context: context,
//                                                      child: AlertDialog(
//                                                          title: Text(
//                                                            'HA-Travel policy(HA/16-17/001 Date:21/05/2016)\nThe limits of reimbursement are as follows:',
//                                                          ),
//                                                          content:
//                                                              SingleChildScrollView(
//                                                            scrollDirection:
//                                                                Axis.horizontal,
//                                                            child: DataTable(
//                                                              dataRowHeight: 85,
//                                                              columns: [
//                                                                DataColumn(
//                                                                    label: Text(
//                                                                  'Grade',
//                                                                  style: TextStyle(
//                                                                      color: Colors
//                                                                          .deepPurple,
//                                                                      fontWeight:
//                                                                          FontWeight
//                                                                              .w600,
//                                                                      fontSize:
//                                                                          16),
//                                                                )),
//                                                                DataColumn(
//                                                                    label: Text(
//                                                                  'Location Category',
//                                                                  style: TextStyle(
//                                                                      color: Colors
//                                                                          .deepPurple,
//                                                                      fontWeight:
//                                                                          FontWeight
//                                                                              .w600,
//                                                                      fontSize:
//                                                                          16),
//                                                                )),
//                                                                DataColumn(
//                                                                    label: Text(
//                                                                  'Travel Mode Up Limit',
//                                                                  style: TextStyle(
//                                                                      color: Colors
//                                                                          .deepPurple,
//                                                                      fontWeight:
//                                                                          FontWeight
//                                                                              .w600,
//                                                                      fontSize:
//                                                                          16),
//                                                                )),
//                                                              ],
//                                                              rows: [
//                                                                DataRow(cells: [
//                                                                  DataCell(Text(
//                                                                      'GM and above')),
//                                                                  DataCell(Text(
//                                                                      'Super-A\nA\nB\nC')),
//                                                                  DataCell(Text(
//                                                                      '₹7500\n₹5000\n₹4000\n₹3000')),
//                                                                ]),
//                                                                DataRow(cells: [
//                                                                  DataCell(Text(
//                                                                      'DGM/Sr. Manager\n/Manager')),
//                                                                  DataCell(Text(
//                                                                      'Super-A\nA\nB\nC')),
//                                                                  DataCell(Text(
//                                                                      '₹6000\n₹4000\n₹3000\n₹2500')),
//                                                                ]),
//                                                                DataRow(cells: [
//                                                                  DataCell(Text(
//                                                                      'Asst Manager/\nSr Engineer')),
//                                                                  DataCell(Text(
//                                                                      'Super-A\nA\nB\nC')),
//                                                                  DataCell(Text(
//                                                                      '₹5000\n₹3500\n₹2500\n₹2000')),
//                                                                ]),
//                                                                DataRow(cells: [
//                                                                  DataCell(Text(
//                                                                      'Engineer/Asst \nEngineer/Trainee')),
//                                                                  DataCell(Text(
//                                                                      'Super-A\nA\nB\nC')),
//                                                                  DataCell(Text(
//                                                                      '₹4000\n₹3000\n₹2500\n₹2000')),
//                                                                ]),
//                                                                DataRow(cells: [
//                                                                  DataCell(Text(
//                                                                      'All Grades')),
//                                                                  DataCell(Text(
//                                                                      'D&E')),
//                                                                  DataCell(Text(
//                                                                      '₹9000')),
//                                                                ]),
//                                                              ],
//                                                            ),
//                                                          )
////
//                                                          ));
//                                                },
//                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Local Travel:',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'For Airport/Railway Station /Hotel \n/Project Site /Client Office',
                                            style: TextStyle(
                                                color: Colors.redAccent,
                                                fontSize: 13),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 120,
                                            padding: EdgeInsets.only(left: 5.0),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, .2),
                                                      blurRadius: 20.0,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, bottom: 1),
                                              child: FormBuilderTextField(
                                                attribute: "localamt",
//                                                onSaved: (val) {
//                                                  setState(() {
//                                                    localamt= val;
//                                                  });
//                                                },
                                                validators: [
                                                  FormBuilderValidators
                                                      .numeric(),
                                                  FormBuilderValidators
                                                      .required(),
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter amount",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[300],
                                                        fontSize: 15)),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text('Terms and Conditions',
                                                  style:
                                                      TextStyle(fontSize: 13)),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.assignment,
                                                  color: Colors.redAccent,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      child: AlertDialog(
                                                          title: Text(
                                                            'HA-Travel policy(HA/16-17/001 Date:21/05/2016)\nRoad Transportation to and from the airport',
                                                          ),
                                                          content: Text(
                                                              'Employees traveling to the same location should share road transportation to and from the airport whenever possible. The most economical mode of transportation should be used to and from the airport(ie bus and rail-terminals). Employees should consider public transportation, hotel and, airport shuttle services.')));
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Text(
                                        '*Meals:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 120,
                                            padding: EdgeInsets.only(left: 5.0),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, .2),
                                                      blurRadius: 20.0,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, bottom: 1),
                                              child: FormBuilderTextField(
                                                attribute: "meals",
//                                                onSaved: (val) {
//                                                  setState(() {
//                                                    meals = val;
//                                                  });
//                                                },
                                                validators: [
                                                  FormBuilderValidators
                                                      .numeric(),
                                                  FormBuilderValidators
                                                      .required(),
                                                  FormBuilderValidators.max(
                                                      1500)
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter amount",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[300],
                                                        fontSize: 15)),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                'Terms and Conditions',
                                                style: TextStyle(fontSize: 13),
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.assignment,
                                                  color: Colors.redAccent,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      child: AlertDialog(
                                                          title: Text(
                                                            'HA-Travel policy(HA/16-17/001 Date:21/05/2016)\nThe limits of reimbursement are as follows:',
                                                          ),
                                                          content:
                                                              SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: DataTable(
                                                              dataRowHeight: 85,
                                                              columns: [
                                                                DataColumn(
                                                                    label: Text(
                                                                  'Grade',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .deepPurple,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16),
                                                                )),
                                                                DataColumn(
                                                                    label: Text(
                                                                  'Location Category',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .deepPurple,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16),
                                                                )),
                                                                DataColumn(
                                                                    label: Text(
                                                                  'Travel Mode Up Limit',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .deepPurple,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16),
                                                                )),
                                                              ],
                                                              rows: [
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'GM and above')),
                                                                  DataCell(Text(
                                                                      'Super-A\nA\nB\nC')),
                                                                  DataCell(Text(
                                                                      'At Actual\nAt Actual\nAt Actual\nAt Actual')),
                                                                ]),
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'DGM/Sr. Manager\n/Manager')),
                                                                  DataCell(Text(
                                                                      'Super-A\nA\nB\nC')),
                                                                  DataCell(Text(
                                                                      '₹1500\n₹1000\n₹750\n₹750')),
                                                                ]),
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'Asst Manager/\nSr Engineer')),
                                                                  DataCell(Text(
                                                                      'Super-A\nA\nB\nC')),
                                                                  DataCell(Text(
                                                                      '₹1500\n₹1000\n₹750\n₹750')),
                                                                ]),
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'Engineer/Asst \nEngineer/Trainee')),
                                                                  DataCell(Text(
                                                                      'Super-A\nA\nB\nC')),
                                                                  DataCell(Text(
                                                                      '₹1500\n₹1000\n₹750\n₹750')),
                                                                ]),
                                                                DataRow(cells: [
                                                                  DataCell(Text(
                                                                      'All Grades')),
                                                                  DataCell(Text(
                                                                      'D&E')),
                                                                  DataCell(Text(
                                                                      'At Actual')),
                                                                ]),
                                                              ],
                                                            ),
                                                          )
//
                                                          ));
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Text(
                                        'Business Meals:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 120,
                                            padding: EdgeInsets.only(left: 5.0),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, .2),
                                                      blurRadius: 20.0,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, bottom: 1),
                                              child: FormBuilderTextField(
                                                attribute: "businessmeals",
//                                                onSaved: (val) {
//                                                  setState(() {
//                                                    businessmeals = val;
//                                                  });
//                                                },
                                                validators: [
                                                  FormBuilderValidators
                                                      .numeric(),
                                                  FormBuilderValidators
                                                      .required(),
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter amount",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[300],
                                                        fontSize: 15)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 190,
                                            padding: EdgeInsets.only(left: 5.0),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, .2),
                                                      blurRadius: 20.0,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, bottom: 1),
                                              child: FormBuilderTextField(
                                                attribute: "mealdescpt",
                                                onSaved: (val) {
                                                  setState(() {
                                                    mealdescpt = val;
                                                  });
                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Add Description if any",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[300],
                                                        fontSize: 15)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      Text(
                                        'Others:',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 120,
                                            padding: EdgeInsets.only(left: 5.0),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, .2),
                                                      blurRadius: 20.0,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, bottom: 1),
                                              child: FormBuilderTextField(
                                                attribute: "other",
//                                                onSaved: (val) {
//                                                  setState(() {
//                                                    other = val;
//                                                  });
//                                                },
                                                validators: [
                                                  FormBuilderValidators
                                                      .numeric(),
                                                  FormBuilderValidators
                                                      .required(),
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Enter amount",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[300],
                                                        fontSize: 15)),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 190,
                                            padding: EdgeInsets.only(left: 5.0),
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, .2),
                                                      blurRadius: 20.0,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.0, bottom: 1),
                                              child: FormBuilderTextField(
//                                                onSaved: (val) {
//                                                  setState(() {
//                                                    otherdescription = val;
//                                                  });
//                                                },
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText:
                                                        "Add Description if any",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey[300],
                                                        fontSize: 15)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                            ]),
                      )),
                ),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      if (_fbKey.currentState.saveAndValidate()) {
                        print(_fbKey.currentState.value);
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
      ),
    );
  }
}
