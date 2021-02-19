import 'package:flutter/material.dart';
import 'package:sg_foodie/interfaces/food_review/food_review.dart';
import 'package:sg_foodie/interfaces/cart/cart.dart';

// Store food name data to pass to food review page
class OrderReceiptToFoodReview {
  final String foodName;
  OrderReceiptToFoodReview(this.foodName);
}

class OrderReceipt extends StatefulWidget {
  // Hold the food name data passed into order receipt page
  final CartToOrderReceipt data;

  // Create a constructor for the order receipt page with data parameter
  OrderReceipt({Key key, @required this.data}) : super(key: key);

  @override
  _OrderReceiptState createState() => _OrderReceiptState(data);
}

class _OrderReceiptState extends State<OrderReceipt> {
  // Hold the food name data passed into order receipt page
  final CartToOrderReceipt data;

  // Create a constructor for the order receipt page with data parameter
  _OrderReceiptState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3.0,
        title: Text(
          'Order Receipt',
          style: TextStyle(
            color: Colors.lightBlue[800],
            fontSize: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Order No',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    '1890',
                    style: TextStyle(
                      color: Colors.lightBlue[800],
                      fontSize: 24.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    'Ready in',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    '10 min',
                    style: TextStyle(
                      color: Colors.lightBlue[800],
                      fontSize: 24.0,
                    ),
                  ),
                ),

                // Display food received button
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
                          'Food Received',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                      onPressed: () {
                        OrderReceiptToFoodReview foodNameData =
                            new OrderReceiptToFoodReview(data.foodName);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FoodReview(data: foodNameData)),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
