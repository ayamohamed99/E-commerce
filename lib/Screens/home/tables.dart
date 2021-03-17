import 'package:ecommerce/Components/loading.dart';
// import 'package:ecommerce/Models/reservedtable.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
import 'package:ecommerce/Screens/home/home.dart';
import 'package:ecommerce/Screens/home/resForm.dart';
import 'package:ecommerce/Services/reservedTable.service.dart';
import 'package:ecommerce/Services/restaurant.Services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Tables extends StatefulWidget {
  Tables(this.rId);

  final String rId;

  @override
  _TablesState createState() => _TablesState(this.rId);
}

class _TablesState extends State<Tables> {
  String rId;
  var restaurantV;
  _TablesState(this.rId);
  RestaurantDetail restaurant;
  Color _icolor = Colors.black;

  void onChange() {
    setState(() {
      _icolor = Colors.green;
    });
  }

  RestaurantService resServ = new RestaurantService();
  ServiceReservedTable resTableServ = new ServiceReservedTable();
  dynamic resTables;
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
    _getResTables(rId);
    // _fechRestaurantData();
  }

  // List<RestaurantDetail> restaurantall;
  // // ignore: missing_return
  // Future<List<RestaurantDetail>> _fechRestaurantData() async {
  //   restaurantall = await resServ.fetchData();
  // }

  // ignore: non_constant_identifier_names
  Container _MyCard(num seats, num table) {
    // List<int> tables = [restaurantall[restaurantall.length].numTables.toInt()];
    return Container(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'number of seats :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('number of available tables :',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$seats',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$table',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < table.abs() && i < 4; i++)
                    IconButton(
                      icon: Icon(FontAwesomeIcons.chair),
                      iconSize: 70,
                      color: _icolor,
                      onPressed: () {
                        onChange();
                      },
                    ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RaisedButton(
                  child: Text('Next',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.green[500],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookForm(rId: this.rId)));
                  })
            ],
          )
        ],
      ),
    );
  }

  int counter = 0;
  Future<num> _getResTables(String resId) async {
    resTables = await resTableServ.fetchData();
    for (var resTable in resTables) {
      if (resTable.restaurantId == resId) {
        counter++;
        setState(() {
          availableTable = counter;
        });
        
      }
    }
    return counter;
  }
  num availableTable;

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
          color: Colors.green[500],
          child: Center(
              child: Text(
            restaurant.name,
            style: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 3,
            ),
          )),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.only(right: 150),
          child: FlatButton.icon(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              icon: Icon(
                Icons.home,
              ),
              label: Text(
                'Home',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.only(right: 35),
          child: Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                'Rate  ',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Card(
                child: SmoothStarRating(
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
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.only(right: 90),
          child: FlatButton.icon(
              onPressed: () {},
              icon: Icon(FontAwesomeIcons.utensils),
              label: Text(
                restaurant.categoryN,
                style: TextStyle(fontSize: 25),
              )),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          padding: EdgeInsets.only(right: 70),
          child: FlatButton.icon(
              onPressed: _showMyDialog,
              icon: Icon(FontAwesomeIcons.phoneAlt),
              label: Text(
                ' Contact us ',
                style: TextStyle(
                  fontSize: 25,
                ),
              )),
        ),
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
                  // restaurant.numSeats,
                  // restaurant.numTables - availableTable,
                  8,4
                ),
              ),
            ],
          )),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('HOTLINE'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'If you faced a problem and you need to contact with us Please Call  this number it is  an easy fast way to contact with us ' +
                      '\n\n' +
                      restaurant.hotline,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: Text('Close',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
