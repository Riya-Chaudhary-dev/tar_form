import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ItemPurchaseCard extends StatefulWidget {
  ItemPurchaseCard({this.name, this.description, this.veg, this.items, this.addToCart, this.updateQuantity, this.variations});

  String name;
  Function addToCart;
  Function updateQuantity;
  List items;
  Map variations;
  String description = 'jjjjjjj';
  bool veg;
  bool inCart = false;
  int itemQuantity;

  @override
  _ItemPurchaseCardState createState() => _ItemPurchaseCardState();
}

class _ItemPurchaseCardState extends State<ItemPurchaseCard> {
  checkCart() {
    for (var q in widget.items) {
      if (q['name'] == widget.name) {
        setState(() {
          widget.inCart = true;
          widget.itemQuantity = q['itemQuantity'];
        });
      }
    }
  }

  String selectedVariation;

  List<Widget> itemDetails = [];
  List<RadioModel> sampleData = List<RadioModel>();

  void getInfoColumn() {
    widget.variations.forEach((key, value) {
      sampleData.add(RadioModel(false, key.toString()));
      if (selectedVariation == null) {
        setState(() {
          selectedVariation = key;
        });
      }
      itemDetails.add(GestureDetector(
        onTap: () {
          setState(() {
            selectedVariation = key;
          });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              border: Border.all(color: key == selectedVariation ? Colors.green : Colors.grey, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Text(
              key.toString(),
              style: TextStyle(color: key == selectedVariation ? Colors.green : Colors.grey, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ));
      itemDetails.add(SizedBox(
        width: 5,
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    getInfoColumn();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedVariation);
    checkCart();
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                child: Stack(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(4),
                        width: 90,
                        height: 90,
                        margin: EdgeInsets.symmetric(horizontal: 1.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 5), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Image.network(
                          widget.variations[selectedVariation]['image'],
                        )),
                    Positioned(
                        top: 71,
                        left: 71,
                        child: widget.veg
                            ? Center(
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.green, width: 1.5), borderRadius: BorderRadius.all(Radius.circular(3))),
                                  child: Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green)),
                                ),
                              )
                            : Center(
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red[800], width: 1.5), borderRadius: BorderRadius.all(Radius.circular(3))),
                                  child: Container(width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red[800])),
                                ),
                              ))
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                height: 100,
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.name,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 21,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: sampleData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  sampleData.forEach((element) => element.isSelected = false);
                                  sampleData[index].isSelected = true;
                                  selectedVariation = sampleData[index].buttonText;
                                });
                              },
                              child: RadioItem(sampleData[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '₹ ' + widget.variations[selectedVariation]['originalPrice'].toString(),
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('₹ ' + widget.variations[selectedVariation]['discountedPrice'].toString(),
                            style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          widget.inCart
              ? QuantityButton(
                  updateQuantity: widget.updateQuantity,
                  name: widget.name,
                  items: widget.items,
                  itemQuantity: widget.itemQuantity,
                  inflatedPrice: widget.variations[selectedVariation]['originalPrice'],
                  actualPrice: widget.variations[selectedVariation]['discountedPrice'],
                  veg: widget.veg,
                  image: widget.variations[selectedVariation]['image'],
                )
              : AddToCartButton(
                  addToCart: widget.addToCart,
                  name: widget.name,
                  inflatedPrice: widget.variations[selectedVariation]['originalPrice'],
                  actualPrice: widget.variations[selectedVariation]['discountedPrice'],
                  veg: widget.veg,
                  image: widget.variations[selectedVariation]['image'],
                )
        ],
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  AddToCartButton({this.name, this.list, this.actualPrice, this.inflatedPrice, this.image, this.description, this.veg, this.addToCart});

  Function addToCart;
  String name;
  List list;
  int inflatedPrice;
  int actualPrice;
  String description = 'jjjjjjj';
  String image;
  bool veg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      child: FlatButton(
        onPressed: () {
          Map i = {
            'name': name,
            'actualPrice': actualPrice,
            'inflatedPrice': inflatedPrice,
            'veg': veg,
            'description': description,
            'image': image,
            'itemQuantity': 1
          };
          addToCart(i);
        },
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.grey[350]), borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Text(
          "ADD",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green, fontSize: 17),
        ),
      ),
    );
  }
}

class QuantityButton extends StatefulWidget {
  QuantityButton(
      {this.quantity = 1,
      this.addToCart,
      this.name,
      this.inflatedPrice,
      this.actualPrice,
      this.description,
      this.veg,
      this.image,
      this.updateQuantity,
      this.items,
      this.itemQuantity});

  int quantity;
  Function addToCart;
  Function updateQuantity;

  String name;
  List items;
  int inflatedPrice;
  int actualPrice;
  String description = 'jjjjjjj';
  String image;
  bool veg;
  bool inCart = false;
  int itemQuantity;

  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 90,
      decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 2), borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Map i = {
                'name': widget.name,
                'actualPrice': widget.actualPrice,
                'inflatedPrice': widget.inflatedPrice,
                'veg': widget.veg,
                'description': widget.description,
                'image': widget.image,
                'quantity': widget.quantity,
                'itemQuantity': widget.itemQuantity
              };
              widget.updateQuantity(i, 'subtract');
            },
            child: Text(
              '-',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800, fontSize: 25),
            ),
          ),
          Text(
            widget.itemQuantity.toString(),
            style: TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.w800),
          ),
          GestureDetector(
            onTap: () {
              Map i = {
                'name': widget.name,
                'actualPrice': widget.actualPrice,
                'inflatedPrice': widget.inflatedPrice,
                'veg': widget.veg,
                'description': widget.description,
                'image': widget.image,
                'quantity': widget.quantity,
                'itemQuantity': widget.itemQuantity
              };
              widget.updateQuantity(i, 'add');
            },
            child: Text(
              '+',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.w800, fontSize: 25),
            ),
          )
        ],
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)), border: Border.all(color: _item.isSelected ? Colors.green : Colors.grey, width: 1)),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Text(
            _item.buttonText,
            style: TextStyle(color: _item.isSelected ? Colors.green : Colors.grey, fontSize: 11, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(
    this.isSelected,
    this.buttonText,
  );
}
