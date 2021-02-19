import 'package:flutter/material.dart';
import 'package:sg_foodie/interfaces/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:sg_foodie/services/auth.dart';
import 'package:sg_foodie/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
