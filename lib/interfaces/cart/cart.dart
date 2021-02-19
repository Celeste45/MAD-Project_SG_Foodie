import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sg_foodie/interfaces/food_menu/food_menu.dart';
import 'package:sg_foodie/interfaces/order_receipt/order_receipt.dart';

// Store food name data to pass to order receipt page
class CartToOrderReceipt {
  final String foodName;
  CartToOrderReceipt(this.foodName);
}

class Cart extends StatefulWidget {
  // Hold the items data passed into food menu page
  final FoodMenuToCart data;

  // Create a constructor for the cart page with data parameter
  Cart({Key key, @required this.data}) : super(key: key);

  @override
  _CartState createState() => _CartState(data);
}

class _CartState extends State<Cart> {
  // Hold the items and the food name data passed into cart page
  final FoodMenuToCart data;

  // Create a constructor for the food menu page with data parameter
  _CartState(this.data);

  String dropdownValue = 'Dine-in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3.0,
        title: Text(
          'Cart',
          style: TextStyle(
            color: Colors.lightBlue[800],
            fontSize: 24.0,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('foodMenu')
            .where('foodName', isEqualTo: data.foodName)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot cartDoc = snapshot.data.documents[index];
              return SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      // Display list of items, order options and order button
                      SizedBox.fromSize(
                        child: Container(
                          height: 140.0,
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // Display food image
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30.0, horizontal: 15.0),
                                    child: Container(
                                      width: 90.0,
                                      height: 80.0,
                                      child: Image.network(
                                        cartDoc['foodImage'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  // Display food name, food description and avg food rating
                                  Container(
                                    width: 120.0,
                                    height: 95.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        // Display food name
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            cartDoc['foodName'],
                                            style: TextStyle(
                                                color: Colors.lightBlue[800],
                                                fontSize: 20.0),
                                          ),
                                        ),

                                        // Display food description
                                        Text(
                                          cartDoc['foodDescription'],
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 20.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                        // Display avg food rating
                                        Row(
                                          children: <Widget>[
                                            Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                            Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                            Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                            Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                            Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Display food price, subtract icon, number of items and add icon.
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 25.0, horizontal: 10.0),
                                    child: Container(
                                      width: 70.0,
                                      height: 95.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          // Display food price
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 3.0),
                                              child: Text(
                                                cartDoc['foodPrice'],
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 20.0),
                                              ),
                                            ),
                                          ),

                                          // Display subtract icon, number of items and add icon.
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  // Display subtract icon
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        BoxConstraints(),
                                                    icon: Icon(
                                                      Icons.remove_rounded,
                                                      color: Colors.redAccent,
                                                    ),
                                                    onPressed: () {
                                                      if (data.items > 0) {
                                                        setState(
                                                            () => --data.items);
                                                      }
                                                    },
                                                  ),

                                                  // Display number of items
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    child: Text(
                                                      data.items.toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 16.0),
                                                    ),
                                                  ),

                                                  // Display add icon
                                                  IconButton(
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        BoxConstraints(),
                                                    icon: Icon(
                                                      Icons.add_rounded,
                                                      color: Colors.redAccent,
                                                    ),
                                                    onPressed: () {
                                                      setState(
                                                          () => ++data.items);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      // Display order text and dropdown order options
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          children: <Widget>[
                            // Display order text
                            Text(
                              'Order: ',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 20.0),
                            ),

                            // Display dropdown order options
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: Icon(Icons.arrow_downward),
                                iconSize: 24,
                                elevation: 5,
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 20.0),
                                underline: Container(
                                  height: 2,
                                  color: Colors.redAccent,
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Dine-in',
                                  'Takeaway',
                                  'Delivery'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Display confirm order button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue[800],
                              elevation: 5.0,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Confirm Order',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                            onPressed: () {
                              CartToOrderReceipt data =
                                  new CartToOrderReceipt(cartDoc['foodName']);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrderReceipt(data: data)),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
