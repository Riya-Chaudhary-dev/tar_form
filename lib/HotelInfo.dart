import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:tar_form/custom_expansion_tile.dart' as custom;
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HotelDetails extends StatefulWidget {
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  DateTime fromDate = new DateTime.now();
  DateTime toDate = new DateTime.now();
  String hotelName;
  String hotelAddress;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();


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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
//        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.redAccent.shade100,
        ),
        child: custom.ExpansionTile(
          headerBackgroundColor: Colors.redAccent,
          iconColor: Colors.white,

          title:
      Container(
            width: MediaQuery.of(context).size.width - 15,
            padding: EdgeInsets.all(8),

            child:
            Text(
              'Accomodation Details',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          children: <Widget>[
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: FormBuilder(
                key: _fbKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: 4,
                    ),
                    InfoRows(title: 'Hotel Name:',attribute: "hotelName",onSaved: (val){
                      setState(() {
                        hotelName=val;
                      });
                    },
                      validtors: [FormBuilderValidators.required()],
                    ),
                    Divider(),
                    InfoRows(title: 'Hotel Address:',attribute: "hotelAddress",onSaved: (val){
                      setState(() {
                        hotelAddress=val;
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
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.redAccent),
                            child: Center(
                              child: Text(
                                'Select Dates',
                                style: TextStyle(color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),
                        ),
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
          ),
        )
          ],
        ),
      ),
    );

  }
}
class InfoRows extends StatefulWidget {
  InfoRows({this.title, this.attribute,this.onSaved,this.validtors});
  String title;
  String attribute;
  Function onSaved;
  List validtors;
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
          style: TextStyle(

              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        SizedBox(
          width: 4,
        ),
        Expanded(
          child: Container(
            height: 53,
//                                padding: EdgeInsets.only(left:5.0),
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.redAccent,
                //                   <--- border color
                width: 3.0,
              ),
            ),
            child: FormBuilderTextField(
//              validators: widget.validtors,
              attribute: widget.attribute,
              onSaved: widget.onSaved,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText:
                  widget.title,
                  hintStyle: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15)),
            )
          ),
        ),
      ],
    );
  }
}



