import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sg_foodie/interfaces/food_menu/food_menu.dart';
import 'package:sg_foodie/interfaces/home/home.dart';

// Store stall name data to pass to food menu page
class StallToFoodMenu {
  final String stallName;
  StallToFoodMenu(this.stallName);
}

class Stall extends StatefulWidget {
  // Hold the hawker centre name data passed into stall page
  final HomeToStall data;

  // Create a constructor for the stall page with data parameter
  Stall({Key key, @required this.data}) : super(key: key);

  @override
  _StallState createState() => _StallState(data);
}

class _StallState extends State<Stall> {
  // Hold the hawker centre name data passed into stall page
  final HomeToStall data;

  // Create a constructor for the stall page with data parameter
  _StallState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3.0,
        title: Text(
          'Stall',
          style: TextStyle(
            color: Colors.lightBlue[800],
            fontSize: 24.0,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('stall')
            .where('hawkerCentreName', isEqualTo: data.hawkerCentreName)
            .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot stallDoc = snapshot.data.documents[index];
              return SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child:
                      // Display stalls list
                      Container(
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
                    child: ListTile(
                      // Display stall image
                      leading: Container(
                        width: 90.0,
                        child: Image.network(
                          stallDoc['stallImage'],
                          fit: BoxFit.cover,
                        ),
                      ),

                      // Display hawker centre name
                      title: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(
                          stallDoc['hawkerCentreName'],
                          style: TextStyle(
                              color: Colors.lightBlue[800], fontSize: 20.0),
                        ),
                      ),

                      // Display stall name
                      subtitle: Text(
                        stallDoc['stallName'],
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      ),

                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 15.0),
                      onTap: () {
                        StallToFoodMenu data =
                            new StallToFoodMenu(stallDoc['stallName']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodMenu(data: data)),
                        );
                      },
                    ),
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
