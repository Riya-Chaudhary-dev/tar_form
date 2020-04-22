import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SummaryPage extends StatefulWidget {
  static String id = 'summary';

  SummaryPage({this.formInfo, this.fromFirebase, this.isSupervisor, this.isSummary, this.status, this.taNo, this.documentId});

  Map formInfo;
  final bool fromFirebase;
  bool isSupervisor;
  bool isSummary;
  String status;
  int taNo;
  String documentId;

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  bool showSpinner = false;

  Future cal() async {
    List<int> used = [];
    int random = Random().nextInt(99999);
    random = random < 10000 ? random + 10000 : random;
    var data = await Firestore.instance.collection('tar submissions').getDocuments();
    for (var q in data.documents) {
      used.add(q.data['TA no']);
    }
    while (used.contains(random)) {
      random = Random().nextInt(99999);
      random = random < 10000 ? random + 10000 : random;
    }
    return random;
  }

  void _showDialog({String title, String message}) async{
   var  n= await showDialog(
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
                Navigator.pop(context,true);
              },
            ),
          ],
        );
      },
    );
if(n==true){
  Navigator.pop(context);
}
  }

  Widget accomodation({Map hotelInfo}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SummaryTiles(
                title: 'Hotel Name: ',
                input: hotelInfo['hotel name'],
              ),
              SummaryTiles(
                title: 'Hotel Address: ',
                input: hotelInfo['hotel address'],
              ),
              SummaryTiles(
                title: 'Checkin Date: ',
                input: showDate(givenDate: hotelInfo['check in date']),
              ),
              SummaryTiles(
                title: 'Checkout Date: ',
                input: showDate(givenDate: hotelInfo['check out date']),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget expenseCard({Map formInfo}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              formInfo['international trip'] == true
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'International Trip  (' + widget.formInfo['currency'] + ')',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 120, vertical: 5),
                        child: Text(
                          'Domestic Trip',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ),
              SizedBox(
                height: 5,
              ),
              SummaryTiles(
                title: 'Destination: ',
                input: formInfo['destination'],
              ),
              SummaryTiles(
                title: 'Purpose of travel: ',
                input: formInfo['purpose of travel'],
              ),
              SummaryTiles(
                title: 'Travel (to & fro destination) :',
                input: formInfo['details of estimated expenses']['travel amount'],
              ),
              formInfo['details of estimated expenses']['lodging amount'] != null
                  ? SummaryTiles(
                      title: 'Lodging: ',
                      input: formInfo['details of estimated expenses']['lodging amount'],
                    )
                  : SizedBox(),
              formInfo['details of estimated expenses']['local travel amount'] != null
                  ? SummaryTiles(
                      title: 'Local Travel: ',
                      input: formInfo['details of estimated expenses']['local travel amount'],
                    )
                  : SizedBox(),
              SummaryTiles(
                title: 'Meals: ',
                input: formInfo['details of estimated expenses']['meals'],
              ),
              formInfo['details of estimated expenses']['business meals'] != null
                  ? SummaryTiles(
                      title: 'Business Meals: ',
                      input: formInfo['details of estimated expenses']['business meals'],
                    )
                  : SizedBox(),
              formInfo['details of estimated expenses']['business meal description'] != null
                  ? SummaryTiles(
                      title: 'Meal description:',
                      input: formInfo['details of estimated expenses']['business meal description'],
                    )
                  : SizedBox(),
              formInfo['details of estimated expenses']['other expenses'] != null
                  ? SummaryTiles(
                      title: 'Others: ',
                      input: formInfo['details of estimated expenses']['other expenses'],
                    )
                  : SizedBox(),
              formInfo['details of estimated expenses']['other expenses description'] != null
                  ? SummaryTiles(
                      title: 'Others descriptions: ',
                      input: formInfo['details of estimated expenses']['other expenses description'],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget travelCard({Map legInfo}) {
    if (legInfo['mode'] == 'Rental Car') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  headerTile(
                    title: 'Rental Car',
                    color: Colors.black,
                  ),
                  SummaryTiles(
                    title: 'Pickup Date: ',
                    input: showDate(givenDate: legInfo['rental car from date']),
                  ),
                  SummaryTiles(
                    title: 'Drop Date: ',
                    input: showDate(givenDate: legInfo['rental car to date']),
                  ),
                  SummaryTiles(
                    title: 'Rental Company Name: ',
                    input: legInfo['rental car company'],
                  ),
                  SummaryTiles(
                    title: 'Pickup Address: ',
                    input: legInfo['pickup address'],
                  ),
                  SummaryTiles(
                    title: 'Drop Address: ',
                    input: legInfo['dropoff address'],
                  ),
                  SummaryTiles(
                    title: 'Vehicle Type: ',
                    input: legInfo['vehicle type'],
                  ),
                  SummaryTiles(
                    title: 'Service Type: ',
                    input: legInfo['service type'],
                  ),
                ],
              )),
        ),
      );
    } else if (legInfo['mode'] == 'Flight') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                headerTile(
                  title: 'Flight',
                  color: Colors.black,
                ),
                SummaryTiles(
                  title: 'Flight No.:',
                  input: legInfo['flight number'],
                ),
              ],
            ),
          ),
        ),
      );
    } else if (legInfo['mode'] == 'Bus') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                headerTile(
                  title: 'Bus',
                  color: Colors.black,
                ),
                SummaryTiles(
                  title: 'Bus Type:',
                  input: legInfo['bus type'],
                )
              ],
            ),
          ),
        ),
      );
    } else if (legInfo['mode'] == 'Personal Car') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                headerTile(
                  title: 'Personal Car',
                  color: Colors.black,
                ),
                SummaryTiles(
                  title: 'Distance (km): ',
                  input: legInfo['distance travelled'],
                ),
                SummaryTiles(
                  title: 'Rate per km:',
                  input: legInfo['rate per km'],
                ),
                SummaryTiles(
                  title: 'Amount: ',
                  input: legInfo['amount'].toString(),
                )
              ],
            ),
          ),
        ),
      );
    } else if (legInfo['mode'] == 'Train') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                headerTile(
                  title: 'Train',
                  color: Colors.black,
                ),
                SummaryTiles(
                  title: 'Train No. & Class',
                  input: legInfo['train details'],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  List<Widget> legs() {
    List<Widget> legs = [];
    int nooflegs = widget.fromFirebase ? 1 : widget.formInfo['legs count'];
    widget.formInfo.forEach((key, value) {
      if (key == 'Leg $nooflegs') {
        legs.add(Card(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Leg $nooflegs :',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            showDate(givenDate: value['travel date']),
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            value['depart from'],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            value['depart to'],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                travelCard(legInfo: value),
              ],
            )));
        widget.fromFirebase ? nooflegs++ : nooflegs--;
      }
    });
    return widget.fromFirebase ? legs : legs.reversed.toList();
  }

  List<Widget> hotels() {
    List<Widget> hotels = [];
    int noOfHotels = widget.fromFirebase ? 1 : widget.formInfo['hotels count'];
    widget.formInfo.forEach((key, value) {
      if (key == 'accomodation $noOfHotels') {
        hotels.add(Card(
            color: Colors.redAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                  child: Text(
                    'Accomodation $noOfHotels :',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                accomodation(hotelInfo: value),
              ],
            )));
        widget.fromFirebase ? noOfHotels++ : noOfHotels--;
      }
    });
    return widget.fromFirebase ? hotels : hotels.reversed.toList();
  }

  String showDate({var givenDate}) {
    if (widget.fromFirebase) {
      givenDate = givenDate.toDate();
    }
    return DateFormat.d().format(givenDate).toString() +
        ' ' +
        DateFormat.MMM().format(givenDate).toString() +
        ' ' +
        DateFormat.y().format(givenDate).toString();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.status);
    if (widget.isSupervisor == true) {
      widget.isSummary = false;
    } else if (widget.isSummary == true) {
      widget.isSupervisor = false;
    } else {
      widget.isSupervisor = false;
      widget.isSummary = false;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          'Bill Summary',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  LinearProgressIndicator(
                    value: 0.99,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.fromFirebase
                      ? TravelLogCards(
                          formDetails: widget.formInfo,
                          status: widget.status,
                          taNo: widget.taNo,
                        )
                      : SizedBox(),
                  Card(
                    color: Colors.green,
                    child: Column(
                      children: <Widget>[
                        headerTile(
                          title: 'Traveler\'s Details',
                          color: Colors.green,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
//                child: basicInfo(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                SummaryTiles(
                                  title: 'Name ',
                                  input: widget.formInfo['name'],
                                ),
                                SummaryTiles(
                                  title: 'Email ',
                                  input: widget.formInfo['email'],
                                ),
                                SummaryTiles(
                                  title: 'Department ',
                                  input: widget.formInfo['department'],
                                ),
                                SummaryTiles(
                                  title: 'Division ',
                                  input: widget.formInfo['division'],
                                ),
                                SummaryTiles(
                                  title: 'Supervisor email',
                                  input: widget.formInfo['supervisor email'],
                                ),
                                SummaryTiles(
                                  title: 'Project',
                                  input: widget.formInfo['project'],
                                ),
                                SummaryTiles(
                                  title: 'Supervisor email',
                                  input: widget.formInfo['supervisor email'],
                                ),
                                SummaryTiles(
                                  title: 'To Date',
                                  input: showDate(givenDate: widget.formInfo['to date']),
                                ),
                                SummaryTiles(title: 'From Date', input: showDate(givenDate: widget.formInfo['from date'])),
                              ],
                            ),
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.blue,
                    child: Column(
                      children: <Widget>[
                        headerTile(
                          title: 'Expense Details',
                          color: Colors.blue,
                        ),
                        expenseCard(formInfo: widget.formInfo),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        headerTile(
                          title: 'Travel Itinerary',
                          color: Colors.black,
                        ),
                        widget.formInfo['travel advance amount'] != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SummaryTiles(
                                    title: 'Advance',
                                    input: widget.formInfo['travel advance amount'],
                                    outer: true,
                                  ),
                                  SummaryTiles(
                                    title: 'Advance Description',
                                    input: widget.formInfo['travel advance description'],
                                    outer: true,
                                  ),
                                ],
                              )
                            : SizedBox(),
                        Column(
                          children: legs(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.formInfo['hotels count'] != null
                      ? Card(
                          color: Colors.redAccent,
                          child: Column(
                            children: <Widget>[
                              headerTile(
                                title: 'Accomodation Details',
                                color: Colors.redAccent,
                              ),
                              Column(
                                children: hotels(),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                  widget.isSupervisor
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Center(
                                child: RaisedButton(
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  onPressed: () async {
                                    setState(() {
                                      showSpinner = true;
                                      widget.status = 'APPROVED';
                                    });
                                    try {
                                      await Firestore.instance
                                          .collection('tar submissions')
                                          .document(widget.documentId)
                                          .updateData({'status': 'approved'});
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      _showDialog(
                                          title: 'Form Submitted', message: 'your form has been submitted and will be checked by your supervisor');
                                    } catch (e) {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      print(e);
                                    }
                                  },
                                  color: Colors.green,
                                  shape: StadiumBorder(),
                                  child: Text(
                                    "Approve",
                                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Center(
                                child: RaisedButton(
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                  onPressed: () async {
                                    setState(() {
                                      showSpinner = true;
                                      widget.status = 'REJECTED';
                                    });
                                    try {
                                      await Firestore.instance
                                          .collection('tar submissions')
                                          .document(widget.documentId)
                                          .updateData({'status': 'rejected'});
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      _showDialog(
                                          title: 'Form Submitted', message: 'your form has been submitted and will be checked by your supervisor');
                                    } catch (e) {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      print(e);
                                    }
                                  },
                                  color: Colors.red,
                                  shape: StadiumBorder(),
                                  child: Text(
                                    "Reject",
                                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : widget.isSummary
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: RaisedButton(
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  onPressed: () async {
                                    setState(() {
                                      showSpinner = true;
                                    });
                                    try {
                                      var tarNo = await cal();
                                      print(tarNo);
                                      await Firestore.instance
                                          .collection('tar submissions')
                                          .add({'TA no': tarNo, 'form details': widget.formInfo, 'status': 'pending'});
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      _showDialog(
                                          title: 'Form Submitted', message: 'your form has been submitted and will be checked by your supervisor');
                                    } catch (e) {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      print(e);
                                    }
                                  },
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  shape: StadiumBorder(),
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          : SizedBox()
                ],
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
    );
  }
}

class headerTile extends StatelessWidget {
  headerTile({this.title, this.color});

  String title;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 15,
      padding: EdgeInsets.all(10),
      color: color,
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

class SummaryTiles extends StatelessWidget {
  SummaryTiles({this.title, this.input, this.outer = false});

  String title;
  String input;
  bool outer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: outer ? Colors.white : Colors.black),
          ),
          SizedBox(
            width: 4,
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, .3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 5.0,
                    )
                  ]),
              child: Center(
                  child: Text(
                input != null ? input : 'LL',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class TravelLogCards extends StatelessWidget {
  TravelLogCards({this.formDetails, this.status, this.taNo});

  Map formDetails;
  String status;
  Color color;
  int taNo;

  @override
  Widget build(BuildContext context) {
    if (status == 'APPROVED') {
      color = Colors.green;
    } else if (status == 'REJECTED') {
      color = Colors.red;
    } else {
      color = Colors.yellow;
      status = 'PENDING';
    }
    return Hero(
      tag: taNo.toString(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'TA No.:',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Container(
//                                padding: EdgeInsets.only(left:5.0),
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.deepPurple,
                                    //                   <--- border color
                                    width: 2.0,
                                  ),
                                ),
                                child: Text(
                                  'HA-' + taNo.toString(),
                                  style: TextStyle(letterSpacing: 2, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                'Requested on:',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Container(
//                                padding: EdgeInsets.only(left:5.0),
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Colors.deepPurple,
                                    //                   <--- border color
                                    width: 2.0,
                                  ),
                                ),
                                child: Text(
                                  '12 Dec 2017',
                                  style: TextStyle(fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Pune',
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                DateFormat.d().format(formDetails['from date'].toDate()).toString() +
                                    ' ' +
                                    DateFormat.MMM().format(formDetails['from date'].toDate()).toString() +
                                    ' ' +
                                    DateFormat.y().format(formDetails['from date'].toDate()).toString(),
                                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.compare_arrows,
                                color: Colors.red,
                                size: 30,
                              ),
                              Text(formDetails['to date'].toDate().difference(formDetails['from date'].toDate()).inDays.toString() + ' Days',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                formDetails['destination'],
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                DateFormat.d().format(formDetails['to date'].toDate()).toString() +
                                    ' ' +
                                    DateFormat.MMM().format(formDetails['to date'].toDate()).toString() +
                                    ' ' +
                                    DateFormat.y().format(formDetails['to date'].toDate()).toString(),
                                style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
                          child: Text(
                            status.toUpperCase(),
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                          ))
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
