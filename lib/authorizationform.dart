import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'Animation/FadeAnimation.dart';

class AuthorizationForm extends StatefulWidget {
  @override
  _AuthorizationFormState createState() => _AuthorizationFormState();
}

class _AuthorizationFormState extends State<AuthorizationForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LinearProgressIndicator(
                  value: 0.8,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.orangeAccent.shade200),
                ),
                SizedBox(
                  height: 9,
                ),
                FadeAnimation(
                  1.9,
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                    ),
                    child: Text(
                      'AUTHORIZATION FORM FOR CREDIT CARD USE',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          decorationColor: Colors.deepPurple,
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.double),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Credit Card Authorization Form must be approved prior to initiating the purchase/ payment to the potential vendor/ supplier.',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey[800]),
                  ),
                ),
                FadeAnimation(
                  2,
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'CA No.:',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color.fromRGBO(143, 148, 251, 8),
                              //                   <--- border color
                              width: 3.0,
                            ),
                          ),
                          child: Text(
                            '123456',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 38,
                        ),
                        Text(
                          'Requested Date: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color.fromRGBO(143, 148, 251, 8),
                              //                   <--- border color
                              width: 3.0,
                            ),
                          ),
                          child: Text(
                            '12 Dec 2017',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  endIndent: 10,
                  indent: 10,
                ),
                FadeAnimation(
                  2,
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Requested By: ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(143, 148, 251, 1),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: FormBuilderDropdown(
                      attribute: "requester",
//                    decoration: InputDecoration(labelText: "Gender"),
                      initialValue: 'Male',
                      hint: Text('Select'),
                      validators: [FormBuilderValidators.required()],
                      items: ['Male', 'Female', 'Other']
                          .map((requester) => DropdownMenuItem(
                              value: requester, child: Text("$requester")))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width-15,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      child: Text('Travel Description',style: TextStyle(color: Colors.white, fontSize: 17),),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          authDetailCard(
                              text: 'Traveler\'s Name:',
                              info: 'Ram ksksksksksk'),
                          Divider(),
                          authDetailCard(
                              text: 'Department: ', info: 'Accounts'),
                          Divider(),
                          authDetailCard(text: 'Destination:', info: 'pune'),
                          Divider(),
                          authDetailCard(
                              text: 'Project Details:', info: 'kkkkk'),
                          Divider(),
                          authDetailCard(
                              text: 'Approved TA No.:', info: '1234444'),
                          Divider(),
                          authDetailCard(
                              text: 'Purpose of Travel:',
                              info:
                                  'jdjjdjdjdjdjjdjdjdjjdjjdjdjdjdjdjdjdjdjdjdj'),
                          Divider(),
                          authDetailCard(text: 'Estimated Travel Cost:', info:'123'),
                          Divider(),
                          authDetailCard(text: 'Accommodation Costs:', info:'ghghgh')
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:8.0),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width-15,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6),
                          ])),
                      child: Text('Expenses Description',style: TextStyle(color: Colors.white, fontSize: 17),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Row authDetailCard({String text, var info}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 8,),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromRGBO(143, 148, 251, 8),
                //                   <--- border color
                width: 3.0,
              ),
            ),
            child: Text(
              info,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
