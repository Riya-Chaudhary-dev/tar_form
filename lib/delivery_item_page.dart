import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'delivery_card.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

Future<DocumentSnapshot> getInitialCart() async {
  //TODO: add the get current user and get their document id
  var cartData = await Firestore.instance.collection('Users').document('ZUFQFLDZwvc1G1yKqsMj').get();
  return cartData;
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getInitialCart(),
        builder: (BuildContext context, AsyncSnapshot cartData) {
          if (cartData.connectionState == ConnectionState.done) {
            return SupplyPage(
              initialCart: cartData.data.data['cart_info'],
            );
          } else {
            return Scaffold(body: Center(child: Text('loading...')));
          }
        });
  }
}

class SupplyPage extends StatefulWidget {
  SupplyPage({this.initialCart});

  final Map initialCart;

  @override
  _SupplyPageState createState() => _SupplyPageState();
}

class _SupplyPageState extends State<SupplyPage> {
  @override
  void initState() {
    super.initState();
    cartInfo['items'] = widget.initialCart['items'];
  }

  final _firestore = Firestore.instance;
  List petType = ['DOGS', 'CATS'];
  List FirstFilter = ['Type', 'Brand', 'Age', 'Breed'];
  List FoodTypes = ['Dry', 'Wet', 'Treats & Biscuits'];
  List Brands = ['Royal Canin', 'Pedigree', 'Whiskas'];
  List DogAge = ['Starter', 'Puppy', 'Adult', 'Senior'];
  List CatAge = ['Kitten', 'Adult'];
  List DogBreed = ['Beagle', 'Boxer', 'German Shepherd'];
  List CatBreed = ['Persian', 'British Shorthair'];
  List Selected = ['kkk', 'kk'];
  Map cartInfo = {'items': []};
  int totalNoOfItems;

  //callback function to add the info to the cart
  addToCart(Map info) {
    setState(() {
      cartInfo['items'].add(info);
      getUserCart();
    });
  }

  //callback function to update the info in the cart with the action given
  updateQuantity(Map info, String action) {
    Map toRemove;
    for (var q in cartInfo['items']) {
      if (q['name'] == info['name'] && q['actualPrice'] == info['actualPrice']) {
        if (action == 'add') {
          setState(() {
            q['itemQuantity'] += 1;
          });
        } else {
          if (q['itemQuantity'] == 1) {
            setState(() {
              toRemove = q;
            });
          }
          setState(() {
            q['itemQuantity'] -= 1;
          });
        }
      }
    }
    if (toRemove != null) {
      cartInfo['items'].remove(toRemove);
    }
    getUserCart();
  }

  void getUserCart() async {
    var data = await Firestore.instance.collection('Users').document('ZUFQFLDZwvc1G1yKqsMj').updateData({'cart_info': cartInfo});
  }

  void nig() async {
    var nig = await _firestore.collection('items').getDocuments();
    for (var q in nig.documents) {
      print(q.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showSearch(context: context, delegate: CustomSearchDelegate());
                  },
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size(50, 40),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
//
                  ),
                  child: TabBar(
                      labelColor: Colors.green,
                      indicatorColor: Colors.green[400],
                      indicatorWeight: 4,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      tabs: petType.map(
                        (type) {
                          return Tab(
                            text: type,
                          );
                        },
                      ).toList()),
                ),
              ),
              backgroundColor: Colors.green,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'Pet Food',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('items').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(cartInfo);
                    final stores = snapshot.data.documents;
                    List<ItemPurchaseCard> allItems = [];
                    for (var store in stores) {
                      bool veg = store.data['veg'];
                      String name = store.data['productName'];
                      Map variations = store.data['variations'];
                      allItems.add(
                        ItemPurchaseCard(
                          updateQuantity: updateQuantity,
                          addToCart: addToCart,
                          items: cartInfo['items'],
                          name: name,
                          variations: variations,
                          veg: veg,
                          description: 'kkkkk',
                        ),
                      );
                    }
                    return Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: TabBarView(children: [
                              SingleChildScrollView(child: Column(children: allItems)),
                              SingleChildScrollView(child: Column(children: allItems)),
                            ]),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Text('');
                  }
                }),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: InCartFloatingActionButton(Selected)),
      ),
    );
  }

// Shows the filter menu on the bottom
  showMenu() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                          Text(
                            ' Filter & Sort',
                            style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.close,
                            color: Colors.green,
                          ),
                          Text(
                            'Clear All',
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      DefaultTabController(
                        length: 4,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.9,
                          width: MediaQuery.of(context).size.width / 2.4,
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
//
                    ],
                  ),
                ),
                Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.grey[400], blurRadius: 7.0, offset: Offset(0.0, 0.75)),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(color: Colors.grey[400], blurRadius: 7.0, offset: Offset(0.0, 0.75)),
                        ],
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                        color: Colors.green,
                        child: Text(
                          'APPLY',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

// Shows the cart on the bottom
  showCart(Map info) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        builder: (BuildContext context) {
          // another class was created to update the cart as the modal sheet is stateless
          return CartModalBottomSheet(
            items: info['cart_info']['items'],
            updateQuantity: updateQuantity,
          );
        });
  }

  Widget InCartFloatingActionButton(List Selected) {
    bool nofilter;
    if (Selected.length == 0) {
      nofilter = false;
    } else {
      nofilter = true;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: cartInfo['items'].length == 0
          ? filterButton(Selected)
          : Row(
              children: <Widget>[
                GestureDetector(
                  onTap: showMenu,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 4 - 38,
                    decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                          Visibility(
                            visible: nofilter,
                            child: Positioned(
                              left: 35,
                              top: 10,
                              child: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  Selected.length.toString(),
                                  style: TextStyle(color: Colors.green),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                FutureBuilder(
                    future: Firestore.instance.collection('Users').document('ZUFQFLDZwvc1G1yKqsMj').get(),
                    builder: (BuildContext context, AsyncSnapshot user) {
                      if (user.connectionState == ConnectionState.done) {
                        print(user.data.data);
                        return GestureDetector(
                          onTap: () {
                            showCart(user.data.data);
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 3 / 4 - 20,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      //TODO: add a total number of items
                                      cartInfo['items'].length.toString() + ' items |',
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
                          ),
                        );
                      } else {
                        return Text('hello there');
                      }
                    })
              ],
            ),
    );
  }

  Widget filterButton(List selected) {
    String text;
    if (selected.length == 1) {
      text = ' filter applied';
    } else {
      text = ' filters applied';
    }
    if (selected.length == 0) {
      return RaisedButton(
        onPressed: showMenu,
        color: Colors.green,
        shape: StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 85,
            child: Text(
              '  Filter',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      );
    } else {
      return RaisedButton(
        onPressed: showMenu,
        color: Colors.green,
        shape: StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Text(
              ' ' + selected.length.toString() + text,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
      );
    }
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

class CartButton extends StatefulWidget {
  CartButton({this.showCart, this.cartInfo});

  Map cartInfo;
  Function showCart;

  @override
  _CartButtonState createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance.collection('Users').document('ZUFQFLDZwvc1G1yKqsMj').get(),
        builder: (BuildContext context, AsyncSnapshot user) {
          if (user.connectionState == ConnectionState.done) {
            print(user.data.data);
            return GestureDetector(
              onTap: widget.showCart,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 3 / 4 - 20,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          //TODO: add a total number of items
                          widget.cartInfo['items'].length.toString() + ' items |',
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
              ),
            );
          } else {
            return Text('hello there');
          }
        });
  }
}

// For the search button
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    return Column(
      children: <Widget>[
        Text('mmmm')
        //Build the results based on the searchResults stream in the searchBloc
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return Column();
  }
}

// This is the card in the cart
class CartCards extends StatefulWidget {
  CartCards(
      {this.name,
      this.image,
      this.originalPrice,
      this.inflatedPrice,
      this.quantity,
      this.updateQuantity,
      this.itemQuantity,
      this.cartInfo,
      this.veg,
      this.description,
      this.refreshCart});

  final String image;
  final int originalPrice;
  final int inflatedPrice;
  final String name;
  Function refreshCart;
  Function updateQuantity;
  List cartInfo;
  bool veg;
  String quantity;
  String description;
  int itemQuantity;

  @override
  _CartCardsState createState() => _CartCardsState();
}

class _CartCardsState extends State<CartCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(children: [
              Container(
                height: 80,
                width: 80,
                child: Image.network(
                  widget.image,
                ),
              ),
              SizedBox(width: 10.0),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.name, style: TextStyle(fontFamily: 'Montserrat', fontSize: 10.0, fontWeight: FontWeight.bold)),
                Row(
                  children: <Widget>[
                    widget.inflatedPrice != null
//                    widget.inflatedPrice != widget.originalPrice
                        ? Text(
                            '₹' + widget.inflatedPrice.toString(),
                            style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic, decoration: TextDecoration.lineThrough),
                          )
                        : SizedBox(
                            width: 6,
                          ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      '₹' + widget.originalPrice.toString(),
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ])
            ])),
            Row(
              children: <Widget>[
                widget.itemQuantity != 1
                    ? IconButton(
                        icon: Icon(Icons.remove_circle),
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            widget.itemQuantity--;
                          });
                          widget.updateQuantity({
                            'name': widget.name,
                            'actualPrice': widget.originalPrice,
                          }, 'subtract');
                        })
                    : IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          widget.updateQuantity({
                            'name': widget.name,
                            'actualPrice': widget.originalPrice,
                          }, 'subtract');
                          widget.refreshCart();
                        },
                      ),
                Text(widget.itemQuantity.toString()),
                IconButton(
                    icon: Icon(Icons.add_circle),
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        widget.itemQuantity++;
                      });
                      widget.updateQuantity({
                        'name': widget.name,
                        'actualPrice': widget.originalPrice,
                      }, 'add');
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CartModalBottomSheet extends StatefulWidget {
  CartModalBottomSheet({this.items, this.updateQuantity});

  List items;
  Function updateQuantity;

  @override
  _CartModalBottomSheetState createState() => _CartModalBottomSheetState();
}

class _CartModalBottomSheetState extends State<CartModalBottomSheet> {
  refreshCart() {
    setState(() {});
  }

  List<CartCards> cartList({List cartInfo}) {
    List<CartCards> cards = [];
    for (var q in cartInfo) {
      cards.add(CartCards(
        updateQuantity: widget.updateQuantity,
        name: q['name'],
        image: q['image'],
        originalPrice: q['actualPrice'],
        inflatedPrice: q['inflatedPrice'],
        cartInfo: cartInfo,
        veg: q['veg'],
        quantity: q['quantity'],
        description: 'kkkkk',
        itemQuantity: q['itemQuantity'],
        refreshCart: refreshCart,
      ));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    ),
                    Text(
                      ' Cart',
                      style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.close,
                      color: Colors.green,
                    ),
                    Text(
                      'Clear All',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
          ),
          widget.items.length == 0
              ? Center(
                  child: Text('Cart Empty'),
                )
              : Expanded(
                  child: ListView(
                    children: cartList(cartInfo: widget.items),
                  ),
                ),
          Container(
            height: 65,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey[400], blurRadius: 7.0, offset: Offset(0.0, 0.75)),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 20,
                width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  boxShadow: [
                    BoxShadow(color: Colors.grey[400], blurRadius: 7.0, offset: Offset(0.0, 0.75)),
                  ],
                ),
                child: FlatButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
                  color: Colors.green,
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
