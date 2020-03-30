import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';

Map dateInfo = {};
Map formDetails = {};

class HotelItinerary extends StatefulWidget {
  static String id = 'hotel_itinerary';

  HotelItinerary({this.travelFormInfo});

  final Map travelFormInfo;

  @override
  _HotelItineraryState createState() => _HotelItineraryState();
}

bool allGood = true;
List<Widget> hotels = [];
double advAmount;
String advDescription;
bool checkboxValue = false;
bool advVal = false;
int noOfHotels = 1;

class _HotelItineraryState extends State<HotelItinerary> {
  GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    if (hotels.length == 0) {
      hotels.add(HotelDetails(
        initialDate: widget.travelFormInfo['from date'],
        finalDate: widget.travelFormInfo['to date'],
      ));
    }
  }

  void addToForm(int legNo) {
    formDetails.clear();
    formDetails.addAll(widget.travelFormInfo);
    while (legNo != 0) {
      formDetails.addAll({
        'accomodation $legNo': {
          'hotel name':
              _fbKey.currentState.value['accomodation $legNo hotelName'],
          'hotel address':
              _fbKey.currentState.value['accomodation $legNo hotelAddress'],
          'check in date': dateInfo['accomodation $legNo from date'],
          'check out date': dateInfo['accomodation $legNo to date'],
        }
      });
      legNo--;
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

// user defined function
  void _showDialog({String title, String message}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
//              widget.basicFormInfo.clear();
              hotels.clear();
//              formDetails.clear();
            },
          ),
          backgroundColor: Color.fromRGBO(143, 148, 251, 1),
          title: Text(
            'Hotel Itenery',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: <Widget>[
            GestureDetector(
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
                                                .format(widget.travelFormInfo[
                                                    'from date'])
                                                .toString() +
                                            ' ' +
                                            DateFormat.MMM()
                                                .format(widget.travelFormInfo[
                                                    'from date'])
                                                .toString() +
                                            ' ' +
                                            DateFormat.y()
                                                .format(widget.travelFormInfo[
                                                    'from date'])
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 17),
                                      ),
                                      Text(
                                        DateFormat.d()
                                                .format(widget
                                                    .travelFormInfo['to date'])
                                                .toString() +
                                            ' ' +
                                            DateFormat.MMM()
                                                .format(widget
                                                    .travelFormInfo['to date'])
                                                .toString() +
                                            ' ' +
                                            DateFormat.y()
                                                .format(widget
                                                    .travelFormInfo['to date'])
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
                        Column(
                          children: hotels,
                        ),
                        hotels.length > 1
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: Center(
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                      splashColor: Colors.redAccent,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Delete Accomodation',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      color: Colors.red,
                                      onPressed: () {
                                        setState(() {
                                          noOfHotels--;
                                          formDetails.clear();
                                          hotels.removeLast();
                                        });
                                      }),
                                ),
                              )
                            : SizedBox(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Center(
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              splashColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Add Accomodation',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              ),
                              color: Colors.lightGreen,
                              onPressed: () {
                                setState(() {
                                  noOfHotels++;
                                  hotels.add(HotelDetails(
                                    legNo: noOfHotels,
                                    initialDate:
                                        widget.travelFormInfo['from date'],
                                    finalDate: widget.travelFormInfo['to date'],
                                  ));
                                });
                              },
                            ),
                          ),
                        ),
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
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Colors.deepPurple.shade400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 8),
                            onPressed: () async {
                              if (_fbKey.currentState.saveAndValidate()) {
                                if (checkboxValue == true) {
                                  addToForm(hotels.length);
                                  print(formDetails);
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try{
                                    FirebaseUser user = await FirebaseAuth
                                        .instance
                                        .currentUser();
                                    print(user.email);
                                  }catch(e){
                                    print(e);
                                  }
                                } else {
                                  _showDialog(
                                      title: 'Agree to Terms and Conditions',
                                      message:
                                          'Please agree to the terms and conditions to submit the form');
                                }
                              } else {
                                _showDialog(
                                    title: 'Incorrect Details',
                                    message:
                                        'Please check the form for incorrect or incomplete details');
                                setState(() {
                                  allGood = false;
                                });
                              }
                            },
                            color: Color.fromRGBO(143, 148, 251, 1),
                            shape: StadiumBorder(),
                            child: Text(
                              "Submit",
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
            showSpinner
                ? Container(
                    color: Colors.black54,
                    child: Center(
                      child: SpinKitWave(
                        color: Colors.white,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class HotelDetails extends StatefulWidget {
  HotelDetails({this.finalDate, this.initialDate, this.legNo = 1});

  final initialDate;

  final finalDate;
  final int legNo;

  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  DateTime fromDate;

  DateTime toDate;
  String hotelName;
  String hotelAddress;

  selectDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDate,
        initialLastDate: toDate,
        firstDate: widget.initialDate,
        lastDate: widget.finalDate);
    if (picked != null && picked.length == 2) {
      setState(() {
        int legNo = widget.legNo;
        dateInfo.remove('accomodation $legNo from date');
        dateInfo.remove('accomodation $legNo to date');
        fromDate = picked[0];
        toDate = picked[1];
        dateInfo.addAll({
          'accomodation $legNo from date': fromDate,
          'accomodation $legNo to date': toDate,
        });
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
  void initState() {
    // TODO: implement initState
    super.initState();
    fromDate = widget.initialDate;
    toDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    int legNo = widget.legNo;
    dateInfo.addAll({
      'accomodation $legNo from date': fromDate,
      'accomodation $legNo to date': toDate,
    });
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.redAccent,
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width - 15,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.redAccent,
                ),
                child: Text(
                  'Accomodation Details ($legNo)',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 4,
                      ),
                      InfoRows(
                        title: 'Hotel Name:',
                        attribute: "accomodation $legNo hotelName",
                        onSaved: (val) {
                          setState(() {
                            hotelName = val;
                          });
                        },
                        validtors: [FormBuilderValidators.required()],
                      ),
                      Divider(),
                      InfoRows(
                        title: 'Hotel Address:',
                        attribute: "accomodation $legNo hotelAddress",
                        onSaved: (val) {
                          setState(() {
                            hotelAddress = val;
                          });
                        },
                        validtors: [FormBuilderValidators.required()],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'CheckIn Date ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                DateFormat.d().format(fromDate).toString() +
                                    ' ' +
                                    DateFormat.MMM()
                                        .format(fromDate)
                                        .toString() +
                                    ', ' +
                                    DateFormat.y().format(fromDate).toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: selectDate,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
//
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.redAccent),
                              child: Center(
                                child: Text(
                                  'Select Dates',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'CheckOut Date: ',
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
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfoRows extends StatefulWidget {
  InfoRows(
      {this.title, this.attribute, this.onSaved, this.validtors, this.legNo});

  String title;
  String attribute;
  Function onSaved;
  List validtors;
  int legNo;

  @override
  _InfoRowsState createState() => _InfoRowsState();
}

class _InfoRowsState extends State<InfoRows> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Container(
              height: allGood ? 53 : 71,
              padding: EdgeInsets.only(left: 5.0),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.redAccent,
                  width: 3.0,
                ),
              ),
              child: FormBuilderTextField(
                textAlign: TextAlign.center,
                autovalidate: allGood ? false : true,
                validators: [FormBuilderValidators.required()],
                attribute: widget.attribute,
                onSaved: widget.onSaved,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.title,
                    hintStyle:
                        TextStyle(color: Colors.grey[400], fontSize: 15)),
              )),
        ),
      ],
    );
  }
}
