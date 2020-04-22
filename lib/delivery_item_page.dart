import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'delivery_card.dart';

class SupplyPage extends StatefulWidget {
  SupplyPage();

  @override
  _SupplyPageState createState() => _SupplyPageState();
}

class _SupplyPageState extends State<SupplyPage> {
  final _firestore = Firestore.instance;
  List petType=['DOGS','CATS'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: petType.length,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],

            backgroundColor: Colors.green,
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },
              icon: Icon(Icons.arrow_back,color: Colors.white,),),
            title:Text('Pet Food',style: TextStyle(color: Colors.white),),
          ),
          body: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,

                    boxShadow: [BoxShadow(
                      color: Colors.grey[200],
                      blurRadius: 5.0,
                    ),]
                ),
                child: TabBar(
                    labelColor: Colors.green,
                    indicatorColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabs: petType.map((type){
                      return Tab(text: type,);
                    },).toList()
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('Store').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      final stores = snapshot.data.documents;
                      List<ItemPurchaseCard> allItems = [];
                      for (var store in stores) {
                         bool veg = store.data['Veg'];
                         String img = store.data['Image link'];
                         String name = store.data['Name '];
                         String actualPrice = store.data['actualPrice'];
                         String inflatedPrice = store.data['inflatedPrice'];
                         String quantity = store.data['Quantity'];

                        allItems.add(
                          ItemPurchaseCard(
                            name:name,
                            image: img,
                            actualPrice: actualPrice,
                            inflatedPrice: inflatedPrice,
                            veg: veg,
                            quantity: quantity,
                            description: 'kkkkk',
                          ),
                        );
                      }

                      return Column(
                        children: allItems,
                      );
                    }
                    return Text('hhh');

                  }
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: RaisedButton(
            color: Colors.green,
            shape: StadiumBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 60,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/filter.jpg')
                        )
                      ),
                    ),
                    Text(' Filter',style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
