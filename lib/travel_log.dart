import 'package:flutter/material.dart';
import 'dart:math';


class TravelLogPage extends StatefulWidget {
  static String id = 'travel_logs';

  @override
  _TravelLogPageState createState() => _TravelLogPageState();
}

class _TravelLogPageState extends State<TravelLogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
          onPressed: (){

          },
        ),
        backgroundColor: Color.fromRGBO(143, 148, 251, 1),
        title: Text(
          'Travel Log',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TravelLogCards()
          ],
        ),
      ),
    );
  }
}

class TravelLogCards extends StatelessWidget {
  TravelLogCards({this.ToDate,this.From,this.FromDate,this.status,this.TaNo,this.To});
  String TaNo;
  String From;
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
                    .withOpacity(0.3),
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
                   SizedBox(height: 10,),
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
                            Icon(Icons.compare_arrows, color: Colors.red,size: 30,),
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        color: color
                          ),
                      child:
                          Text(status.toUpperCase(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),))

                  ],)
                ),
              ),
            ),
          ),
        ),
      );
  }
}
