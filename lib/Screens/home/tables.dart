
import 'package:ecommerce/Screens/home/resForm.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tables extends StatefulWidget {
  @override
  _TablesState createState() => _TablesState();
}

class _TablesState extends State<Tables> {
  Color _iconColor = Colors.black;
  Color _iconColor1 = Colors.black;
  Color _iconColor2 = Colors.black;


  void onChange() {
    setState(() {
      _iconColor = Colors.green[700];
    });
  }

  void onChange1() {
    setState(() {
      _iconColor1 = Colors.green[700];
    });
  }

void onChange2() {
    setState(() {
      _iconColor2 = Colors.green[700];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: Text('Table Booking'),
        ),
        body: new Container(
          padding: EdgeInsets.fromLTRB(70,20,70,10),
          child: new Column(children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                
                SizedBox(width: 50),
                IconButton(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 80),
                  icon: Icon(
                    FontAwesomeIcons.chair,
                    color: _iconColor,
                    size: 100,
                  ),
                  onPressed: onChange,
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 50),
                    IconButton(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 80),
                      icon: Icon(
                        FontAwesomeIcons.chair,
                        color: _iconColor,
                        size: 100,
                      ),
                      onPressed: onChange,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            new Column(children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  
                  SizedBox(width: 50),
                  IconButton(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 80),
                    icon: Icon(
                      FontAwesomeIcons.chair,
                      color: _iconColor1,
                      size: 100,
                    ),
                    onPressed: onChange1,
                  ),
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 50),
                        IconButton(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 80),
                          icon: Icon(
                            FontAwesomeIcons.chair,
                            color: _iconColor1,
                            size: 100,
                          ),
                          onPressed: onChange1,
                        ),
                      ]),
                ],
              ),
              SizedBox(height: 25,),
               new Column(
                
                 children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 
                  SizedBox(width: 50),
                  IconButton(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 80),
                    icon: Icon(
                      FontAwesomeIcons.chair,
                      color: _iconColor2,
                      size: 100,
                    ),
                    onPressed: onChange2,
                  ),
                  new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 50),
                        IconButton(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 80),
                          icon: Icon(
                            FontAwesomeIcons.chair,
                            color: _iconColor2,
                            size: 100,
                          ),
                          onPressed: onChange2,
                        ),
                      ]), 
                ]),
                SizedBox(height: 25,),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.green,
                  onPressed: () {
                     Navigator.push(
                    context, MaterialPageRoute(builder: (context) => BookForm()));
                  },
                  child: Text(
                    'Book',
                    style: TextStyle(fontSize: 30,
                    color: Colors.white),
                  ),
                ),
               ]),
            ]),
          ]),
        ));
  }
}
