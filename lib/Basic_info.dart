import 'package:flutter/material.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  DateTime _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          'Tarvel Authorization Form',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(_dateTime == null ? 'Nothing selected':_dateTime.toString()),
            RaisedButton(
              color: Color.fromRGBO(143, 148, 251, 1),
              shape: StadiumBorder(),
              child: Text('Pick a date',style: TextStyle(color: Colors.white),),
              onPressed: () {
                showDatePicker(
                    context: context,
                    initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2021)
                ).then((date) {
                  setState(() {
                    _dateTime = date;
                  });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
