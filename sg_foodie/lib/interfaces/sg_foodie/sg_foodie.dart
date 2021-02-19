import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class SGFoodie extends StatefulWidget {
  @override
  _SGFoodieState createState() => _SGFoodieState();
}

class _SGFoodieState extends State<SGFoodie> {
  void _launchCaller(int number) async {
    var url = 'tel:${number.toString()}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Sorry, cannot place call.';
    }
  }

  void _launchEmail(String emailId) async {
    var url = 'mailto:$emailId?subject=Hello SG Foodie!';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Sorry, cannot send email.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3.0,
        title: Text(
          'About Us',
          style: TextStyle(
            color: Colors.lightBlue[800],
            fontSize: 24.0,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('sgFoodie')
            .document('cSKqaQh7LoAFadI7kHgv')
            .snapshots(),
        builder: (context, snapshot) {
          DocumentSnapshot sgFoodieDoc = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Display SG Foodie logo
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Icon(
                        Icons.ramen_dining,
                        color: Colors.redAccent,
                        size: 100.0,
                      ),
                    ),
                  ),

                  // Display the application info header
                  Text(
                    'Application Info',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),

                  // Display the application info description
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      sgFoodieDoc['applicationInfo'],
                      style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Display divider
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Divider(
                      color: Colors.red[100],
                      indent: 30.0,
                      endIndent: 30.0,
                      thickness: 2.0,
                    ),
                  ),

                  // Display the company info header
                  Text(
                    'Company Info',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),

                  // Display the company info description
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      sgFoodieDoc['companyInfo'],
                      style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Display divider
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Divider(
                      color: Colors.red[100],
                      indent: 30.0,
                      endIndent: 30.0,
                      thickness: 2.0,
                    ),
                  ),

                  // Display the contact no header
                  Text(
                    'Contact No',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),

                  // Display the contact no description
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: RawMaterialButton(
                      child: Text(
                        sgFoodieDoc['contactNo'],
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      ),
                      onPressed: () {
                        _launchCaller(65509872);
                      },
                    ),
                  ),

                  // Display divider
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Divider(
                      color: Colors.red[100],
                      indent: 30.0,
                      endIndent: 30.0,
                      thickness: 2.0,
                    ),
                  ),

                  // Display the email header
                  Text(
                    'Email',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),

                  // Display the email description
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: RawMaterialButton(
                      child: Text(
                        sgFoodieDoc['email'],
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      ),
                      onPressed: () {
                        _launchEmail(sgFoodieDoc['email']);
                      },
                    ),
                  ),

                  // Display divider
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Divider(
                      color: Colors.red[100],
                      indent: 30.0,
                      endIndent: 30.0,
                      thickness: 2.0,
                    ),
                  ),

                  // Display the developer info header
                  Text(
                    'Developer Info',
                    style:
                        TextStyle(color: Colors.lightBlue[800], fontSize: 24.0),
                    textAlign: TextAlign.center,
                  ),

                  // Display the developer info description
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      sgFoodieDoc['developerInfo'],
                      style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
