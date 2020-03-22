import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';

class TravelCard extends StatefulWidget {
  TravelCard({this.FromPlace, this.ToDate, this.ToPlace,@required this.legNo});

  final String ToPlace;
  final String FromPlace;
  final String ToDate;
  final int legNo;

  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  String mode;

  @override
  Widget build(BuildContext context) {
    List Modes = ['Rental Car', 'Train', 'Flight', 'Personal Car', 'Bus'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 15,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Color.fromRGBO(143, 148, 251, 1)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Leg '+widget.legNo.toString(),
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
                        width: 4,
                      ),
                      Container(
//                                padding: EdgeInsets.only(left:5.0),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color.fromRGBO(143, 148, 251, 20),
                            //                   <--- border color
                            width: 3.0,
                          ),
                        ),
                        child: Text(
                          widget.ToDate,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            Container(
//                                padding: EdgeInsets.only(left:5.0),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Color.fromRGBO(143, 148, 251, 8),
                                  //                   <--- border color
                                  width: 3.0,
                                ),
                              ),
                              child: Text(widget.FromPlace),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              'Depart To:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                            Container(
//                                padding: EdgeInsets.only(left:5.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 9, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Color.fromRGBO(143, 148, 251, 8),
                                  //                   <--- border color
                                  width: 3.0,
                                ),
                              ),
                              child: Text(widget.ToPlace),
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
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color.fromRGBO(143, 148, 251, 8),
                          //                   <--- border color
                          width: 3.0,
                        ),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Select item",
                            ),
                          ],
                        ),
                        value: mode,
                        onChanged: (Value) {
                          setState(() {
                            mode = Value;
                            print(mode);
                          });
                        },
                        items: Modes.map((user) {
                          return DropdownMenuItem(
                            value: user,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  user,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    descrBox(mode)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class descrBox extends StatefulWidget {
  descrBox(this.mode);

  String mode;

  @override
  _descrBoxState createState() => _descrBoxState();
}

class _descrBoxState extends State<descrBox> {
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
  DateTime fromDate = new DateTime.now();
  DateTime toDate = new DateTime.now();

  selectDate() async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: fromDate,
        initialLastDate: toDate,
        firstDate: (new DateTime.now()).subtract(new Duration(days: 1)),
        lastDate: new DateTime(2022));
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
                  height: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(143, 148, 251, 8),
                      width: 3.0,
                    ),
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
                  height: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(143, 148, 251, 8),
                      width: 3.0,
                    ),
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
                  height: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(143, 148, 251, 8),
                      width: 3.0,
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Vehicle Type: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  DropdownButton(
                    hint: Text("Select item"),
                    value: vehicleType,
                    onChanged: (Value) {
                      setState(() {
                        vehicleType = Value;
                        print(vehicleType);
                      });
                    },
                    items: vehicle.map((user) {
                      return DropdownMenuItem(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Service Type: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  DropdownButton(
                    hint: Text("Select item"),
                    value: serviceType,
                    onChanged: (Value) {
                      setState(() {
                        serviceType = Value;
                        print(serviceType);
                      });
                    },
                    items: service.map((user) {
                      return DropdownMenuItem(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              user,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Pickup Date ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color.fromRGBO(143, 148, 251, 1)),
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
                    'Dropoff Date: ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
              height: 43,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 3.0,
                ),
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
              height: 43,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 3.0,
                ),
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
              height: 43,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 3.0,
                ),
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
                    height: 40,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 3.0,
                      ),
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
                    height: 40,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 3.0,
                      ),
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
                  height: 43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(143, 148, 251, 8),
                      width: 3.0,
                    ),
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
