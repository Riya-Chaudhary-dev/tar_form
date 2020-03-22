import 'package:flutter/material.dart';
import 'HotelInfo.dart';
import 'travelITCard.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TravelItinerary extends StatefulWidget {
  @override
  _TravelItineraryState createState() => _TravelItineraryState();
}

class _TravelItineraryState extends State<TravelItinerary> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  double advAmount;
  String advDescription;
  bool checkboxValue = false;
  bool advVal = false;

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
        child: SafeArea(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _fbKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LinearProgressIndicator(
                    value: 0.7,
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      elevation: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 15,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color.fromRGBO(143, 148, 251, 1)),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Departing Date:',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                                Text(
                                  'Return Date:',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.cached,
                              color: Colors.white,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  '12 Dec 2019',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                                Text(
                                  'Never',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Card(
                      child: CheckboxListTile(
                        value: advVal,
                        onChanged: (val) {
                          if (advVal == false) {
                            setState(() {
                              advVal = true;
                            });
                          } else if (advVal == true) {
                            setState(() {
                              advVal = false;
                            });
                          }
                        },
//                        subtitle: advVal
//                            ?
//                            : null,
                        title: new Text(
                          'Do you require Travel Advance?',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                        controlAffinity: ListTileControlAffinity.platform,
                        activeColor: Colors.deepPurple.shade400,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: advVal,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color.fromRGBO(143, 148, 251, 8),
                              width: 3.0,
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Amount: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 53,
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(143, 148, 251, 8),
                                          width: 3.0,
                                        ),
                                      ),
                                      child: FormBuilderTextField(
                                        attribute: "advAmount",
                                        onSaved: (value) {
                                          value != null
                                              ? advAmount = double.parse(value)
                                              : advAmount = 0.0;
                                          print(advAmount);
                                        },
                                        validators: [
                                          FormBuilderValidators.required(),
                                        ],
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Amount',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 15)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              Row(
                                children: <Widget>[
                                  Text(
                                    '*Description: ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2),
//                                      height: 53,
//                width: 170,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(143, 148, 251, 8),
                                          width: 3.0,
                                        ),
                                      ),
                                      child: FormBuilderTextField(
                                        attribute: "advDescription",
                                        onSaved: (value) {
                                          value != null
                                              ? advDescription = value
                                              : advDescription = '';
                                        },
                                        validators: [
                                          FormBuilderValidators.required(),
                                          FormBuilderValidators.minLength(3),
                                        ],
                                        keyboardType: TextInputType.text,
                                        maxLines: 6,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Description',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 15)),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Divider(),
                              Text(
                                'Advance for business travel will be handed on case-by-case basis. Travel advances will be '
                                'NOT be issued to:\n'
                                'a. Employees with outstanding Expense Reimbursement Statements over 30 days.\n'
                                'b. Employees who have taken advance for previous tour and not returned the unused advance'
                                ' or not submitted the Expense Reimbursement Statement.\n'
                                'c. Employees who have a Company credit card.\n'
                                'd. Employees who choose to use their personal credit card for business travel.\n'
                                'Ref: *HA-Travel Policy *page-2(HA/16-17/001 Date:21/05/2016)',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  TravelCard(
                    ToPlace: 'Pune',
                    FromPlace: 'Kol',
                    ToDate: '21 Dec 2019',
                  ),
                  TravelCard(
                    ToPlace: 'Pune',
                    FromPlace: 'Kol',
                    ToDate: '21 Dec 2019',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:  BorderRadius.circular(18.0),

                        ),
                        splashColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 100),
                        child: Text(
                          'click to add legs',
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                        color: Colors.lightGreen,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  HotelDetails(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Card(
                      child: CheckboxListTile(
                        value: checkboxValue,
                        onChanged: (val) {
                          if (checkboxValue == false) {
                            setState(() {
                              checkboxValue = true;
                            });
                          } else if (checkboxValue == true) {
                            setState(() {
                              checkboxValue = false;
                            });
                          }
                        },
                        subtitle: !checkboxValue
                            ? Text(
                                'Required.',
                                style: TextStyle(color: Colors.red),
                              )
                            : null,
                        title: new Text(
                          'I hereby confirm that the information filled in this TAR are as per Holtec\'s travel policy.',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.deepPurple.shade400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      2,
                      Center(
                        child: RaisedButton(
                          padding:
                              EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                          onPressed: () {},
//    {
//                          if (_fbKey.currentState.saveAndValidate()) {
//                            print(_fbKey.currentState.value);
//                            Scaffold.of(context).showSnackBar(SnackBar(
//                                content: Text('Processing Data')));
//                          }
//                        },
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
        ),
      ),
    );
  }
}
