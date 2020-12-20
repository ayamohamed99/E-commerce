
import 'package:ecommerce/Components/loading.dart';
import 'package:ecommerce/Models/categoryDetail.dart';
import 'package:ecommerce/Services/category.Services.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}
class _TestState extends State<Test> {

    List<CategoryDetail> category;

  CategoryService catServ = new CategoryService();
  // ignore: missing_return
  Future<List<CategoryDetail>> _fechCategoryData() async {
    category = await catServ.fetchData();
  }

   // ignore: must_call_super
   void initState() {
    _fechCategoryData();
  }

  
  bool _visible = false;

  Widget dropdownlist(int index){
    return Container(
      child: Text(category[category.length - index - 1].categoryName),
    );
  }

  @override
  Widget build(BuildContext context) {
  if (category == null) return Loading();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('E-Commerce Project'),
        backgroundColor: Colors.green[400],
      ),
      body:  Column(
       children: [
         FlatButton.icon(onPressed: (){
                           setState(() {
                              _visible = !_visible;
                            });
                        }, 
                        icon: Icon(Icons.list),
                         label: Text('Categories')),

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
       ],
     ),
   );
                   
                   
  }
}