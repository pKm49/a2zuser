import 'dart:convert';

import 'package:a2zonlinshoppy/Home.dart';
import 'package:a2zonlinshoppy/aboutandpolicy/about.dart';
import 'package:a2zonlinshoppy/pages/account.dart';
import 'package:a2zonlinshoppy/pages/businesscart.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/pages/categories.dart';
import 'package:a2zonlinshoppy/pages/orders.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AtozDrawer extends StatefulWidget {
  @override
  _AtozDrawerState createState() => _AtozDrawerState();
}

class _AtozDrawerState extends State<AtozDrawer> {
  SharedPreferences sharedPreferences;

  String name, mobile, email, userdata, profileurl;
  var usrdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  void isSignedIN() async {
    sharedPreferences = await SharedPreferences.getInstance();
    userdata = sharedPreferences.getString('userdata');
    if (userdata != null) {
      usrdata = json.decode(userdata);
      var imageurl = usrdata["avatarurl"];
      int index = imageurl.lastIndexOf("/");
      String yourCuttedString = imageurl.substring(index + 1, imageurl.length);
      setState(() {
        profileurl = "https://www.a2zonlineshoppy.com/public2/avatars/" +
            yourCuttedString;
        email = usrdata["email"];

        print("url");
        print(profileurl);
        name = sharedPreferences.getString('name');
        mobile = sharedPreferences.getString('mobile');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4.0,
          ),
        ],
        color: Colors.grey.shade50,
      ),
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            color: Colors.grey.shade50,
            child: Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 15.0, left: 50.0, right: 50.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 2.0,
                              ),
                            ],
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: profileurl == null
                                  ? NetworkImage(
                                      'https://www.a2zonlineshoppy.com/public2/avatars/default.png',
                                      scale: .50,
                                    )
                                  : NetworkImage(
                                      profileurl,
                                      scale: .50,
                                    ),
                            )),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    name == null ? "Guest" : name,
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.6,
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ),
              ],
            ),
          ),
          //Body
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home, color: Colors.blue),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Categories()));
            },
            child: ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.apps, color: Colors.blue),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Account()));
            },
            child: ListTile(
              title: Text('Account'),
              leading: Icon(Icons.person, color: Colors.blue),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Orders()));
            },
            child: ListTile(
              title: Text('Orders'),
              leading: Icon(Icons.shopping_basket, color: Colors.blue),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BusinessCart()));
            },
            child: ListTile(
              title: Text('Business Cart'),
              leading: Icon(Icons.business_center, color: Colors.blue),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cart()));
            },
            child: ListTile(
              title: Text('Shopping Cart'),
              leading: Icon(Icons.shopping_cart, color: Colors.blue),
            ),
          ),

          new Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 0, bottom: 20.0),
            child: new Container(
              width: MediaQuery.of(context).size.width * 1.0,
              margin: EdgeInsets.only(top: 40.0),
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
              ),
              child: ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: () {
                    LaunchReview.launch(
                        androidAppId:
                            "com.a2zonlineshoppy.a2zonlineshoppyseller");
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: new Text(
                    "sell at A2Z",
                    textScaleFactor: 1.2,
                  ),
                ),
              ),
            ),
          ),

          new Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutApp()));
              },
              child: Text(
                "About",
                textAlign: TextAlign.center,
                textScaleFactor: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.grey.shade600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
