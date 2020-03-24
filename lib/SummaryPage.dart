import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                LinearProgressIndicator(
                  value: 0.99,
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                ),
                headerTile(
                  title: 'Traveler\'s Details',
                  color: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            SummaryTiles(
                              title: 'Name:',
                              input: 'hhhh',
                            ),
                            SummaryTiles(
                              title: 'Name',
                              input: 'hhhh',
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                headerTile(
                  title: 'Expense Details',
                  color: [
                    Color.fromRGBO(220, 20, 60, 1),
                    Color.fromRGBO(220, 20, 60, .6),
                  ],
                ),
                expenseCard(intrnational: true,meals: 111, local: 123, travel: 123,lodging: 234),
                headerTile(
                  title: 'Travel Itinerary',
                  color: [
                    Color.fromRGBO(0, 128, 255, 1),
                    Color.fromRGBO(0, 128, 255, 0.2),
                  ],
                ),
                travelCard('Flight'),
                travelCard('Bus'),
                travelCard('Personal Car'),
                travelCard('Rental Car'),
                travelCard('Train'),
                headerTile(title: 'Accomodation Details',
                  color: [
                    Color.fromRGBO(109, 54, 111, 0.8),
                    Color.fromRGBO(109, 54, 111, 0.2),

                  ],),
                  accomodation(),
//                travelCard('Bus'),
                Center(
                  child: RaisedButton(
                    padding: EdgeInsets.all(8),
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

Widget accomodation({String hotelName, String address, DateTime checkin, DateTime checkout, int noofdaya}){
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SummaryTiles(title: 'Hotel Name: ',),
          SummaryTiles(title: 'Hotel Address: ',),
          SummaryTiles(title: 'Checkin Date: ',),
          SummaryTiles(title: 'Checkout Date: ',)
        ],
      ),
    ),
  );
}

Widget expenseCard({
  double travel,
  double meals,
  double businessmeal,
  String purpose,
  String otherdes,
  double other,
  double lodging,
  double local,
  bool intrnational,
  String destination,
  String businessdesc
}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            intrnational?Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors:
                [
                  Color.fromRGBO(127, 183, 198, 0.8),
                  Color.fromRGBO(127, 183, 198,0.2)

                ]),
                borderRadius: BorderRadius.circular(5),

              ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 110,vertical: 5),
                      child: Text('International Trip',style: TextStyle(
                    fontWeight: FontWeight.w600,fontSize: 18
                ),),
              ),
            )   :  Container(
              padding: EdgeInsets.symmetric(vertical: 10),

              decoration: BoxDecoration(
                gradient: LinearGradient(colors:
                [
                  Color.fromRGBO(193, 194, 4, 0.6),
                  Color.fromRGBO(193, 194, 4,0.2)

                ]),
                borderRadius: BorderRadius.circular(5),

              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 120,vertical: 5),
                child: Text('Domestic Trip',style: TextStyle(
                    fontWeight: FontWeight.w600,fontSize: 18
                ),),
              ),
            ),
            SizedBox(height: 5,),
            SummaryTiles(title: 'Travel: ',),
            lodging!=null?SummaryTiles(title: 'Lodging: ',):Text(''),
            local!=null?SummaryTiles(title: 'Local Travel: ',):Text(''),
            SummaryTiles(title: 'Meals: ',),
            businessmeal!=null?SummaryTiles(title: 'Business Meals: ',):Text(''),
            businessdesc!=null?SummaryTiles(title: 'Description:',):Text(''),
            other!=null?SummaryTiles(title: 'Others: ',):Text('')
          ],
        ),
      ),
    ),
  );
}

Widget travelCard(mode) {
  if (mode == 'Rental Car') {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                headerTile(
                  title: 'Rental Car',
                  color: [
                    Color.fromRGBO(236, 111, 176,0.8),
                    Color.fromRGBO(236, 111, 176,0.4),
                  ],
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
  } else if (mode == 'Flight') {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              headerTile(
                title: 'Flight',
                color: [
                  Color.fromRGBO(210, 145, 188,0.9),
                  Color.fromRGBO(210, 145, 188,0.2),
                ],
              ),
              SummaryTiles(
                title: 'Flight No.:',
              ),
            ],
          ),
        ),
      ),
    );
  } else if (mode == 'Bus') {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              headerTile(
                title: 'Bus',
                color: [
                  Color.fromRGBO(144, 201, 120,0.9),
                  Color.fromRGBO(144, 201, 120,0.2),
                  ],
              ),
              SummaryTiles(
                title: 'Bus Type:',
              )
            ],
          ),
        ),
      ),
    );
  } else if (mode == 'Personal Car') {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              headerTile(
                title: 'Personal Car',
                color: [
                  Color.fromRGBO(255, 214, 0,0.9),
                  Color.fromRGBO(255, 214, 0,0.3),
                ],
              ),
              SummaryTiles(
                title: 'Distance (km): ',
              ),
              SummaryTiles(
                title: 'Rate per km:',
              ),
              SummaryTiles(
                title: 'Amount: ',
              )
            ],
          ),
        ),
      ),
    );
  } else if (mode == 'Train') {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              headerTile(
                title: 'Train',
                color: [
                  Color.fromRGBO(255, 127, 79,0.8),
                  Color.fromRGBO(255, 127, 79,0.2),
                ],
              ),
              SummaryTiles(
                title: 'Train No. & Class',
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
  List<Color> color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 15,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(colors: color)),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
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
          Expanded(
            child: Container(
              height: 43,
//                padding: EdgeInsets.symmetric(vertical: 10),
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
                        offset: Offset(0, 6))
                  ]),
              child: Center(
                  child: Text(
                    'll',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

