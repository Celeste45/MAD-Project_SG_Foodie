import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sg_foodie/interfaces/authenticate/authenticate.dart';
import 'package:sg_foodie/interfaces/navigation/navigation.dart';
import 'package:sg_foodie/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // Return either Authenticate or Navigation widget
    if (user == null) {
      return Authenticate();
    } else {
      return Navigation();
    }
  }
}
