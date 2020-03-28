import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:tar_form/authorizationform.dart';
import 'package:tar_form/hotelItinerary.dart';

Map dateInfo = {};
Map formDetails = {};

class TravelItinerary extends StatefulWidget {
  static String id = 'travel_itinerary';

  TravelItinerary({this.basicFormInfo});

  final Map basicFormInfo;

  @override
  _TravelItineraryState createState() => _TravelItineraryState();
}

bool allGood = true;
List<Widget> Legs = [];
double advAmount;
String advDescription;
bool checkboxValue = false;
bool advVal = false;
int noOfLegs = 1;

class _TravelItineraryState extends State<TravelItinerary> {
  GlobalKey<FormBuilderState> advance = GlobalKey<FormBuilderState>();

  void addToFormDetails(int legNo) {
    formDetails.clear();
    formDetails.addAll(widget.basicFormInfo);
    if (advVal) {
      formDetails.addAll({
        'travel advance': true,
        'travel advance amount': advance.currentState.value['advAmount'],
        'travel advance description':
            advance.currentState.value['advDescription']
      });
    } else {
      formDetails.addAll({'travel advance': false});
    }
    while (legNo != 0) {
      formDetails.addAll({
        'Leg $legNo': {
          'travel date': dateInfo['leg $legNo travel date'],
          'depart from': advance.currentState.value['Leg $legNo departFrom'],
          'depart to': advance.currentState.value['Leg $legNo departTo'],
        }
      });

      if (advance.currentState.value['Leg $legNo mode'] == 'Flight') {
        formDetails['Leg $legNo'].addAll({
          'mode': 'Flight',
          'flight number': advance.currentState.value['Leg $legNo flightNo'],
        });
        print('$legNo flight');
      } else if (advance.currentState.value['Leg $legNo mode'] ==
          'Rental Car') {
        if (dateInfo['Leg $legNo Rental Car from date'] != null) {
          formDetails['Leg $legNo'].addAll({
            'rental car from date': dateInfo['Leg $legNo Rental Car from date'],
            'rental car to date': dateInfo['Leg $legNo Rental Car to date'],
          });
        }
        formDetails['Leg $legNo'].addAll({
          'mode': 'Rental Car',
          'rental car company':
              advance.currentState.value['Leg $legNo RetalName'],
          'pickup address':
              advance.currentState.value['Leg $legNo carPickupAddress'],
          'dropoff address':
              advance.currentState.value['Leg $legNo carDropOffAddress'],
          'vehicle type': advance.currentState.value['Leg $legNo vehicleType'],
          'service type': advance.currentState.value['Leg $legNo serviceType'],
        });
      } else if (advance.currentState.value['Leg $legNo mode'] == 'Train') {
        formDetails['Leg $legNo'].addAll({
          'travel date': dateInfo['leg $legNo travel date'],
          'depart from': advance.currentState.value['Leg $legNo departFrom'],
          'depart to': advance.currentState.value['Leg $legNo departTo'],
          'mode': 'Train',
          'train details':
              advance.currentState.value['Leg $legNo trainDetails'],
        });
      } else if (advance.currentState.value['Leg $legNo mode'] ==
          'Personal Car') {
        formDetails['Leg $legNo'].addAll({
          'travel date': dateInfo['leg $legNo travel date'],
          'depart from': advance.currentState.value['Leg $legNo departFrom'],
          'depart to': advance.currentState.value['Leg $legNo departTo'],
          'mode': 'Personal Car',
          'distance travelled':
              advance.currentState.value['Leg $legNo personalCarDistance'],
          'rate per km':
              advance.currentState.value['Leg $legNo personalCarRate'],
          'amount': advance.currentState.value['Leg $legNo personalCarRate'] *
              advance.currentState.value['Leg $legNo personalCarDistance'],
        });
      } else if (advance.currentState.value['Leg $legNo mode'] == 'Bus') {
        formDetails['Leg $legNo'].addAll({
          'mode': 'Bus',
          'bus type': advance.currentState.value['Leg $legNo BusType'],
        });
        print('$legNo Bus');
      }
      legNo--;
    }
  }

  @override
  void initState() {
    super.initState();
    if (Legs.length == 0) {
      Legs.add(
        TravelCard(
          initialDate: widget.basicFormInfo['from date'],
          finalDate: widget.basicFormInfo['to date'],
          toPlace: 'Pune',
          fromPlace: 'Kol',
          toDate: '21 Dec 2019',
        ),
      );
    }
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
//    widget.basicFormInfo.clear();
//    Legs.clear();
//    formDetails.clear();
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
              widget.basicFormInfo.clear();
              Legs.clear();
              formDetails.clear();
            },
          ),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text(
            'Travel Itinerary',
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
                key: advance,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LinearProgressIndicator(
                      value: 0.7,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.orangeAccent),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    DateFormat.d()
                                            .format(widget
                                                .basicFormInfo['from date'])
                                            .toString() +
                                        ' ' +
                                        DateFormat.MMM()
                                            .format(widget
                                                .basicFormInfo['from date'])
                                            .toString() +
                                        ' ' +
                                        DateFormat.y()
                                            .format(widget
                                                .basicFormInfo['from date'])
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                  Text(
                                    DateFormat.d()
                                            .format(
                                                widget.basicFormInfo['to date'])
                                            .toString() +
                                        ' ' +
                                        DateFormat.MMM()
                                            .format(
                                                widget.basicFormInfo['to date'])
                                            .toString() +
                                        ' ' +
                                        DateFormat.y()
                                            .format(
                                                widget.basicFormInfo['to date'])
                                            .toString(),
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
                                width: 2.0,
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
                                        height: 65,
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color.fromRGBO(
                                                143, 148, 251, 8),
                                            width: 2.0,
                                          ),
                                        ),
                                        child: FormBuilderTextField(
                                          textAlign: TextAlign.center,

                                          autovalidate: allGood ? false : true,
                                          attribute: "advAmount",
                                          onSaved: (value) {
                                            setState(() {
                                              value != ''
                                                  ? advAmount =
                                                      double.parse(value)
                                                  : advAmount = 0.0;
                                            });
                                          },
                                          validators: [
                                            FormBuilderValidators.required(),
                                            FormBuilderValidators.numeric(),
                                            FormBuilderValidators.minLength(1),
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
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: Color.fromRGBO(
                                                143, 148, 251, 8),
                                            width: 2.0,
                                          ),
                                        ),
                                        child: FormBuilderTextField(
                                          textAlign: TextAlign.center,

                                          autovalidate: allGood ? false : true,
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
                    Column(
                      children: Legs,
                    ),
                    Legs.length > 1
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  splashColor: Colors.redAccent,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                                  child: Text(
                                    'Delete last leg',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  color: Colors.red,
                                  onPressed: () {
                                    setState(() {
                                      formDetails.clear();
                                      Legs.removeLast();
                                    });
                                  }),
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          splashColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 77,vertical: 10),
                          child: Text(
                            'Add Leg',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          color: Colors.lightGreen,
                          onPressed: () {
                            setState(() {
                              noOfLegs++;
                              Legs.add(
                                TravelCard(
                                  initialDate:
                                      widget.basicFormInfo['from date'],
                                  finalDate: widget.basicFormInfo['to date'],
                                  legNo: noOfLegs,
                                  toPlace: 'Pune',
                                  fromPlace: 'Kol',
                                  toDate: '21 Dec 2019',
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: RaisedButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                        onPressed: () {
                          if (advance.currentState.saveAndValidate()) {
                            if (advVal) {
                              print(advance.currentState.value);
                            }
                            addToFormDetails(Legs.length);
//                            print(dateInfo);
                            print(formDetails);
                            if (widget.basicFormInfo['to date']
                                    .difference(
                                        widget.basicFormInfo['from date'])
                                    .inDays ==
                                0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AuthorizationForm(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HotelItinerary(travelFormInfo: formDetails,),
                                ),
                              );
                            }
                            setState(() {
                              allGood = false;
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
          ),
        ),
      ),
    );
  }
}

class TravelCard extends StatefulWidget {
  TravelCard(
      {this.fromPlace,
      this.toDate,
      this.toPlace,
      this.legNo = 1,
      this.finalDate,
      this.initialDate});

  final String toPlace;
  final int legNo;
  final String fromPlace;
  final String toDate;
  final DateTime initialDate;
  final DateTime finalDate;

  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  String mode;
  String departTo;
  String departFrom;
  DateTime selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: widget.initialDate,
        lastDate: widget.finalDate);
    if (picked != null && picked != selectedDate)
      setState(() {
        int legNo = widget.legNo;
        dateInfo.remove('leg $legNo travel date');
        selectedDate = picked;
        dateInfo.addAll({
          'leg $legNo travel date': selectedDate,
        });
        print(dateInfo);
      });
  }

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    int legNo = widget.legNo;
    dateInfo.addAll({
      'leg $legNo travel date': selectedDate,
    });
    List modes = ['Rental Car', 'Train', 'Flight', 'Personal Car', 'Bus'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Color.fromRGBO(143, 148, 251, 1),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Leg ' + widget.legNo.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Travel Date:',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color.fromRGBO(143, 148, 251, 150),
                                width: 2.0,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Text(
                                DateFormat.d().format(selectedDate).toString() +
                                    ' ' +
                                    DateFormat.MMM()
                                        .format(selectedDate)
                                        .toString() +
                                    ', ' +
                                    DateFormat.y()
                                        .format(selectedDate)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Depart From:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Container(
                                    height: allGood ? 53 : 71,
                                    width: 160,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color.fromRGBO(143, 148, 251, 8),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: SizedBox(
                                      child: FormBuilderTextField(
                                        expands: true,
                                        textAlign: TextAlign.center,
                                        autovalidate: allGood ? false : true,
                                        attribute: "Leg $legNo departFrom",
                                        onSaved: (value) {
                                          value != null
                                              ? departFrom = value
                                              : departFrom = '';
                                        },
                                        validators: [
                                          FormBuilderValidators.required(),
                                        ],
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Place',
                                            hintStyle: TextStyle(
                                                color: Colors.grey[300],
                                                fontSize: 15)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Depart To:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  Container(
                                    height: allGood ? 53 : 71,
                                    width: 160,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Color.fromRGBO(143, 148, 251, 8),
                                        width: 2.0,
                                      ),
                                    ),
                                    child: FormBuilderTextField(
                                      textAlign: TextAlign.center,
                                      autovalidate: allGood ? false : true,
                                      attribute: "Leg $legNo departTo",
                                      onSaved: (value) {
                                        value != null
                                            ? departTo = value
                                            : departTo = '';
                                      },
                                      validators: [
                                        FormBuilderValidators.required(),
                                      ],
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Place',
                                          hintStyle: TextStyle(
                                              color: Colors.grey[300],
                                              fontSize: 15)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '*Mode of Transportation:',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 12,
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color.fromRGBO(143, 148, 251, 8),
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: FormBuilderDropdown(
                                attribute: "Leg $legNo mode",
                                onChanged: (val) {
                                  setState(() {
                                    mode = val;
                                  });
                                },
                                onSaved: (val) {
                                  setState(() {
                                    mode = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                hint: Row(
                                  children: <Widget>[
                                    Text('Select mode of transportation'),
                                  ],
                                ),
                                validators: [FormBuilderValidators.required()],
                                items: modes
                                    .map((mode) => DropdownMenuItem(
                                        value: mode, child: Text("$mode")))
                                    .toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          DescrBox(
                            mode: mode,
                            legNo: widget.legNo,
                            initialDate: widget.initialDate,
                            finalDate: widget.finalDate,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
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

class DescrBox extends StatefulWidget {
  DescrBox({this.mode, this.legNo, this.finalDate, this.initialDate});

  final String mode;
  final int legNo;
  final DateTime initialDate;
  final DateTime finalDate;

  @override
  _DescrBoxState createState() => _DescrBoxState();
}

class _DescrBoxState extends State<DescrBox> {
  List service = [
    'Return',
    'Drop only',
    'Pickup only',
    'Local',
    'Outstation',
    'Multistation'
  ];
  List vehicle = ['Sedan', 'Hatchback', 'SUV', 'Premium'];
  String vehicleType;
  String serviceType;
  DateTime fromDate;
  DateTime toDate;

  String busType;
  String rentalName;
  String pickUpAdd;
  String DropAdd;
  String traindeets;
  String flightdeets;
  double personalCaramt;
  double personalCardist;
  double personalCarrate;

  bool singleDayTrip() {
    int legNo = widget.legNo;
    if (widget.finalDate.difference(widget.initialDate).inDays == 0) {
      return true;
    } else {
      dateInfo.addAll({
        'Leg $legNo Rental Car from date': fromDate,
        'Leg $legNo Rental Car to date': toDate,
      });
      return false;
    }
  }

  selectDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDate,
        initialLastDate: toDate,
        firstDate: widget.initialDate,
        lastDate: DateTime(2020, 4));
    if (picked != null && picked.length == 2) {
      setState(() {
        fromDate = picked[0];
        toDate = picked[1];
      });
    }
    if (picked != null && picked.length == 1) {
      setState(() {
        fromDate = picked[0];
        toDate = picked[0];
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
    fromDate = widget.initialDate;
    toDate = widget.finalDate;
    int legNo = widget.legNo;
    if (widget.mode == 'Rental Car') {
      return Column(
        children: <Widget>[
          Divider(),
          Text(
            'Car Rental Details',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: <Widget>[
              Text(
                'Rental Company Name: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  height: allGood ? 53 : 71,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(143, 148, 251, 8),
                      width: 2.0,
                    ),
                  ),
                  child: FormBuilderTextField(

                    autovalidate: allGood ? false : true,
                    attribute: "Leg $legNo RetalName",
                    textAlign: TextAlign.center,
                    onSaved: (val) {
                      setState(() {
                        rentalName = val;
                      });
                    },
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Rental Company Name',
                        hintStyle:
                            TextStyle(color: Colors.grey[300], fontSize: 15)),
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                'Pickup Address: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Container(
                  height: allGood ? 53 : 71,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(143, 148, 251, 8),
                      width: 2.0,
                    ),
                  ),
                  child: FormBuilderTextField(
                    autovalidate: allGood ? false : true,
                    attribute: "Leg $legNo carPickupAddress",
                    textAlign: TextAlign.center,

                    onSaved: (val) {
                      setState(() {
                        pickUpAdd = val;
                      });
                    },
                    validators: [FormBuilderValidators.required()],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'PickUp address',
                        hintStyle:
                            TextStyle(color: Colors.grey[300], fontSize: 15)),
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                'Dropoff Address: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Container(
                  height: allGood ? 53 : 71,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(143, 148, 251, 8),
                      width: 2.0,
                    ),
                  ),
                  child: FormBuilderTextField(
                    autovalidate: allGood ? false : true,
                    attribute: "Leg $legNo carDropOffAddress",
                    textAlign: TextAlign.center,

                    onSaved: (val) {
                      setState(() {
                        DropAdd = val;
                      });
                    },
                    validators: [FormBuilderValidators.required()],
                    maxLines: 4,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Dropoff address',
                        hintStyle:
                            TextStyle(color: Colors.grey[300], fontSize: 15)),
                  ),
                ),
              )
            ],
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Vehicle Type: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 2.0,
                      ),
                    ),
                    child: FormBuilderDropdown(
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                      attribute: "Leg $legNo vehicleType",
                      onSaved: (val) {
                        vehicleType = val;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      hint: Text('Select vehicle type'),
                      items: vehicle
                          .map((vehicle) => DropdownMenuItem(
                              value: vehicle, child: Text("$vehicle")))
                          .toList(),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Service Type: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        //                   <--- border color
                        width: 2.0,
                      ),
                    ),
                    child: FormBuilderDropdown(
                      attribute: "Leg $legNo serviceType",
                      onSaved: (val) {
                        setState(() {
                          serviceType = val;
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      // initialValue: 'Male',
                      hint: Text('Select service type'),
                      validators: [FormBuilderValidators.required()],
                      items: service
                          .map((service) => DropdownMenuItem(
                              value: service, child: Text("$service")))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            height: 30,
          ),
          singleDayTrip()
              ? SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Pickup Date ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          DateFormat.d().format(fromDate).toString() +
                              ' ' +
                              DateFormat.MMM().format(fromDate).toString() +
                              ', ' +
                              DateFormat.y().format(fromDate).toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: selectDate,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color.fromRGBO(143, 148, 251, 8)),
                        child: Center(
                          child: Text(
                            'Select Dates',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Dropoff Date: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          DateFormat.d().format(toDate).toString() +
                              ' ' +
                              DateFormat.MMM().format(toDate).toString() +
                              ', ' +
                              DateFormat.y().format(toDate).toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      );
    } else if (widget.mode == 'Flight') {
      return Row(
        children: <Widget>[
          Text(
            'Flight No.: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Container(
              height: allGood ? 53 : 71,
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 2.0,
                ),
              ),
              child: FormBuilderTextField(
                attribute: "Leg $legNo flightNo",
                textAlign: TextAlign.center,

                onSaved: (val) {
                  setState(() {
                    flightdeets = val;
                  });
                },
                validators: [
                  FormBuilderValidators.required(),
                ],
                autovalidate: allGood ? false : true,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Flight No.',
                    hintStyle:
                        TextStyle(color: Colors.grey[300], fontSize: 15)),
              ),
            ),
          )
        ],
      );
    } else if (widget.mode == 'Train') {
      return Row(
        children: <Widget>[
          Text(
            'Train No. & Class: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Container(
              height: allGood ? 53 : 71,
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 2.0,
                ),
              ),
              child: FormBuilderTextField(
                autovalidate: allGood ? false : true,
                textAlign: TextAlign.center,

                validators: [
                  FormBuilderValidators.required(),
                ],
                attribute: "Leg $legNo trainDetails",
                onSaved: (val) {
                  setState(() {
                    traindeets = val;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Train no. & Class',
                    hintStyle:
                        TextStyle(color: Colors.grey[300], fontSize: 15)),
              ),
            ),
          )
        ],
      );
    } else if (widget.mode == 'Bus') {
      return Row(
        children: <Widget>[
          Text(
            'Bus Type: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Container(
              height: allGood ? 53 : 71,
              padding: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 2.0,
                ),
              ),
              child: FormBuilderTextField(
                textAlign: TextAlign.center,

                validators: [
                  FormBuilderValidators.required(),
                ],
                autovalidate: allGood ? false : true,
                attribute: "Leg $legNo BusType",
                onSaved: (val) {
                  setState(() {
                    busType = val;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Luxury/Sleeper',
                    hintStyle:
                        TextStyle(color: Colors.grey[300], fontSize: 15)),
              ),
            ),
          )
        ],
      );
    } else if (widget.mode == 'Personal Car') {
      return Column(
        children: <Widget>[
          Text(
            'In case you are using your personal car for official purpose, please fill in the details below',
            style: TextStyle(color: Colors.redAccent, fontSize: 13),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Distance Traveled(km): ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: allGood ? 53 : 71,
                    width: 90,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 2.0,
                      ),
                    ),
                    child: FormBuilderTextField(
                      textAlign: TextAlign.center,

                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ],
                      autovalidate: allGood ? false : true,
                      attribute: "Leg $legNo personalCarDistance",
                      onSaved: (val) {
                        setState(() {
                          val != ''
                              ? personalCardist = double.parse(val)
                              : personalCardist = 0.0;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Distance',
                          hintStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 15)),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Rate per km: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: allGood ? 53 : 71,
                    width: 90,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 2.0,
                      ),
                    ),
                    child: FormBuilderTextField(
                      textAlign: TextAlign.center,

                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                      ],
                      autovalidate: allGood ? false : true,
                      attribute: "Leg $legNo personalCarRate",
                      onSaved: (val) {
                        setState(() {
                          val != ''
                              ? personalCarrate = double.parse(val)
                              : personalCarrate = 0.0;
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Rate',
                          hintStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Text(
                'Amount: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Container(
                  height: allGood ? 53 : 71,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(143, 148, 251, 8),
                      width: 2.0,
                    ),
                  ),
                  child: FormBuilderTextField(
                    textAlign: TextAlign.center,

                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                    autovalidate: allGood ? false : true,
                    attribute: "Leg $legNo personalCaramt",
                    onSaved: (val) {
                      setState(() {
                        val != ''
                            ? personalCaramt = double.parse(val)
                            : personalCaramt = 0.0;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Rate times cost per km',
                        hintStyle:
                            TextStyle(color: Colors.grey[300], fontSize: 15)),
                  ),
                ),
              )
            ],
          )
        ],
      );
    } else
      return Divider();
  }
}
