import 'package:flutter/material.dart';
import 'HotelInfo.dart';
import 'travelITCard.dart';
import 'Animation/FadeAnimation.dart';

class TravelItinerary extends StatefulWidget {
  @override
  _TravelItineraryState createState() => _TravelItineraryState();
}

class _TravelItineraryState extends State<TravelItinerary> {
  bool checkboxValue=false;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LinearProgressIndicator(
                  value: 0.7,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.orangeAccent),
                ),
//                Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                  child: Card(
//                    elevation: 2,
//                    child: Container(
//                      width: MediaQuery.of(context).size.width - 15,
//                      padding: EdgeInsets.all(8),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(4),
//                          gradient: LinearGradient(colors: [
//                            Color.fromRGBO(143, 148, 251, 1),
//                            Color.fromRGBO(143, 148, 251, .6),
//                          ])),
//                      child: Text(
//                        'Travel Itinerary',
//                        style: TextStyle(color: Colors.white, fontSize: 17),
//                      ),
//                    ),
//                  ),
//                )
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 15,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Departing Date:',
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                              Text(
                                'Return Date:',
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                          Icon(Icons.cached, color: Colors.white,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '12 Dec 2019',
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                              Text(
                                'Never',
                                style: TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TravelCard(ToPlace: 'Pune',FromPlace: 'Kol',ToDate: '21 Dec 2019',),
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
                        padding: EdgeInsets.symmetric(horizontal: 60,vertical: 8),
                        onPressed: (){},
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
    );
  }
}
