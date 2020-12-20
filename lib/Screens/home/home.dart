import 'package:ecommerce/Models/categoryDetail.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
import 'package:ecommerce/Services/category.Services.dart';
import 'package:ecommerce/Services/restaurant.Services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final AuthService _auth = AuthService();

  
    List<CategoryDetail> category;

  CategoryService catServ = new CategoryService();
  // ignore: missing_return
  Future<List<CategoryDetail>> _fechCategoryData() async {
    category = await catServ.fetchData();
  }

   // ignore: must_call_super
   void initState() {
    _fechCategoryData();
        _fechRestaurantData();

  }

  
  bool _visible = false;

  Widget dropdownlist(int index){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left:240.0),
        child: FlatButton(onPressed: (){},
        child: Text(category[category.length - index - 1].categoryName,
        style: TextStyle(fontSize: 20)),),
      ),
    );
  }


  List<RestaurantDetail> restaurant;
  List<RestaurantDetail> resSort;


  RestaurantService resServ = new RestaurantService();

  // ignore: missing_return
  

  // ignore: missing_return
  Future<List<RestaurantDetail>> _fechRestaurantData() async {
    restaurant = await resServ.fetchData();
    resSort = await resServ.fetchData();
  }

  // ignore: must_call_super
  int k = 0;
  // ignore: missing_return
  Widget _bBuildCard() {
    // ignore: unnecessary_statements
    for (k; k < restaurant.length; k++) {
      return card(k);
    }
  }
  Widget card(int k) {
    return Container(
      color: Colors.white70,
      child: Card(
        shadowColor: Colors.green[900],
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.asset(
                restaurant[k].img,
                fit: BoxFit.fill,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 10),
                  child: Text(restaurant[k].name,
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SmoothStarRating(
                    rating: restaurant[k].rate.toDouble(),
                    isReadOnly: false,
                    size: 25,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    color: Colors.yellow[900],
                    borderColor: Colors.yellow[900],
                    starCount: 5,
                    allowHalfRating: true,
                    spacing: 0.0,
                    onRated: null,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    // if (restaurant == null) return Loading();
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text('E-Commerce Project'),
        backgroundColor: Colors.green[400],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             Row(
                children: [

                  Padding(
                    padding: const EdgeInsets.only(left:10.0),
                    child: Icon(
                      FontAwesomeIcons.utensils,
                      size: 25,
                      color: Colors.amber[600],
                    ),
                  ),
                  Text(
                    ' Our Restaurant',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.green[400],
                        fontStyle: FontStyle.italic),
                  ),
                  Spacer(),
     FlatButton.icon(onPressed: (){
                               setState(() {
                                  _visible = !_visible;
                                });
                            }, 
                            icon: Icon(Icons.list ,size: 30,),
                             label: Text('Categories' ,style: TextStyle(fontSize: 20),)),
                ],
              ),
            Visibility(
              visible: _visible,
              child: Row(
                children: [
                  Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: category.length,
                      itemBuilder: (BuildContext context, int index) =>
                          dropdownlist(index)),
                ),
                ] 
              ),
            ),
            Expanded(
                child: ListView(children: <Widget>[
              for (k = 0; k < restaurant.length; k++) _bBuildCard()
            ]))
            
          ],
        ),
      ),
    );
  }
}
