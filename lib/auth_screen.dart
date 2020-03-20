import 'package:flutter/material.dart';
import 'package:tar_form/Animation/FadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tar_form/login_page.dart';
import 'package:tar_form/registration.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void isSignedIn() async {
    var isSigned = await FirebaseAuth.instance.currentUser();
    print(isSigned);
  }

//  void _showDialog(code) {
//    if (code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//      showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            return AlertDialog(
//                title: Text("Email already in use"),
//                content: Text("Please login with your email"),
//                actions: <Widget>[
//                  FlatButton(
//                      child: Text("Close"),
//                      onPressed: () {
//                        Navigator.of(context).pop();
//                      })
//                ]);
//          });
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      height: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill)),
                      child: Stack(children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeAnimation(
                              1,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              1.3,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeAnimation(
                              1.5,
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                        Positioned(
                            child: FadeAnimation(
                                1.6,
                                Container(
                                    margin: EdgeInsets.only(top: 50),
                                    child: Center(
                                        child: Text(
                                      "Tar form",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ))))),
                      ])),
                  SizedBox(
                    height: 80,
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
                              Navigator.pushNamed(context, LoginPage.id);
                            },
                            color: Color.fromRGBO(143, 148, 251, 1),
                            shape: StadiumBorder(),
                            child: Text(
                              "Login",
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
                              Navigator.pushNamed(context, RegistrationPage.id);
                            },
                            color: Color.fromRGBO(143, 148, 251, 1),
                            shape: StadiumBorder(),
                            child: Text(
                              "Regester",
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
            ),
          ),
        ));
  }
}
