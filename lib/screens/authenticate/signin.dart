import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:net9ja/animation/fadeanimation.dart'; 
import 'package:net9ja/loading.dart';
import 'package:net9ja/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscureText = true;
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //textField State

  String email = ' ';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Loading();
    } else {
      return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 10.0,
              title: Text(
                'Sign In',
                style: TextStyle(color: Colors.black, letterSpacing: 2.0, fontFamily: 'time'),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FadeAnimation(1.1,
                                           Container(
                        height: 150,
                        width: 400,
                        child: Lottie.asset('assets/images/log.json'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                           FadeAnimation(1.2,
                                                       TextFormField(
                                validator: (val) => val.isEmpty
                                    ? 'Enter a Valid Email Address'
                                    : null,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    prefixIcon:
                                        Icon(Icons.mail, color: Colors.black),
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.black),
                                    labelText: 'EMAIL ADDRESS',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                onChanged: (val) {
                                  setState(() => email = val);
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                           FadeAnimation(1.3,
                                                      TextFormField(
                                maxLength: 12,
                                validator: (val) => val.length < 6
                                    ? 'Password must be greater than six'
                                    : null,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                                decoration: InputDecoration(
                                    suffixIcon: new GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        child: new Icon(
                                          _obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,
                                        )),
                                    prefixIcon:
                                        Icon(Icons.lock, color: Colors.black),
                                    labelStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.black),
                                    labelText: 'PASSWORD',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                obscureText: _obscureText,
                                onChanged: (val) {
                                  setState(() => password = val);
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                             GestureDetector(
          onTap: () async { 
            if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result = await _authService
                                    .signInWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Wrong Credentials';
                                    loading = false;
                                  });
                                }
                              }
                        },
          child:  FadeAnimation(1.4,
                        Container(
              alignment: Alignment.center,
              height: 40, 
              margin: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:  Color(0xff12131B),
              ),
              child: Center(
                child: Text("Sign In",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
                          
                          SizedBox(height: 4),
                          Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 14.0),
                          ),
                          SizedBox(height: 3),
                           FadeAnimation(1.5,
                                                       Text("-  O R  -",
                                style: TextStyle(color: Colors.black)),
                          ),
                              SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child:  FadeAnimation(1.6,
                                                       RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: "Dont Have an Account?",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'nt'),
                                  ),
                                  TextSpan(
                                    text: " SIGN UP ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 2,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ));
    }
  }
}
