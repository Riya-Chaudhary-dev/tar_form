import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemPurchaseCard extends StatelessWidget {
  ItemPurchaseCard({this.name,this.image,this.actualPrice,this.description,this.inflatedPrice,this.veg,this.quantity});
  String name;
  String inflatedPrice;
  String actualPrice;
  String description='jjjjjjj';
  String image;
  String quantity;
  bool veg;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
//        height: MediaQuery.of(context).size.height/4.5,
        width: MediaQuery.of(context).size.width-10,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 90,
                      height: 90,
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 70,
                      child:  veg?Stack(
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: 20,
                            color: Colors.white,
                          ),
                          Positioned(
                            top: 1,
                            left: 1,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green),
                              ),
                              child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green
                                  )
                              ),
                            ),
                          ),
                        ],
                      )
                          :Stack(
                            children: <Widget>[
                              Container(
                                height: 20,
                                width: 20,
                                color: Colors.white,
                              ),
                              Positioned(
                                top: 1,
                                left: 1,
                                child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                                border: Border.all(color: Colors.red),
                        ),
                        child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red
                                  )
                        ),
                      ),
                              ),
                            ],
                          ),
                    )
                  ],
                ),
              ),
            ),

              Container(
                height: 100,
                width: 130,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        child: Text('Milk Biscuits for Doggies',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),)),
                    Text(quantity.toString(),style: TextStyle(color: Colors.grey),),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Text('₹ '+actualPrice,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                        SizedBox(width: 10,),
                        Text('₹ '+inflatedPrice,style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough,fontSize: 16)),


                      ],
                    ),
                  ],
                ),
              ),

              FlatButton(
                onPressed: (){

                },
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.green),borderRadius: BorderRadius.all(Radius.circular(4))),
                textColor: Colors.white,
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: new Text(
                    "ADD",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.green),
                  ),
                ),
              ),

            ],),
        ),
      ),
    );
  }
}
