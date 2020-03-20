import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

class HotelDetails extends StatefulWidget {
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  DateTime fromDate = new DateTime.now();
  DateTime toDate = new DateTime.now();

  selectDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDate,
        initialLastDate: toDate,
        firstDate: (new DateTime.now()).subtract(new Duration(days: 1)),
        lastDate: new DateTime(2022)
    );
    if (picked != null && picked.length == 2) {
      setState(() {
        fromDate = picked[0];
        toDate = picked[1];
      });
    }
  }

  String whichDay(DateTime date) {
    if (DateFormat.yMMMd().format(date).toString() ==
        DateFormat.yMMMd().format(DateTime.now()).toString()) {
      return 'Today';
    } else if (DateFormat.yMMMd().format(date).toString() == DateFormat.yMMMd()
        .format(DateTime.now().add(Duration(days: 1)))
        .toString()) {
      return 'Tomorrow';
    } else {
      return new DateFormat.E().format(date).toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width - 15,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: LinearGradient(colors: [
                Colors.red[600],
               Colors.red[200],
              ])),
          child:  Text(
            'Accomodation Details',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: 4,
                  ),
                  InfoRows(title: 'Hotel Name:',),
                  Divider(),
                  InfoRows(title: 'Hotel Address:',),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'CheckIn Date ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            DateFormat.d().format(fromDate).toString()+' ' +DateFormat.MMM().format(fromDate).toString()+', '+DateFormat.y().format(fromDate).toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      GestureDetector(
                          onTap: selectDate,
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.calendar_today,color: Colors.deepPurple.shade200,),
                          Center(
                            child: Text(toDate.difference(fromDate).inDays.toString()+' N',

                            ),
                          )],
                          )),
                      Column(
                        children: <Widget>[
                          Text(
                            'CheckOut Date: ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            DateFormat.d().format(toDate).toString()+' ' +DateFormat.MMM().format(toDate).toString()+', '+DateFormat.y().format(toDate).toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class InfoRows extends StatelessWidget {
  InfoRows({this.title});
  String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        Text(
          title,
          style: TextStyle(

              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Container(
            height: 35,
//                                padding: EdgeInsets.only(left:5.0),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromRGBO(143, 148, 251, 20),
                //                   <--- border color
                width: 3.0,
              ),
            ),
            child: Text(
             'hhh',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
