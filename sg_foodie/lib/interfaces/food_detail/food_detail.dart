import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sg_foodie/interfaces/food_menu/food_menu.dart';

class FoodDetail extends StatefulWidget {
  // Hold the items data passed into food menu page
  final FoodMenuToFoodDetail data;

  // Create a constructor for the food detail page with data parameter
  FoodDetail({Key key, @required this.data}) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState(data);
}

class _FoodDetailState extends State<FoodDetail> {
  // Hold the food name data passed into cart page
  final FoodMenuToFoodDetail data;

  // Create a constructor for the food menu page with data parameter
  _FoodDetailState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3.0,
        title: Text(
          'Food Detail',
          style: TextStyle(
            color: Colors.lightBlue[800],
            fontSize: 24.0,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('foodRatingReview')
            .where('foodName', isEqualTo: 'Plain Prata')
            .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot foodRatingReviewDoc =
                  snapshot.data.documents[index];
              return SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child:
                      // Display stalls list
                      SizedBox.fromSize(
                    child: Container(
                        height: 130.0,
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
                            ]),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                // Display profile pic
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 25.0, horizontal: 15.0),
                                  child: Container(
                                    width: 90.0,
                                    height: 80.0,
                                    child: Image.network(
                                      foodRatingReviewDoc['profilePic'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                // Display username, food rating and review
                                Container(
                                  width: 120.0,
                                  height: 80.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      // Display username
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          foodRatingReviewDoc['username'],
                                          style: TextStyle(
                                              color: Colors.lightBlue[800],
                                              fontSize: 20.0),
                                        ),
                                      ),

                                      // Display food rating
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

                                      // Display food review
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          foodRatingReviewDoc['foodReview'],
                                          style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              );
            },
          );
        },
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      //     child: Column(
      //       children: <Widget>[],
      //     ),
      //   ),
      // ),
    );
  }
}
