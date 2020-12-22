import 'package:ecommerce/Components/loading.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
import 'package:ecommerce/Screens/home/home.dart';
import 'package:ecommerce/Services/restaurant.Services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SecHome extends StatefulWidget {
  SecHome(this.rId);

  final String rId;

  @override
  _SecHomeState createState() => _SecHomeState(this.rId);
}

class _SecHomeState extends State<SecHome> {
  String rId;
  var restaurantV;
  _SecHomeState(this.rId);

  RestaurantDetail restaurant;
  RestaurantService resServ = new RestaurantService();
  // ignore: missing_return
  Future<RestaurantDetail> _fetchRestaurantData() async {
    restaurantV = await resServ.getById(this.rId);
    refresh();
  }

  void refresh() {
    setState(() {
      restaurant = restaurantV;
    });
  }

  // ignore: must_call_super
  void initState() {
    _fetchRestaurantData();
  }

  bool _visible = false;

  // ignore: non_constant_identifier_names
  Container _MyCard(String resImg, String resName, String resDesc,
      String resHeadline,String adress) {
    return Container(
        color: Colors.white,
        width: 150.0,
        child: Column(children: [
          Container(
            margin: EdgeInsets.all(20),
            height: 250,
            child: Image.asset(
              resImg,
              fit: BoxFit.fill,
            ),
          ),
          ListTile(
            onTap: () {
              setState(() {
                _visible = true;
              });
            },
            title: Text(resHeadline,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    height: 1.5,
                    fontStyle: FontStyle.italic)),
          ),
          Visibility(
            visible: _visible,
            child: ListTile(
              onTap: () {
                setState(() {
                  _visible = !_visible;
                });
              },
              subtitle: Text('read less',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.red[500],
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      fontStyle: FontStyle.italic)),
              title: Text(resDesc,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      height: 1.5,
                      fontStyle: FontStyle.italic)),
            ),
          ),
          RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Colors.green[500],
            onPressed: (){}, 
          child: Text('BOOK' , 
          style: TextStyle(fontWeight: FontWeight.bold,
          fontSize: 35,
          color: Colors.white),))
          
        ]));
  }

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) return Loading();
    return Scaffold(
      drawer: Drawer(
            child: Column(children: <Widget>[
          Container(
            width: double.infinity,
            height: 100,
            padding: EdgeInsets.all(8),
            color: Colors.green[700],
            child: Center(
                child: Text(
              restaurant.name,
              style: TextStyle(fontSize: 30),
            )),
          ),
          FlatButton.icon(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(Icons.home),
              label: Text(
                'Home',
                style: TextStyle(fontSize: 25),
              )),
              SizedBox(height: 30,),
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.phoneAlt),
              label: Text(
                ' Hotline  ' + restaurant.hotline,
                style: TextStyle(fontSize: 25),
              )),
              SizedBox(height: 30,),
           Row(
             children: [
               SizedBox(width: 70,),
               Text('Rate  ',
                style: TextStyle(fontSize: 25 , color: Colors.black,
                fontWeight: FontWeight.w500),),
               SmoothStarRating(
                    rating: restaurant.rate.toDouble(),
                    isReadOnly: true,
                    size: 20,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    color: Colors.yellow[900],
                    borderColor: Colors.yellow[900],
                    allowHalfRating: true,
                    spacing: 2.0,
                    onRated: null,
                  ),
             ],
           ),
            SizedBox(height: 30,),
          FlatButton.icon(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.utensils),
              label: Text(
                restaurant.categoryN,
                style: TextStyle(fontSize: 25),
              ))
        ])),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(restaurant.name),
        backgroundColor: Colors.green[400],
      ),
      body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                child: _MyCard(
                    restaurant.img,
                    restaurant.name,
                    restaurant.description,
                    restaurant.headline,
                    restaurant.location
                    ),
              ),
            ],
          )),
    );
  }
}
