import 'package:flutter/material.dart';
import 'package:sg_foodie/interfaces/food_detail/food_detail.dart';
import 'package:sg_foodie/interfaces/stall/stall.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sg_foodie/interfaces/cart/cart.dart';

// Store items and food name data to pass to cart page
class FoodMenuToCart {
  int items;
  final String foodName;
  FoodMenuToCart(this.items, this.foodName);
}

// Store food name data to pass to food detail page
class FoodMenuToFoodDetail {
  final String foodName;
  FoodMenuToFoodDetail(this.foodName);
}

class FoodMenu extends StatefulWidget {
  // Hold the stall name data passed into food menu page
  final StallToFoodMenu data;

  // Create a constructor for the food menu page with data parameter
  FoodMenu({Key key, @required this.data}) : super(key: key);

  @override
  _FoodMenuState createState() => _FoodMenuState(data);
}

class _FoodMenuState extends State<FoodMenu> {
  // Hold the stall name data passed into food menu page
  final StallToFoodMenu data;

  // Create a constructor for the food menu page with data parameter
  _FoodMenuState(this.data);

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3.0,
        title: Text(
          'Food Menu',
          style: TextStyle(
            color: Colors.lightBlue[800],
            fontSize: 24.0,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('foodMenu')
            .where('stallName', isEqualTo: data.stallName)
            .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot foodMenuDoc = snapshot.data.documents[index];
              return SingleChildScrollView(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                    child: SizedBox.fromSize(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      foodMenuDoc['foodImage'],
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
                                          foodMenuDoc['foodName'],
                                          style: TextStyle(
                                              color: Colors.lightBlue[800],
                                              fontSize: 20.0),
                                        ),
                                      ),

                                      // Display food description
                                      Text(
                                        foodMenuDoc['foodDescription'],
                                        style: TextStyle(
                                            color: Colors.grey[800],
                                            fontSize: 20.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      // Display avg food rating
                                      Row(
                                        children: <Widget>[
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            icon: Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              FoodMenuToFoodDetail data =
                                                  new FoodMenuToFoodDetail(
                                                      foodMenuDoc['foodName']);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FoodDetail(data: data)),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            icon: Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              FoodMenuToFoodDetail data =
                                                  new FoodMenuToFoodDetail(
                                                      foodMenuDoc['foodName']);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FoodDetail(data: data)),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            icon: Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              FoodMenuToFoodDetail data =
                                                  new FoodMenuToFoodDetail(
                                                      foodMenuDoc['foodName']);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FoodDetail(data: data)),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            icon: Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              FoodMenuToFoodDetail data =
                                                  new FoodMenuToFoodDetail(
                                                      foodMenuDoc['foodName']);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FoodDetail(data: data)),
                                              );
                                            },
                                          ),
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            icon: Icon(
                                              Icons.star_rounded,
                                              color: Colors.redAccent,
                                            ),
                                            onPressed: () {
                                              FoodMenuToFoodDetail data =
                                                  new FoodMenuToFoodDetail(
                                                      foodMenuDoc['foodName']);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FoodDetail(data: data)),
                                              );
                                            },
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
                                              foodMenuDoc['foodPrice'],
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
                                                  constraints: BoxConstraints(),
                                                  icon: Icon(
                                                    Icons.remove_rounded,
                                                    color: Colors.redAccent,
                                                  ),
                                                  onPressed: () {
                                                    if (counter > 0) {
                                                      setState(() => --counter);
                                                    }
                                                    FoodMenuToCart data =
                                                        new FoodMenuToCart(
                                                            counter,
                                                            foodMenuDoc[
                                                                'foodName']);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Cart(data: data)),
                                                    );
                                                  },
                                                ),

                                                // Display number of items
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: Text(
                                                    '$counter',
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontSize: 16.0),
                                                  ),
                                                ),

                                                // Display add icon
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  constraints: BoxConstraints(),
                                                  icon: Icon(
                                                    Icons.add_rounded,
                                                    color: Colors.redAccent,
                                                  ),
                                                  onPressed: () {
                                                    setState(() => ++counter);
                                                    FoodMenuToCart data =
                                                        new FoodMenuToCart(
                                                            counter,
                                                            foodMenuDoc[
                                                                'foodName']);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Cart(data: data)),
                                                    );
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
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
