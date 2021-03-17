import 'package:ecommerce/Models/ReservedTable.dart';
import 'package:ecommerce/Models/restaurantDetail.dart';
// import 'package:ecommerce/Screens/home/tables.dart';
import 'package:ecommerce/Services/reservedTable.service.dart';
import 'package:ecommerce/Services/restaurant.Services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'home.dart';

class BookForm extends StatefulWidget {
  final int initNumber;

  final Function(int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;

  BookForm({
    this.rId,
    this.initNumber,
    this.counterCallback,
    this.increaseCallback,
    this.decreaseCallback,
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  final String rId;
  @override
  _BookFormState createState() => _BookFormState(rId);
}

class _BookFormState extends State<BookForm> {
  // ReservedTable resTable = new ReservedTable();
  ServiceReservedTable servResTable = new ServiceReservedTable();
  num _tableNum = 2;
  num _chairNum = 1;
  String _time = '';
  String _date = '';
  String _resTableId = '';
  ReservedTable getResTable() {
    return new ReservedTable(
        tableNum: _tableNum,
        chairNum: _chairNum,
        restaurantId: restaurant.rId,
        date: _date,
        time: _time,
        resTableId: _resTableId);
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date = selectedDate.toString();
      });
  }

  int _currentCount;
  Function _counterCallback;
  Function _increaseCallback;
  Function _decreaseCallback;
  dynamic checker;
  @override
  void initState() {
    _currentCount = widget.initNumber ?? 1;
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
    super.initState();
    //  _fetchRestaurantData();
    _getRestaurantData();
  }

  Future<void> _getRestaurantData() async {
    //  setState(() async{
    //   restaurant = await resServ.getById(this.rId);
    // });
    resServ.getById(rId).then((value) => {
          if (value != null)
            {
              this.setState(() {
                restaurant = value;
              })
            }
        });
  }

  ServiceReservedTable resTableServ = new ServiceReservedTable();
  dynamic resTables;
  
  // ignore: missing_return
  Future<bool> _checkValidTime(String resId) async {
    resTables = await resTableServ.fetchData();
    for (var resTable in resTables) {
      if (resTable.time == _time && resTable.date == _date)
        return true;
      else
        return false;
    }
  }

  _validationTime() async {
    // setState(() {
    checker = await _checkValidTime(rId);
    // });
  }

  String rId;
  var restaurantV;
  _BookFormState(this.rId);
  RestaurantDetail restaurant;

  RestaurantService resServ = new RestaurantService();
  // ignore: missing_return
  // Future<RestaurantDetail> _fetchRestaurantData() async {
  //   restaurantV = await resServ.getById(this.rId);
  //   refresh();
  // }

  // void refresh() {
  //   setState(() {
  //     restaurant = restaurantV;
  //   });
  // }

  // ignore: must_call_super
  // static const Color timeColor = Colors.blueGrey;
  static const Color resTimeColor = Colors.blueGrey;
  static const Color notResTimeColor = Colors.green;
  bool resTimeFlage = false;

  List<bool> testFlag = [false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home, size: 35,),
        backgroundColor: Colors.green,
        onPressed: 
         () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
        ),
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(restaurant.name),
          backgroundColor: Colors.green[400],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          height: 430,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text('Amount of Guests', style: TextStyle(fontSize: 25)),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _createIncrementDicrementButton(
                        Icons.remove, () => _dicrement()),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      _currentCount.toString(),
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    _createIncrementDicrementButton(
                        Icons.add, () => _increment()),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text('Reservation Date', style: TextStyle(fontSize: 25)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          _selectDate(context);
                          // _date = _selectDate(context).toString();
                        });
                      },
                      child: Text('Select date'),
                    ),
                    SizedBox(
                      height: 20.0,
                      width: 20,
                    ),
                    Text(
                      "${selectedDate.toLocal()}".split(' ')[0],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Text('Available Time Slots', style: TextStyle(fontSize: 25)),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Expanded(
                    child: ListView.builder(
                      itemCount: restaurant.timeRes.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              testFlag[index] = !testFlag[index];
                              print(testFlag[index]);
                              _time = restaurant.timeRes[index].toString();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: testFlag[index]
                                  ? resTimeColor
                                  : notResTimeColor,
                              border: Border.all(
                                color: Colors.black,
                                // width: 0,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              restaurant.timeRes[index].toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            ),
                          ),
                          // leading: Color(value)
                        );
                        // );
                      },
                      padding: const EdgeInsets.all(16),
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.green,
                  onPressed: () {
                    _validationTime();
                    if (checker) {
                      _showMyDialog();
                      setState(() {
                        testFlag = [false, false , false];
                        _time = '';
                      });
                    } else {
                      servResTable
                          .addRestable(getResTable())
                          .then((value) => _resTableId = value.documentID)
                          .then((uValue) =>
                              servResTable.update(getResTable(), _resTableId))
                          .then((value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookForm(rId: this.rId))));
                    }
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _increment() {
    print(_chairNum);
    if (_currentCount < 5) {
      setState(() {
        _currentCount++;
        _counterCallback(_currentCount);
        _increaseCallback();
        _chairNum = _currentCount;
        print(_chairNum);
      });
    }
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 1) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
      _chairNum = _currentCount;
    });
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: BoxConstraints(minWidth: 32.0, minHeight: 32.0),
      onPressed: onPressed,
      elevation: 3.0,
      fillColor: Colors.green,
      child: Icon(
        icon,
        color: Colors.black,
        size: 25.0,
      ),
      shape: CircleBorder(),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Time Validation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Sorry, this time is already taken.'),
                Text('Please, choose another time'),
              ],
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              child: Text('ok'),
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
