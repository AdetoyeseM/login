import 'package:flutter/material.dart';
import 'package:net9ja/model/user.dart';
import 'package:net9ja/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

import 'home/home.dart'; 

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


final user  = Provider.of<User>(context);

 if (user == null)
 {
   return Authenticate();

 }
 else{
   return Home();
 }
       
    
  }
}