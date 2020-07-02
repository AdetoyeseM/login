import 'package:flutter/material.dart';
import 'package:net9ja/model/user.dart';
import 'package:net9ja/screens/wrapper.dart';
import 'package:net9ja/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   StreamProvider<User>.value(
            value: AuthService().user, 
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Login',
              home: Wrapper()));
  }
}
