import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:tar_form/custom_expansion_tile.dart' as custom;
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TravelCard extends StatefulWidget {
  TravelCard({this.FromPlace, this.ToDate, this.ToPlace});

  String ToPlace;
  String FromPlace;
  String ToDate;

  @override
  _TravelCardState createState() => _TravelCardState();
}

class _TravelCardState extends State<TravelCard> {
  String mode;
  String departTo;
  String departFrom;
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
//    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

    List Modes = ['Rental Car', 'Train', 'Flight', 'Personal Car', 'Bus'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
//        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromRGBO(143, 148, 251, 1),
        ),
        child: custom.ExpansionTile(
          title: Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Leg 1',
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
                      width: 7,
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color.fromRGBO(143, 148, 251, 150),
                          //                   <--- border color
                          width: 3.0,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: ()=>_selectDate(context),
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
                          style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
          headerBackgroundColor: Color.fromRGBO(143, 148, 251, 0.6),
          iconColor: Colors.white,
          initiallyExpanded: true,
          children: <Widget>[
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
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Container(
                                height:65,
                                width: 120,
//                                padding: EdgeInsets.only(left:5.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color.fromRGBO(143, 148, 251, 8),
                                    //                   <--- border color
                                    width: 3.0,
                                  ),
                                ),
                                child:  FormBuilderTextField(
                                  attribute: "departTo",
                                  onSaved: (value) {
                                    value!=null?departFrom = value:departFrom='';
                                  },
                                  validators: [
                                    FormBuilderValidators.required(),
                                  ],
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                      'Place',
                                      hintStyle: TextStyle(
                                          color: Colors.grey[300],
                                          fontSize: 15)),
                                ),
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
                                height:65,
                                width: 120,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 1),
//                                padding: EdgeInsets.only(left:5.0),
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 2, ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: Color.fromRGBO(143, 148, 251, 8),
                                    //                   <--- border color
                                    width: 3.0,
                                  ),
                                ),
                                child:  FormBuilderTextField(
                                  attribute: "departTo",
                                  onSaved: (value) {
                                    value!=null?departTo = value:departTo='';
                                  },
                                  validators: [
                                    FormBuilderValidators.required(),
                                  ],
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                      'Place',
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
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Color.fromRGBO(143, 148, 251, 8),
                            //                   <--- border color
                            width: 3.0,
                          ),
                        ),
                        child: Center(
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
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
  String busType;
  String rentalName;
  String PickUpAdd;
  String DropAdd;
  String traindeets;
  String flightdeets;
  double personalCaramt;
  double personalCardist;
  double personalCarrate;

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
    if (widget.mode == 'Rental Car') {
      return FormBuilder(
        key: _fbKey,
        child: Column(
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
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 3.0,
                      ),
                    ),
                    child: FormBuilderTextField(
                      attribute: "RetalName",
                      onSaved: (val){
                        setState(() {
                          rentalName=val;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                          'Rental Company Name',
                          hintStyle: TextStyle(
                              color: Colors.grey[300],
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
                  'Pickup Address: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 3.0,
                      ),
                    ),
                    child: FormBuilderTextField(
                      attribute: "carPickupAddress",
                      onSaved: (val){
                        setState(() {
                          PickUpAdd=val;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                          'PickUp address',
                          hintStyle: TextStyle(
                              color: Colors.grey[300],
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
                  'Dropoff Address: ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Expanded(
                  child: Container(
                    height: 65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 3.0,
                      ),
                    ),
                    child: FormBuilderTextField(
                      attribute: "carDropOffAddress",
                      onSaved: (val){
                        setState(() {
                          DropAdd=val;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                          'Dropoff address',
                          hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15)),
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
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.deepPurple.shade200,
                    )),
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
        ),
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
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 3.0,
                ),
              ),
              child: FormBuilderTextField(
                attribute: "flightNo",
                onSaved: (val){
                  setState(() {
                    flightdeets=val;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                    'Flight No.',
                    hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15)),
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
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 3.0,
                ),
              ),
              child: FormBuilderTextField(
                attribute: "trainDetails",
                onSaved: (val){
                  setState(() {
                    traindeets=val;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                    'Train no. & Class',
                    hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15)),
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
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color.fromRGBO(143, 148, 251, 8),
                  width: 3.0,
                ),
              ),
              child: FormBuilderTextField(
                attribute: "BusType",
                onSaved: (val){
                  setState(() {
                    busType=val;
                  });
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                    'Luxury/Sleeper',
                    hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15)),
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
                    height: 65,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 3.0,
                      ),
                    ),
                    child: FormBuilderTextField(
                      attribute: "personalCarDistance",
                      onSaved: (val){
                        setState(() {
                          personalCardist=double.parse(val);
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                          'Distance in km',
                          hintStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 15)),
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
                    height: 65,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        width: 3.0,
                      ),
                    ),
                    child: FormBuilderTextField(
                      attribute: "personalCarRate",
                      onSaved: (val){
                        setState(() {
                          personalCarrate=double.parse(val);
                        });
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                          'Rate',
                          hintStyle: TextStyle(
                              color: Colors.grey[600],
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
          Row(
            children: <Widget>[
              Text(
                'Amount: ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Container(
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(143, 148, 251, 8),
                      width: 3.0,
                    ),
                  ),
                  child: FormBuilderTextField(
                    attribute: "personalCaramt",
                    onSaved: (val){
                      setState(() {
                        personalCaramt=double.parse(val);
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:
                        'Rate times cost per km',
                        hintStyle: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 15)),
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