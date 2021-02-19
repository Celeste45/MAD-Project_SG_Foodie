import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sg_foodie/interfaces/order_receipt/order_receipt.dart';
import 'package:sg_foodie/interfaces/thank_you/thank_you.dart';
import 'package:sg_foodie/shared/constants.dart';

class FoodReview extends StatefulWidget {
  // Hold the food name data passed into order receipt page
  final OrderReceiptToFoodReview data;

  // Create a constructor for the order receipt page with data parameter
  FoodReview({Key key, @required this.data}) : super(key: key);

  @override
  _FoodReviewState createState() => _FoodReviewState(data);
}

class _FoodReviewState extends State<FoodReview> {
  // Hold the food name data passed into order receipt page
  final OrderReceiptToFoodReview data;

  // Create a constructor for the order receipt page with data parameter
  _FoodReviewState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3.0,
        title: Text(
          'Food Review',
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
                  DocumentSnapshot foodReviewDoc =
                      snapshot.data.documents[index];
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 30.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              foodReviewDoc['stallName'],
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 20.0,
                              ),
                            ),
                          ),

                          Text(
                            foodReviewDoc['foodName'],
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 20.0,
                            ),
                          ),

                          // Food Rating
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                          ),

                          // Food Review form field
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: TextFormField(
                              controller:
                                  TextEditingController(text: 'Delicious!'),
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 20.0),
                              decoration: textInputDecoration.copyWith(
                                prefixIcon: Icon(
                                  Icons.ramen_dining,
                                  color: Colors.redAccent,
                                  size: 35.0,
                                ),
                                hintText: 'Food Review',
                                hintStyle: TextStyle(
                                    color: Colors.grey[800], fontSize: 20.0),
                              ),
                            ),
                          ),

                          //Submit button
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
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ThankYou()),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
