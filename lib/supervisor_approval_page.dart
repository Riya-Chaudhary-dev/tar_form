import 'package:flutter/material.dart';
import 'dart:math';

class ApprovalPage extends StatefulWidget {
  @override
  _ApprovalPageState createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            onPressed: (){

            },
          ),
          backgroundColor: Color.fromRGBO(143, 148, 251, 0.8),
          title: Text(
            'Travel Approvals',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(

            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,),
            tabs: <Widget>[
              Tab(
                text: 'Pending',
              ),
              Tab(text: 'Processed',)
            ],
          ),
        ),
        body:TabBarView(children: <Widget>[
          TravelApprovalCards(),
          EmptyPage(pendingPage: false,),
       ]),
      ),
    );
  }
}

class TravelApprovalCards extends StatelessWidget {
  TravelApprovalCards({this.ToDate,this.From,this.FromDate,this.status,this.TaNo,this.To});
  String TaNo;
  String From;
  String name;
  String empid;
  String department;
  String To;
  DateTime RequestedOn;
  DateTime FromDate;
  DateTime ToDate;
  String status;
  Color color;

  @override
  Widget build(BuildContext context) {
    if(status=='approved'){
      color=Colors.green;
    }
    else if(status=='rejected'){
      color=Colors.red;
    }
    else{
      color=Colors.yellow;
      status='PENDING';
    }
    return GestureDetector(
      onTap: (){
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.primaries[Random().nextInt(Colors.primaries.length)]
                    .withOpacity(0.2),
                borderRadius: BorderRadius.circular(7),
              ),

              child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(

                              children: <Widget>[
                                Text('TA No.:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                SizedBox(width: 2,),
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
                                  child: Text('HA-23458',style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 14
                                  ),),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text('Requested on:',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),),
                                SizedBox(width: 2,),
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
                                  child: Text('12 Dec 2017',style: TextStyle(
                                      fontSize: 14
                                  ),),
                                )
                              ],
                            ),

                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Riya Chaudhary',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),),
                            Text('Snr Engineer, '+'Pune',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 15),),
                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('Pune', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                Text('8 June 1999', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Icon(Icons.arrow_forward, color: Colors.red,size: 30,),
                                Text('2 Days',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600))
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text('Pune', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                Text('8 June 2020', style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color
                              ),
                              child:
                              Text(status.toUpperCase(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)),
                        )

                      ],),
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class EmptyPage extends StatelessWidget {
  EmptyPage({this.pendingPage});
  bool pendingPage;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: pendingPage?Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, color: Colors.grey[400],),
            SizedBox(width: 5,),
            Text('Phew, no travel requests pending!',style: TextStyle(color: Colors.grey[400]),),
          ],
        ),
      ):Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, color: Colors.grey[400],),
            SizedBox(width: 5,),
            Text('No travel authorization processed yet.',style: TextStyle(color: Colors.grey[400]),),
          ],
        ),
      ),
    );
  }
}
