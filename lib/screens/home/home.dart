import 'package:flutter/material.dart';
import 'package:net9ja/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 10.0,
          title: Text('Welcome', style:TextStyle(color: Colors.black, letterSpacing: 2.0) 
          ),
          
          actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.person_outline, color: Colors.black),
                  label: Text('\nLogout', style: TextStyle(color: Colors.black, letterSpacing: 3.0, fontSize: 10)),
                  onPressed: () async
                  {
                  await _authService.signOut();

                  },
              )

          ],
      ),
    );
  }
}