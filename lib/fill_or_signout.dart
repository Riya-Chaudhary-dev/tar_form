import 'package:flutter/material.dart';
import 'package:tar_form/Animation/FadeAnimation.dart';
import 'package:tar_form/Basic_info.dart';




class FillOrSignOut extends StatefulWidget {
  @override
  _FillOrSignOutState createState() => _FillOrSignOutState();
}

class _FillOrSignOutState extends State<FillOrSignOut> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          FadeAnimation(
              2,
              Center(
                child: Container(
                  height: 60,
                  width: 350,
                  child: RaisedButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      Navigator.pushNamed(context, BasicInfo.id);
                    },
                    color: Color.fromRGBO(143, 148, 251, 1),
                    shape: StadiumBorder(),
                    child: Text(
                      "Fill Form",
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 60,
          ),
          FadeAnimation(
              2,
              Center(
                child: Container(
                  height: 60,
                  width: 350,
                  child: RaisedButton(
                    padding: EdgeInsets.all(8),
                    onPressed: () {
                      Navigator.pop(context,true);
                    },
                    color: Color.fromRGBO(143, 148, 251, 1),
                    shape: StadiumBorder(),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
