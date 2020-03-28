import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tar_form/registration.dart';
import 'Animation/FadeAnimation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login_page';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
        return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
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
                        child: Stack(
                          children: <Widget>[
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
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
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
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey[100]))),
                                          child: FormBuilderTextField(
                                            attribute: "email",
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            validators: [
                                              FormBuilderValidators.required(),
                                              FormBuilderValidators.email()
                                            ],
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(8.0),
                                          child: FormBuilderTextField(
                                            validators: [
                                              FormBuilderValidators.minLength(8),
                                              FormBuilderValidators.required()
                                            ],
                                            attribute: "password",
                                            obscureText: true,
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey[400])),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                                2,
                                GestureDetector(
                                  onTap: () async {
                                    if (_fbKey.currentState.saveAndValidate()) {
                                      setState(() {
                                        showSpinner = true;
                                      });
//                                  if(_fbKey.currentState.value['email'].toString().endsWith('holtec.com')){
//                                  }
                                      try{
                                      await FirebaseAuth.instance
                                          .signInWithEmailAndPassword(
                                              email: _fbKey
                                                  .currentState.value['email'],
                                              password: _fbKey
                                                  .currentState.value['password']);
                                      FirebaseUser user =
                                          await FirebaseAuth.instance.currentUser();
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      if (user.isEmailVerified) {
                                        Navigator.pop(context, true);
                                      } else {

                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  title: Text(
                                                      "Please verify with email"),
                                                  content: Text(
                                                      "An email has been sent to your account for verfication, Please verify email to continue.\n if you have not recieved an email click on resend email"),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                        child: Text("Resend email"),
                                                        onPressed: () async {
                                                          await user
                                                              .sendEmailVerification();
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                    FlatButton(
                                                        child: Text("Close"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        }),
                                                  ]);
                                            });
                                      }}catch(e){
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        print(e);
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
                                        "Login",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                                1.5,
                                Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            FadeAnimation(
                                1.5,
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, RegistrationPage.id);
                                  },
                                  child: Text(
                                    "Not a Member yet?",
                                    style: TextStyle(
                                        color: Color.fromRGBO(143, 148, 251, 1)),
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            showSpinner? Container(
              color: Colors.black54,
              child: Center(child: SpinKitWave(color: Colors.white,),),
            ):SizedBox(),
          ],
        ));
  }
}
