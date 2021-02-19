import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sg_foodie/services/auth.dart';
import 'package:sg_foodie/shared/constants.dart';

class Me extends StatefulWidget {
  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3.0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.lightBlue[800],
            fontSize: 24.0,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('profile')
            .document('LNHzNCwMd0V0CgyxQmv9T5YvtA53')
            .snapshots(),
        builder: (context, snapshot) {
          DocumentSnapshot profileDoc = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // Display profile pic and edit profile pic icon
                  Stack(
                    children: <Widget>[
                      // Display profile pic
                      Container(
                        width: 220.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              NetworkImage(profileDoc['profilePic']),
                          backgroundColor: Colors.transparent,
                        ),
                      ),

                      // Display edit profile pic icon
                      Positioned(
                        top: 52.0,
                        left: 135.0,
                        child: ClipOval(
                          child: Container(
                            color: Colors.grey[200],
                            child: Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.redAccent,
                                  size: 35.0,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Display username text form field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      controller:
                          TextEditingController(text: profileDoc['username']),
                      style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      decoration: textInputDecoration.copyWith(
                        prefixIcon: Icon(
                          Icons.person_rounded,
                          color: Colors.redAccent,
                          size: 35.0,
                        ),
                        hintText: 'Username',
                        hintStyle:
                            TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      ),
                    ),
                  ),

                  // Display email text form field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      enabled: false,
                      controller:
                          TextEditingController(text: profileDoc['email']),
                      style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      decoration: textInputDecoration.copyWith(
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.redAccent,
                          size: 35.0,
                        ),
                        hintText: 'Email',
                        hintStyle:
                            TextStyle(color: Colors.grey[800], fontSize: 20.0),
                        disabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black26, width: 2.0),
                        ),
                      ),
                    ),
                  ),

                  // Display contact no text form field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      controller:
                          TextEditingController(text: profileDoc['contactNo']),
                      style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      decoration: textInputDecoration.copyWith(
                        prefixIcon: Icon(
                          Icons.phone_rounded,
                          color: Colors.redAccent,
                          size: 35.0,
                        ),
                        hintText: 'Contact No',
                        hintStyle:
                            TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      ),
                    ),
                  ),

                  // Display address text form field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: TextFormField(
                      controller:
                          TextEditingController(text: profileDoc['address']),
                      style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      decoration: textInputDecoration.copyWith(
                        prefixIcon: Icon(
                          Icons.home_rounded,
                          color: Colors.redAccent,
                          size: 35.0,
                        ),
                        hintText: 'Address',
                        hintStyle:
                            TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      ),
                    ),
                  ),

                  // Display save button
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
                            'Save',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                        onPressed: () async {}),
                  ),

                  // Display link that allows user to logout
                  Align(
                    alignment: Alignment.centerRight,
                    child: RawMaterialButton(
                      child: Text(
                        '   Logout',
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 20.0),
                      ),
                      onPressed: () async {
                        await _auth.signOut();
                      },
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
