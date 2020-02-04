/// ListTile

import 'package:flutter/material.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/components/singlecancelledproductview.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';

class OrderCancelled extends StatefulWidget {
  @override
  OrderCancelledState createState() => OrderCancelledState();
}

class OrderCancelledState extends State<OrderCancelled> {

  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  final TextEditingController _filter = new TextEditingController();

  SharedPreferences sharedPreferences;

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onSubmitted: searchresults,
          style: new TextStyle(color: Colors.white),
          controller: _filter,
          decoration: new InputDecoration(
              hintStyle: TextStyle(color: Colors.grey.shade50),
              prefixIcon: new Icon(Icons.search,color: Colors.white),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search,color: Colors.white);
        this._appBarTitle = new Text('A2ZOnlineShoppy');

      }
    });
  }
  void searchresults(String key) async {
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('searchkey',key);

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchResults()) );

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  new AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Order Cancelled"),
      ),


      //Body
      body: Container(
        color: Colors.grey.shade100,
        height: MediaQuery.of(context).size.height *1.0,
          child: SingleCancelledProductView(),
      ),


    );
  }
}




