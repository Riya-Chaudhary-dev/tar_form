import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemPurchaseCard extends StatelessWidget {
  ItemPurchaseCard({
    this.name,
    this.image,
    this.actualPrice,
    this.description,
    this.inflatedPrice,
    this.veg,
    this.quantity,
    this.cartInfo,
    this.addToCart,
    this.updateQuantity,
  });

  String name;
  Function addToCart;
  Function updateQuantity;
  List<Map> cartInfo;
  int inflatedPrice;
  int actualPrice;
  String description = 'jjjjjjj';
  String image;
  String quantity;
  bool veg;

  @override
  Widget build(BuildContext context) {
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
                          image,
                        )),
                    Positioned(
                        top: 71,
                        left: 71,
                        child: veg
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 21,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3)), border: Border.all(color: Colors.green, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    quantity.toString(),
                                    style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3)), border: Border.all(color: Colors.grey, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    quantity.toString(),
                                    style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3)), border: Border.all(color: Colors.grey, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    quantity.toString(),
                                    style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(3)), border: Border.all(color: Colors.grey, width: 1)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Text(
                                    quantity.toString(),
                                    style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '₹ ' + actualPrice.toString(),
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('₹ ' + inflatedPrice.toString(),
                            style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ), //
            ],
          ),
          QuantityButton(
            updateQuantity: updateQuantity,
            cartInfo: cartInfo,
            addToCart: addToCart,
            name: name,
            veg: veg,
            actualPrice: actualPrice,
            description: description,
            inflatedPrice: inflatedPrice,
            image: image,
          ),
        ],
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  AddToCartButton({this.name, this.cartInfo, this.actualPrice, this.inflatedPrice, this.image, this.description, this.veg, this.addToCart});

  Function addToCart;
  String name;
  List<Map> cartInfo;
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
      {this.quantity = 0,
      this.addToCart,
      this.name,
      this.inflatedPrice,
      this.actualPrice,
      this.description,
      this.veg,
      this.image,
      this.updateQuantity,
      this.cartInfo});

  int quantity;
  Function addToCart;
  Function updateQuantity;

  String name;
  List<Map> cartInfo;
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
  checkCart() {
    for (var q in widget.cartInfo) {
      if (q['name'] == widget.name) {
        print(widget.name);
        setState(() {
          widget.inCart = true;
          widget.itemQuantity = q['itemQuantity'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //Check if item is present in cart and show either add to cart button or the quantity button
    checkCart();
    return widget.inCart != true
        ? AddToCartButton(
            cartInfo: widget.cartInfo,
            addToCart: widget.addToCart,
            name: widget.name,
            actualPrice: widget.actualPrice,
            description: widget.description,
            inflatedPrice: widget.inflatedPrice,
            image: widget.image,
          )
        : Container(
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
