import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tar_form/SummaryPage.dart';
import 'package:intl/intl.dart';

class TravelLogPage extends StatefulWidget {
  static String id = 'travel_logs';

  @override
  _TravelLogPageState createState() => _TravelLogPageState();
}

bool isSupervisor = true;

class _TravelLogPageState extends State<TravelLogPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('tar submissions').snapshots(),
        builder: (context, snapshot) {
          List<TravelLogCards> pending = [];
          List<TravelLogCards> completed = [];
          if (snapshot.hasData) {
            for (var q in snapshot.data.documents) {
              if (q.data['status'] == 'pending') {
                pending.add(TravelLogCards(
                  formDetails: q.data['form details'],
                  status: 'PENDING',
                  taNo: q.data['TA no'],
                  documentId: q.documentID,
                ));
              } else if (q.data['status'] == 'rejected') {
                completed.add(TravelLogCards(
                  formDetails: q.data['form details'],
                  status: 'REJECTED',
                  taNo: q.data['TA no'],
                  documentId: q.documentID,
                ));
              } else if (q.data['status'] == 'approved') {
                completed.add(TravelLogCards(
                  formDetails: q.data['form details'],
                  status: 'APPROVED',
                  taNo: q.data['TA no'],
                  documentId: q.documentID,
                ));
              }
            }
          }
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                bottom: TabBar(
                  tabs: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'PENDING',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        'COMPLETED',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  'Travel Logs',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: TabBarView(
                children: [
                  SingleChildScrollView(child: Column(children: pending)),
                  SingleChildScrollView(child: Column(children: completed)),
                ],
              ),
            ),
          );
        });
  }
}

class TravelLogCards extends StatelessWidget {
  TravelLogCards({this.formDetails, this.status, this.taNo, this.documentId});

  Map formDetails;
  String status;
  Color color;
  final int taNo;
  String documentId;

  @override
  Widget build(BuildContext context) {
    if (status == 'APPROVED') {
      color = Colors.green;
    } else if (status == 'REJECTED') {
      color = Colors.red;
    } else {
      color = Colors.yellow;
      status = 'PENDING';
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SummaryPage(
              formInfo: formDetails,
              fromFirebase: true,
              isSupervisor: true,
              status: status,
              taNo: taNo,
              documentId: documentId,
            ),
          ),
        );
      },
      child: Hero(
        tag: taNo.toString(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  'TA No.:',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
//                                padding: EdgeInsets.only(left:5.0),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      //                   <--- border color
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Text(
                                    'HA-' + taNo.toString(),
                                    style: TextStyle(letterSpacing: 2, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'Requested on:',
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Container(
//                                padding: EdgeInsets.only(left:5.0),
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.deepPurple,
                                      //                   <--- border color
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Text(
                                    '12 Dec 2017',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'Pune',
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                Text(
                                  DateFormat.d().format(formDetails['from date'].toDate()).toString() +
                                      ' ' +
                                      DateFormat.MMM().format(formDetails['from date'].toDate()).toString() +
                                      ' ' +
                                      DateFormat.y().format(formDetails['from date'].toDate()).toString(),
                                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Icon(
                                  Icons.compare_arrows,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                Text(formDetails['to date'].toDate().difference(formDetails['from date'].toDate()).inDays.toString() + ' Days',
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  formDetails['destination'],
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                                ),
                                Text(
                                  DateFormat.d().format(formDetails['to date'].toDate()).toString() +
                                      ' ' +
                                      DateFormat.MMM().format(formDetails['to date'].toDate()).toString() +
                                      ' ' +
                                      DateFormat.y().format(formDetails['to date'].toDate()).toString(),
                                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                            ))
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.grey[200],
            ),
            Text(
              'No travel authorization requested yet.',
              style: TextStyle(color: Colors.grey[200]),
            ),
          ],
        ),
      ),
    );
  }
}
