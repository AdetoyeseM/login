import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:net9ja/animation/fadeanimation.dart'; 
import 'package:net9ja/loading.dart'; 
import 'package:net9ja/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //textField State

  String email = ' ';
  String password = '';
  String name = '';
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
            'Sign Up',
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
                child: FadeAnimation( 1.1,
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
                      FadeAnimation(1.1,
                                               TextFormField( 
                            validator: (val) =>
                                val.isEmpty ? 'Enter Your Full name' : null,
                            style: TextStyle(
                              
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.black),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person, color: Colors.black),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black),
                                labelText: 'FULL NAME',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black))),
                            onChanged: (val) {
                              setState(() => name = val);
                            }),
                      ),
                      SizedBox(height: 20),
                      FadeAnimation(1.2,
                                                TextFormField(
                          validator: (val) =>
                              val.isEmpty ? 'Enter A valid Email Address' : null,
                          onChanged: (val) {
                            setState(() => email = val);
                          },
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
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation( 1.3,
                                         TextFormField(
                          maxLength: 12,
                            validator: (val) => val.length < 6
                                ? 'Enter a Password 6+ chars long'
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
                                prefixIcon: Icon(Icons.lock, color: Colors.black),
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.black),
                                labelText: 'PASSWORD',
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black)),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black))),
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
                            setState(() => loading = true );
                             dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                        if (result == null)
                        {
                              setState(() { error = 'Invalid Email or Password';
                              loading = false;
                               } );
                        }
                           
                        
                         }
                        },
          child: FadeAnimation(1.4,
                        Container(
              height: 40, 
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:  Color(0xff12131B),
              ),
              child: Center(
                child: Text("Sign Up",
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
                      
                      Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),

                      SizedBox(height: 3),
                      FadeAnimation(1.5,
                         Text("-  O R  -", style: TextStyle(color: Colors.black))),
                     SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          widget.toggleView();
                        }, 

                        child: FadeAnimation( 1.6,
                                                    RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Already Have an Account?",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'nt'),
                              ),
                              TextSpan(
                                text: " SIGN IN ",
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
