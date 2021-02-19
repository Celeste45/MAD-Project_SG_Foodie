import 'package:flutter/material.dart';
import 'package:sg_foodie/services/auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sg_foodie/shared/constants.dart';
import 'package:sg_foodie/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 3.0,
              title: Text(
                'Register',
                style: TextStyle(
                  color: Colors.lightBlue[800],
                  fontSize: 24.0,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // Display SG Foodie logo
                      Center(
                        child: Icon(
                          Icons.ramen_dining,
                          color: Colors.redAccent,
                          size: 100.0,
                        ),
                      ),

                      // Display email text form field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 20.0),
                            decoration: textInputDecoration.copyWith(
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.redAccent,
                                  size: 35.0,
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    color: Colors.grey[800], fontSize: 20.0),
                                errorStyle: TextStyle(
                                    color: Colors.red[600], fontSize: 20.0),
                                errorMaxLines: 2),
                            validator: (val) => EmailValidator.validate(val)
                                ? null
                                : 'Please enter a working email address.',
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                      ),

                      // Display password text form field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: TextFormField(
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 20.0),
                            decoration: textInputDecoration.copyWith(
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.redAccent,
                                  size: 35.0,
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: Colors.grey[800], fontSize: 20.0),
                                errorStyle: TextStyle(
                                    color: Colors.red[600], fontSize: 20.0),
                                errorMaxLines: 2),
                            obscureText: true,
                            validator: (val) => val.length < 10
                                ? 'Please enter a strong password with at least 10 characters long.'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            }),
                      ),

                      // Display link that navigate to Login page
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RawMaterialButton(
                          child: Text(
                            'Have account?',
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 20.0),
                          ),
                          onPressed: () => widget.toggleView(),
                        ),
                      ),

                      // Display failed registration error message
                      Text(
                        error,
                        style:
                            TextStyle(color: Colors.red[600], fontSize: 20.0),
                      ),

                      // Display register button
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
                                'Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        'A user with this email address already exists. Use a different email address.';
                                  });
                                }
                              }
                            }),
                      ),

                      // Display link that allows user to login anonymously
                      Align(
                        alignment: Alignment.centerRight,
                        child: RawMaterialButton(
                          child: Text(
                            '          Skip',
                            style: TextStyle(
                                color: Colors.grey[800], fontSize: 20.0),
                          ),
                          onPressed: () async {
                            setState(() => loading = true);
                            dynamic result = await _auth.signInAnon();
                            if (result == null) {
                              setState(() => loading = false);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
