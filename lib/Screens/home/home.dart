import 'package:ecommerce/Components/loading.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
import 'package:ecommerce/Services/restaurant.Services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final AuthService _auth = AuthService();

  List<RestaurantDetail> restaurant;
  List<RestaurantDetail> resSort;

  RestaurantService resServ = new RestaurantService();

  // ignore: missing_return
  Future<List<RestaurantDetail>> _fechRestaurantData() async {
    restaurant = await resServ.fetchData();
    resSort = await resServ.fetchData();
  }

  // ignore: must_call_super
  void initState() {
    _fechRestaurantData();
  }

  Widget card(int index) {
    return Container(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Image.asset(restaurant[restaurant.length - index - 1].img,
            
              fit: BoxFit.fill,
              width: 300,
              height: 150,
            ),
          ),
          ListTile(
            title: Text(restaurant[restaurant.length - index - 1].name,
                style: TextStyle(fontSize: 20.0)),
          ),
          Row(
            children: [
               Padding(
                 padding: const EdgeInsets.only(left:25.0),
                 child: Text(restaurant[restaurant.length - index - 1].location,
                  style: TextStyle(fontSize: 20.0,
                  color: Colors.black54)),
               ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SmoothStarRating(
                  rating: restaurant[index].rate.toDouble(),
                  
                  isReadOnly: false,
                  size: 25,
                  filledIconData: Icons.star,
                  halfFilledIconData: Icons.star_half,
                  defaultIconData: Icons.star_border,
                  starCount: 5,
                  allowHalfRating: true,
                  spacing: 0.0,
                  onRated: null,
                  
                ),
              )
            ],
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) return Loading();
    return Scaffold(
      // resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('E-Commerce Project'),
        backgroundColor: Colors.green[400],
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.refresh),
            label: Text('Refresh'),
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Row(
                children: [
                  Container(
                    color: Colors.green[300],
                    height: 50,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                      child: Text(
                        "Sort by",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green[300],
                    height: 50,
                    width: 130,
                    child: FlatButton(
                      color: Colors.green[400],
                      onPressed: () {
                        setState(() {
                          restaurant.sort((a, b) => b.name.compareTo(a.name));
                        });
                      },
                      textColor: Colors.white,
                      child: Text(
                        'Name',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green[300],
                    height: 50,
                    width: 130,
                    child: FlatButton(
                      color: Colors.green[500],
                      onPressed: () {
                        setState(() {
                          restaurant.sort((a , b) => b.rId.compareTo(a.rId));
                        });
                      },
                      textColor: Colors.white,
                      child: Text(
                        'Rate',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.hamburger,
                    size: 30,
                    color: Colors.amber[600],
                  ),
                  Text(
                    '  Our Restaurant',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.green[400],
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: restaurant.length,
                itemBuilder: (BuildContext contex, int index) => card(index),
              ),
            )
          ],
        ),
      ),
    );
  }
}
