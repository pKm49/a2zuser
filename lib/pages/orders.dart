import 'package:a2zonlinshoppy/components/singleorderproductview.dart';
import 'package:a2zonlinshoppy/components/singlepackageorderproductview.dart';

/// ListTile

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Orders extends StatefulWidget {
  @override
  OrdersState createState() => OrdersState();
}

class OrdersState extends State<Orders> {
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Orders"),
      ),
      //Body
      body: Container(
        color: Colors.grey.shade50,
        height: MediaQuery.of(context).size.height * 1.0,
        child: ListView(
          children: <Widget>[
            ExpansionTile(
              title: new Text(
                "Business Packages",
                style: TextStyle(
                    color: Colors.grey.shade800, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                textScaleFactor: 1.3,
              ),
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 10.0, right: 10.0, bottom: 0.0),
                      child: SinglePackageOrderProductView(),
                    )),
              ],
            ),
            ExpansionTile(
              title: new Text(
                "Orders",
                style: TextStyle(
                    color: Colors.grey.shade800, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                textScaleFactor: 1.3,
              ),
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                      child: SingleOrderProductView(),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
