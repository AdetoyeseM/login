import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:net9ja/animation/fadeanimation.dart';
import 'package:net9ja/loading.dart';
import 'package:net9ja/services/auth.dart';

import 'authenticate/signin.dart';

class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  bool _iSInternet = true;
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //textField State

  String email = ' ';
  String password = '';
  String error = '';

  checkInternet() async {
    try {
      final response = await InternetAddress.lookup('google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        _iSInternet = true;
        setState(() {});
      }
    } on SocketException catch (_) {
      _iSInternet = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10.0,
        title: Text(
          'Reset Password',
          style: TextStyle(
              color: Colors.black, letterSpacing: 1.0, fontFamily: 'time'),
        ),
        leading: GestureDetector(
          onTap: ()
          {
            Navigator.pop(context);
          },
                  child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
        ),
             
      ),
      body: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container( 
                  color: Colors.white,
                  child: Text(
                    'To reset your password, \nplease enter your email address',
                    style: TextStyle(color: Colors.black, fontSize:  25, fontFamily: 'time',letterSpacing: 3.0, fontStyle: FontStyle.normal),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      FadeAnimation(
                        1.2,
                        TextFormField(
                            validator: (val) => val.isEmpty
                                ? 'Enter a Valid Email Address'
                                : null,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.mail, color: Colors.black),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black),
                                labelText: 'EMAIL ADDRESS',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black))),
                            onChanged: (val) {
                              setState(() => email = val);
                            }),
                      ),
                      SizedBox(height: 20),
                      FadeAnimation(
                        1.4,
                        GestureDetector(
                          onTap: () async { 
                            checkInternet();
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              await _authService.sendPasswordReset(email);
                              loading = true;
                              _showPasswordEmailSentDialog();
                              if (_iSInternet == false) {
                                setState(() {
                                  error = 'Check Your Internet Connection';
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xff12131B),
                            ),
                            child: Center(
                              child: Text("Send",
                                  style: TextStyle(
                                      color: Colors.white,
                                      letterSpacing: 2,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void _showPasswordEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return CupertinoAlertDialog(
          title: new Text("Forgot your password"),
          content: new Text("\nAn Email has been sent to reset your password"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {  
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));              
              },
            ),
          ],
        );
      },
    );
  }
}
