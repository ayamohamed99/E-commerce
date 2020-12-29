import 'package:flutter/material.dart';

class BookForm extends StatefulWidget {
  final int initNumber;

  final Function(int) counterCallback;
  final Function increaseCallback;
  final Function decreaseCallback;
  BookForm(
      {this.initNumber,
      this.counterCallback,
      this.increaseCallback,
      this.decreaseCallback,
      Key key,
      this.title})
      : super(key: key);
  final String title;

  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
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
      });
  }

  int _currentCount;
  Function _counterCallback;
  Function _increaseCallback;
  Function _decreaseCallback;

  @override
  void initState() {
    _currentCount = widget.initNumber ?? 1;
    _counterCallback = widget.counterCallback ?? (int number) {};
    _increaseCallback = widget.increaseCallback ?? () {};
    _decreaseCallback = widget.decreaseCallback ?? () {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text("Book your table"),
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
                      onPressed: () => _selectDate(context),
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
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      scrollDirection: Axis.horizontal,
                      children: [
                        Card(
                          color: Colors.green,
                          child: Text(
                            '10:00',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Card(
                          color: Colors.green,
                          child: Text(
                            '10:30',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Card(
                          color: Colors.green,
                          child: Text(
                            '11:00',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Card(
                          color: Colors.green,
                          child: Text(
                            '11:30',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Card(
                          color: Colors.green,
                          child: Text(
                            '12:00',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Card(
                          color: Colors.green,
                          child: Text(
                            '12:30',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Card(
                          color: Colors.green,
                          child: Text(
                            '01:00',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Card(
                          color: Colors.green,
                          child: Text(
                            '01:30',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Card(
                          color: Colors.green,
                          child: Text(
                            '02:00',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        GestureDetector(
                          onTap: null,
                          child: Card(
                            color: Colors.green,
                            child: Text(
                              '02:30',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Colors.green,
                  onPressed: () {},
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
    if (_currentCount < 5)
      setState(() {
        _currentCount++;
        _counterCallback(_currentCount);
        _increaseCallback();
      });
  }

  void _dicrement() {
    setState(() {
      if (_currentCount > 1) {
        _currentCount--;
        _counterCallback(_currentCount);
        _decreaseCallback();
      }
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
}
