import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Animation/FadeAnimation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RegistrationPage extends StatefulWidget {
  static String id = 'regestration_page';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  void _showDialog(code) {
    if (code == 'ERROR_EMAIL_ALREADY_IN_USE') {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Email already in use"),
                content: Text("Please login with your email"),
                actions: <Widget>[
                  FlatButton(
                      child: Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ]);
          });
    }
  }

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
                                      "Register",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    )))))
                      ])),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.8,
                            Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10))
                                    ]),
                                child: FormBuilder(
                                    key: _fbKey,
                                    child: Column(children: <Widget>[
//                                    Container(
//                                      padding: EdgeInsets.all(8.0),
//                                      decoration: BoxDecoration(
//                                          border: Border(
//                                              bottom: BorderSide(
//                                                  color: Colors.grey[100]))),
//                                      child: FormBuilderTextField(
//                                        attribute: "empid",
//                                        validators: [
//                                          FormBuilderValidators.required(),
//                                        ],
//                                        decoration: InputDecoration(
//                                            border: InputBorder.none,
//                                            hintText: "Employee ID",
//                                            hintStyle: TextStyle(
//                                                color: Colors.grey[400])),
//                                      ),
//                                    ),
//                                    Container(
//                                      padding: EdgeInsets.all(8.0),
//                                      decoration: BoxDecoration(
//                                          border: Border(
//                                              bottom: BorderSide(
//                                                  color: Colors.grey[100]))),
//                                      child: FormBuilderTextField(
//                                        attribute: "name",
//                                        maxLines: 1,
//                                        validators: [
//                                          FormBuilderValidators.required(),
//                                          FormBuilderValidators.minLength(3),
//                                        ],
//                                        decoration: InputDecoration(
//                                            border: InputBorder.none,
//                                            hintText: "Name",
//                                            hintStyle: TextStyle(
//                                                color: Colors.grey[400])),
//                                      ),
//                                    ),
                                      Container(
                                        padding: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[100]))),
                                        child: FormBuilderTextField(
                                          attribute: "email",
                                          validators: [
                                            FormBuilderValidators.email(),
                                            FormBuilderValidators.required()
                                          ],
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.email,
                                                  color: Colors.grey[400]),
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400])),
                                        ),
                                      ),
//                                    Container(
//                                      padding: EdgeInsets.all(8.0),
//                                      decoration: BoxDecoration(
//                                          border: Border(
//                                              bottom: BorderSide(
//                                                  color: Colors.grey[100]))),
//                                      child: FormBuilderTextField(
//                                        attribute: "department",
//                                        validators: [
//                                          FormBuilderValidators.required(),
//                                          FormBuilderValidators.minLength(3),
//                                        ],
//                                        decoration: InputDecoration(
//                                            border: InputBorder.none,
//                                            hintText: "Department",
//                                            hintStyle: TextStyle(
//                                                color: Colors.grey[400])),
//                                      ),
//                                    ),

//                                    Container(
//                                      padding: EdgeInsets.all(8.0),
//                                      decoration: BoxDecoration(
//                                          border: Border(
//                                              bottom: BorderSide(
//                                                  color: Colors.grey[100]))),
//                                      child: FormBuilderTextField(
//                                        attribute: "Location",
//                                        validators: [
//                                          FormBuilderValidators.required(),
//                                        ],
//                                        decoration: InputDecoration(
//                                            border: InputBorder.none,
//                                            hintText: "Location",
//                                            hintStyle: TextStyle(
//                                                color: Colors.grey[400])),
//                                      ),
//                                    ),
//                                    Container(
//                                      padding: EdgeInsets.all(8.0),
//                                      decoration: BoxDecoration(
//                                          border: Border(
//                                              bottom: BorderSide(
//                                                  color: Colors.grey[100]))),
//                                      child: FormBuilderTextField(
//                                        attribute: "supervisor",
//                                        validators: [
//                                          FormBuilderValidators.required(),
//                                        ],
//                                        decoration: InputDecoration(
//                                            border: InputBorder.none,
//                                            hintText: "Supervisor\'s Email ID:",
//                                            hintStyle: TextStyle(
//                                                color: Colors.grey[400])),
//                                      ),
//                                    ),
                                      Container(
                                          padding: EdgeInsets.all(8.0),
                                          child: FormBuilderTextField(
                                            attribute: 'password',
                                            obscureText: true,
                                            maxLines: 1,
                                            validators: [
                                              FormBuilderValidators.required(),
                                              FormBuilderValidators.minLength(
                                                  8),
                                            ],
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                    Icons.lock_open,
                                                    color: Colors.grey[400]),
                                                border: InputBorder.none,
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ))
                                    ])))),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            2,
                            GestureDetector(
                              onTap: () async {
                                if (_fbKey.currentState.saveAndValidate()) {
                                  try {
                                    await _auth
                                        .createUserWithEmailAndPassword(
                                            email: _fbKey
                                                .currentState.value['email'],
                                            password: _fbKey.currentState
                                                .value['password']);
                                    FirebaseUser user =
                                        await _auth.currentUser();
                                    user.sendEmailVerification();
                                  } catch (e) {
                                    if (e is PlatformException) {
                                      _showDialog(e.code);
                                    }
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    gradient: LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                            1.5,
                            Text(
                              "Already registered? Login",
                              style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1)),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
