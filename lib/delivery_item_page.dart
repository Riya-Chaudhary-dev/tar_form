import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'delivery_card.dart';

class SupplyPage extends StatefulWidget {
  SupplyPage();

  @override
  _SupplyPageState createState() => _SupplyPageState();
}

class _SupplyPageState extends State<SupplyPage> {
  final _firestore = Firestore.instance;
  List petType = ['DOGS', 'CATS'];
  List FirstFilter = ['Type', 'Brand', 'Age', 'Breed'];
  List FoodTypes = ['Dry', 'Wet', 'Treats & Biscuits'];
  List Brands = ['Royal Canin', 'Pedigree', 'Whiskas'];
  List DogAge = ['Starter', 'Puppy', 'Adult', 'Senior'];
  List CatAge = ['Kitten', 'Adult'];
  List DogBreed = ['Beagle', 'Boxer', 'German Shepherd'];
  List CatBreed = ['Persian', 'British Shorthair'];
  List Selected = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Store').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                  name: name,
                  image: img,
                  actualPrice: actualPrice,
                  inflatedPrice: inflatedPrice,
                  veg: veg,
                  quantity: quantity,
                  description: 'kkkkk',
                ),
              );
            }

            return Scaffold(
                appBar: AppBar(backgroundColor: Colors.green),
                body: DefaultTabController(
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints.expand(height: 50),
                        child: TabBar(tabs: [
                          Tab(text: "dogs"),
                          Tab(text: "cats"),
                          Tab(text: "nibbas"),
                        ]),
                      ),
                      Expanded(
                        child: Container(
                          child: TabBarView(children: [
                            SingleChildScrollView(child: Column(children: allItems)),
                            SingleChildScrollView(child: Column(children: allItems)),
                            SingleChildScrollView(child: Column(children: allItems)),

                          ]),
                        ),
                      )
                    ],
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                floatingActionButton: InCartFloatingActionButton()
            );
          }
          return Text('');
        });
  }

  Widget EmptyCartFloatingButton(){
    return RaisedButton(
      onPressed: showMenu,
      color: Colors.green,
      shape: StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 85,
          child: Row(
            children: <Widget>[
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/filter.jpg')
                    )
                ),
              ),
              Text('  Filter',style: TextStyle(color: Colors.white,fontSize: 17),),
            ],
          ),
        ),
      ),
    );
  }

  showMenu() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey[300], blurRadius: 5.0, offset: Offset(0.0, 0.75)),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                padding: EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    Text(
                      '    Filter Pet Food',
                      style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  DefaultTabController(
                    length: 4,
                    child: Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 2.5,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2.4,
                      color: Colors.grey[200],
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: TabBar(
                            indicator: ShapeDecoration(color: Colors.green.withOpacity(0.1), shape: ContinuousRectangleBorder()),
                            labelColor: Colors.green,
                            unselectedLabelColor: Colors.grey,
                            isScrollable: true,
                            tabs: FirstFilter.map(
                                  (type) {
                                return getItem(
                                  text: type,
                                );
                              },
                            ).toList()),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 2.5,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.719,
//                    child: ListView(
//                            children: values.map((String key) {
//                        return new CheckboxListTile(
//                          title: new Text(key),
//                          value: false,
//                          activeColor: Colors.pink,
//                          checkColor: Colors.white,
//                          onChanged: (bool value) {
//                            setState(() {
//                              values[key] = value;
//                            });
//                          },
//                        );
//                      }).toList(),
//                    ),
                  )
                ],
              ),
              Container(
                height: 67,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey[400], blurRadius: 7.0, offset: Offset(0.0, 0.75)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 25,
                      child: FlatButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.green), borderRadius: BorderRadius.all(Radius.circular(4))),
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: new Text(
                            "CLEAR",
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width / 2 - 25,
                      child: FlatButton(
                        onPressed: () {},
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                        color: Colors.green,
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(
                            'APPLY',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  Widget InCartFloatingActionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: showMenu,
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .width / 4 - 38,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 4 - 38,
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .width / 4 - 38,
            width: MediaQuery
                .of(context)
                .size
                .width * 3 / 4 - 20,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '1 Item | ',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      '₹ 255',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'View Cart ',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Icon(
                      Icons.shopping_basket,
                      color: Colors.white,
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getItem({String text}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: RotatedBox(
        quarterTurns: -1,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(text),
        ),
      ),
    );
  }
}
