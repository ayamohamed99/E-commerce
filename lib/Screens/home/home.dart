import 'package:ecommerce/Services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget{

    final AuthService _auth = AuthService(); 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.green[400],
       elevation: 0.0,
       title: Text('Home '),
       actions: <Widget>[
         FlatButton.icon(
           icon: Icon(Icons.person),
           label: Text('Logout'),
           onPressed: () async {
             await _auth.signOut();
           },
            )
       ],
     ),
     
   );
  }
}