import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SummaryPage extends StatelessWidget {
  static String id = 'summary';

  SummaryPage({this.formInfo});

  Map formInfo;
  bool isSupervisor;
  bool isSummary;

  List<Widget> legs() {
    List<Widget> legs = [];
    int nooflegs = formInfo['legs count'];
    formInfo.forEach((key, value) {
      if (key == 'Leg $nooflegs') {
        legs.add(Card(
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Leg $nooflegs :',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      Text(
                        DateFormat.d().format(value['travel date']).toString() +
                            ' ' +
                            DateFormat.MMM().format(value['travel date']).toString() +
                            ' ' +
                            DateFormat.y().format(value['travel date']).toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                travelCard(legInfo: value),
              ],
            )));
        nooflegs--;
      }
    });
    return legs.reversed.toList();
  }

  List<Widget> hotels() {
    List<Widget> hotels = [];
    int noOfHotels = formInfo['hotels count'];
    formInfo.forEach((key, value) {
      if (key == 'accomodation $noOfHotels') {
        hotels.add(Card(
            color: Colors.blue,
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
        noOfHotels--;
      }
    });
    return hotels.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    if (isSupervisor == true) {
      isSummary = false;
    } else if (isSummary == true) {
      isSupervisor = false;
    } else {
      isSupervisor = false;
      isSummary = false;
    }
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          'Bill Summary',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
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
              Card(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    headerTile(
                      title: 'Traveler\'s Details',
                      color: Colors.black,
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
                              input: formInfo['name'],
                            ),
                            SummaryTiles(
                              title: 'Email ',
                              input: formInfo['email'],
                            ),
                            SummaryTiles(
                              title: 'Department ',
                              input: formInfo['department'],
                            ),
                            SummaryTiles(
                              title: 'Division ',
                              input: formInfo['division'],
                            ),
                            SummaryTiles(
                              title: 'Supervisor email',
                              input: formInfo['supervisor email'],
                            ),
                            SummaryTiles(
                              title: 'Project',
                              input: formInfo['project'],
                            ),
                            SummaryTiles(
                              title: 'Supervisor email',
                              input: formInfo['supervisor email'],
                            ),
                            SummaryTiles(
                              title: 'To Date',
                              input: DateFormat.d().format(formInfo['to date']).toString() +
                                  ' ' +
                                  DateFormat.MMM().format(formInfo['to date']).toString() +
                                  ' ' +
                                  DateFormat.y().format(formInfo['to date']).toString(),
                            ),
                            SummaryTiles(
                              title: 'From Date',
                              input: DateFormat.d().format(formInfo['from date']).toString() +
                                  ' ' +
                                  DateFormat.MMM().format(formInfo['from date']).toString() +
                                  ' ' +
                                  DateFormat.y().format(formInfo['from date']).toString(),
                            ),
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
                    expenseCard(formInfo: formInfo),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    headerTile(
                      title: 'Travel Itinerary',
                      color: Colors.black,
                    ),
                    Column(
                      children: legs(),
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
                      title: 'Accomodation Details',
                      color: Colors.blue,
                    ),
                    Column(
                      children: hotels(),
                    ),
                  ],
                ),
              ),
              isSupervisor
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Center(
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              onPressed: () {
//                      if (_fbKey.currentState.saveAndValidate()) {
//                        print(_fbKey.currentState.value);
//                        Scaffold.of(context).showSnackBar(
//                            SnackBar(content: Text('Processing Data')));
//                      }
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
                              onPressed: () {},
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
                  : isSummary
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: RaisedButton(
                              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              onPressed: () {
//                      if (_fbKey.currentState.saveAndValidate()) {
//                        print(_fbKey.currentState.value);
//                        Scaffold.of(context).showSnackBar(
//                            SnackBar(content: Text('Processing Data')));
//                      }
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
    );
  }
}

Widget basicInfo(String name, String email, String supEmail, DateTime RequestedOn, String From, String To, int noofdays, DateTime fromDate,
    DateTime toDate, String Division, String TANo, String Project, String Department) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
                        'TANo',
                        style: TextStyle(letterSpacing: 2, fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Requested on:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
                        child: Text('fff')
//                      Text(DateFormat.d().format(RequestedOn).toString() +
//                          ' ' +
//                          DateFormat.MMM()
//                              .format(RequestedOn)
//                              .toString() +
//                          ' ' +
//                          DateFormat.y()
//                              .format(RequestedOn)
//                              .toString(),style: TextStyle(
//                          fontSize: 14
//                      ),),
                        )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 9,
            ),
            SummaryTiles(
              title: 'Name: ',
            ),
            SummaryTiles(
              title: 'Email ID: ',
            ),
            SummaryTiles(
              title: 'Department: ',
            ),
            SummaryTiles(
              title: 'Division: ',
            ),
            SummaryTiles(title: 'Supervisor\'s Email ID: '),
            SummaryTiles(
              title: 'Project: ',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'From:',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        From,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
                            DateFormat.d().format(fromDate).toString() +
                                ' ' +
                                DateFormat.MMM().format(fromDate).toString() +
                                ' ' +
                                DateFormat.y().format(fromDate).toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'No of days : ' + noofdays.toString(),
                    style: TextStyle(color: Colors.blueGrey[700], fontWeight: FontWeight.w600),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        'To:',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        To,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
                                DateFormat.MMM().format(toDate).toString() +
                                ' ' +
                                DateFormat.y().format(toDate).toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
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
              input: DateFormat.d().format(hotelInfo['check in date']).toString() +
                  ' ' +
                  DateFormat.MMM().format(hotelInfo['check in date']).toString() +
                  ' ' +
                  DateFormat.y().format(hotelInfo['check in date']).toString(),
            ),
            SummaryTiles(
              title: 'Checkout Date: ',
              input: DateFormat.d().format(hotelInfo['check out date']).toString() +
                  ' ' +
                  DateFormat.MMM().format(hotelInfo['check out date']).toString() +
                  ' ' +
                  DateFormat.y().format(hotelInfo['check out date']).toString(),
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
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 110, vertical: 5),
                      child: Text(
                        'International Trip',
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
              input: formInfo['details of estimated expenses']['travelamt'],
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
                ),
                SummaryTiles(
                  title: 'Drop Date: ',
                ),
                SummaryTiles(
                  title: 'Rental Company Name: ',
                ),
                SummaryTiles(
                  title: 'Pickup Address: ',
                ),
                SummaryTiles(
                  title: 'Drop Address: ',
                ),
                SummaryTiles(
                  title: 'Vehicle Type: ',
                ),
                SummaryTiles(
                  title: 'Service Type: ',
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
                input: legInfo['t'],
              ),
            ],
          ),
        ),
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
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 17),
      ),
    );
  }
}

class SummaryTiles extends StatelessWidget {
  SummaryTiles({this.title, this.input});

  String title;
  String input;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
