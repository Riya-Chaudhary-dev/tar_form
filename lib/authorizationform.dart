import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'Animation/FadeAnimation.dart';
import 'dropDownMenu.dart';

class AuthorizationForm extends StatefulWidget {
  @override
  _AuthorizationFormState createState() => _AuthorizationFormState();
}

class _AuthorizationFormState extends State<AuthorizationForm> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  bool checkboxValue = false;

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
                  value: 0.9,
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
                DescriptionTag('Request Description'),
                SizedBox(
                  height: 4,
                ),
                TitleBox(text: 'Requested By: '),
                dropDownMenuBox(
                  attribute: "requester",
                  initialval: "ggg",
                  items: ['dhdhdh', 'kkkk', 'ggg'],
                ),
                TitleBox(text: 'Requester\'s Email ID: '),
                InfoBox(context: this.context, text: 'riya@gmail.com'),
                TitleBox(text: 'Department:'),
                InfoBox(context: this.context, text: 'HR'),
                TitleBox(text: 'Accounts Email ID:'),
                dropDownMenuBox(
                  items: ['jj', 'kkk', 'pune'],
                  initialval: 'pune',
                  attribute: "accEmail",
                ),
                TitleBox(text: 'Approver\'s Email ID'),
                dropDownMenuBox(
                  items: ['pune', 'kkk'],
                  initialval: 'kkk',
                  attribute: "apprEmail",
                ),
                TitleBox(text: 'Office:'),
                dropDownMenuBox(
                  items: ['Pune', 'Dahej'],
                  initialval: 'Pune',
                  attribute: "office",
                ),
                DescriptionTag('Travel Description'),
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
                          authDetailCard(
                              text: 'Estimated Travel Cost:', info: '123'),
                          Divider(),
                          authDetailCard(
                              text: 'Accommodation Costs:', info: 'ghghgh')
                        ],
                      ),
                    ),
                  ),
                ),
                DescriptionTag('Expenses Description'),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Card(
                    child: CheckboxListTile(
                      value: checkboxValue,
                      onChanged: (val) {
                        if (checkboxValue == false) {
                          setState(() {
                            checkboxValue = true;
                          });
                        } else if (checkboxValue == true) {
                          setState(() {
                            checkboxValue = false;
                          });
                        }
                      },
                      subtitle: !checkboxValue
                          ? Text(
                              'Required.',
                              style: TextStyle(color: Colors.red),
                            )
                          : null,
                      title: new Text(
                        'Check this box to submit this request for using HA Corporate credit card.',
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w600),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.deepPurple.shade400,
                    ),
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Color.fromRGBO(143, 148, 251, 8),
                        //                   <--- border color
                        width: 3.0,
                      ),
                    ),
                    child: Text(
                      'NOTE: THIS TRAVEL AUTHORIZATION IS REQUIRED TO BE APPROVED ATLEAST TWO WEEKS IN ADVANCE OF THE'
                      ' TRAVEL DATE. FAILURE TO HAVE THIS FORM SIGNED PRIOR TO ANY TRAVEL ARRANGEMENTS,'
                      'MAY RESULT IN THE REJECTION OF YOUR EXPENSE REIMBURSEMENT REQUEST.',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19,
                )
              ],
            ),
          ),
        ));
  }

  FadeAnimation TitleBox({String text}) {
    return FadeAnimation(
      2,
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 17,
              color: Color.fromRGBO(143, 148, 251, 1),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Padding InfoBox({BuildContext context, var text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2),
      child: Column(
        children: <Widget>[
          Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color.fromRGBO(143, 148, 251, 8),
                //                   <--- border color
                width: 3.0,
              ),
            ),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
            ),
          ),
          Divider(
            endIndent: 10,
            indent: 10,
          ),
        ],
      ),
    );
  }

  Row authDetailCard({String text, var info}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 8,
        ),
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

class DescriptionTag extends StatelessWidget {
  DescriptionTag(this.title);

  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 2,
        child: Container(
          width: MediaQuery.of(context).size.width - 15,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
             color: Color.fromRGBO(143, 148, 251, 1)),
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}


