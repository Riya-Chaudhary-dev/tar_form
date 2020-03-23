import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Trial extends StatefulWidget {
  Trial({this.FromPlace, this.ToDate, this.ToPlace,@required this.legNo});

  final String ToPlace;
  final String FromPlace;
  final String ToDate;
  final int legNo;

  @override
  _TrialState createState() => _TrialState();
}

class _TrialState extends State<Trial> {
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
    return Scaffold(
        body :Column(
      children: <Widget>[
        FormBuilder(
          key: _fbKey,
          initialValue: {
            'date': DateTime.now(),
            'accept_terms': false,
          },
          autovalidate: true,
          child: Column(
            children: <Widget>[
              FormBuilderDateTimePicker(
                attribute: "date",
                inputType: InputType.date,
                format: DateFormat("yyyy-MM-dd"),
                decoration:
                InputDecoration(labelText: "Appointment Time"),
              ),
              FormBuilderSlider(
                attribute: "slider",
                validators: [FormBuilderValidators.min(6)],
                min: 0.0,
                max: 10.0,
                initialValue: 1.0,
                divisions: 20,
                decoration:
                InputDecoration(labelText: "Number of things"),
              ),
              FormBuilderCheckbox(
                attribute: 'accept_terms',
                label: Text(
                    "I have read and agree to the terms and conditions"),
                validators: [
                  FormBuilderValidators.requiredTrue(
                    errorText:
                    "You must accept terms and conditions to continue",
                  ),
                ],
              ),
              FormBuilderDropdown(
                attribute: "gender",
                decoration: InputDecoration(labelText: "Gender"),
                // initialValue: 'Male',
                hint: Text('Select Gender'),
                validators: [FormBuilderValidators.required()],
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                    value: gender,
                    child: Text("$gender")
                )).toList(),
              ),
              FormBuilderTextField(
                attribute: "age",
                decoration: InputDecoration(labelText: "Age"),
                validators: [
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.max(70),
                ],
              ),
              FormBuilderSegmentedControl(
                decoration:
                InputDecoration(labelText: "Movie Rating (Archer)"),
                attribute: "movie_rating",
                options: List.generate(5, (i) => i + 1)
                    .map(
                        (number) => FormBuilderFieldOption(value: number))
                    .toList(),
              ),
              FormBuilderSwitch(
                label: Text('I Accept the tems and conditions'),
                attribute: "accept_terms_switch",
                initialValue: true,
              ),
              FormBuilderStepper(
                decoration: InputDecoration(labelText: "Stepper"),
                attribute: "stepper",
                initialValue: 10,
                step: 1,
              ),
              FormBuilderRate(
                decoration: InputDecoration(labelText: "Rate this form"),
                attribute: "rate",
                iconSize: 32.0,
                initialValue: 1,
                max: 5,
              ),
              FormBuilderCheckboxList(
                decoration:
                InputDecoration(labelText: "The language of my people"),
                attribute: "languages",
                initialValue: ["Dart"],
                options: [
                  FormBuilderFieldOption(value: "Dart"),
                  FormBuilderFieldOption(value: "Kotlin"),
                  FormBuilderFieldOption(value: "Java"),
                  FormBuilderFieldOption(value: "Swift"),
                  FormBuilderFieldOption(value: "Objective-C"),
                ],
              ),
              FormBuilderChoiceChip(
                attribute: "favorite_ice_cream",
                options: [
                  FormBuilderFieldOption(
                      child: Text("Vanilla"),
                      value: "vanilla"
                  ),
                  FormBuilderFieldOption(
                      child: Text("Chocolate"),
                      value: "chocolate"
                  ),
                  FormBuilderFieldOption(
                      child: Text("Strawberry"),
                      value: "strawberry"
                  ),
                  FormBuilderFieldOption(
                      child: Text("Peach"),
                      value: "peach"
                  ),
                ],
              ),
              FormBuilderFilterChip(
                attribute: "pets",
                options: [
                  FormBuilderFieldOption(
                      child: Text("Cats"),
                      value: "cats"
                  ),
                  FormBuilderFieldOption(
                      child: Text("Dogs"),
                      value: "dogs"
                  ),
                  FormBuilderFieldOption(
                      child: Text("Rodents"),
                      value: "rodents"
                  ),
                  FormBuilderFieldOption(
                      child: Text("Birds"),
                      value: "birds"
                  ),
                ],
              ),
              FormBuilderSignaturePad(
                decoration: InputDecoration(labelText: "Signature"),
                attribute: "signature",
                height: 100,
              ),
            ],
          ),
        ),
        Row(
          children: <Widget>[
            MaterialButton(
              child: Text("Submit"),
              onPressed: () {
                if (_fbKey.currentState.saveAndValidate()) {
                  print(_fbKey.currentState.value);
                }
              },
            ),
            MaterialButton(
              child: Text("Reset"),
              onPressed: () {
                _fbKey.currentState.reset();
              },
            ),
          ],
        )
      ],
    )
    );
  }
}
