import 'package:ecommerce/Services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.green[400],
          elevation: 0.0,
          title: Text('Welcome Page'),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Sign In'),
                onPressed: () {
                  widget.toggleView();
                }),
          ]),
      body: Container(
          padding: const EdgeInsets.all(32.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Ender an Email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                                    validator: (val) => val.length < 6 ? 'Password must be more than 6 letters' : null ,

                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                      color: Colors.green[500],
                      child: Text('Sign in',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      onPressed: () async {
                         if(_formKey.currentState.validate()){
                    dynamic result = await _auth.sigInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() => error = 'Invalid email or password ');
                    }
                  }
                      }),
                      SizedBox(height: 20.0,),
                Text(error,
                style: TextStyle(color: Colors.red),),

                ],
              ))),
    );
  }
}
