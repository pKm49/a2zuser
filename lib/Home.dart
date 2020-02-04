import 'dart:convert';
import 'dart:io';

import 'package:a2zonlinshoppy/components/banner1.dart';
import 'package:a2zonlinshoppy/components/banner2.dart';
import 'package:a2zonlinshoppy/components/banner3.dart';
import 'package:a2zonlinshoppy/components/banner4.dart';
import 'package:a2zonlinshoppy/components/homecategories.dart';
import 'package:a2zonlinshoppy/components/homecategories2.dart';
import 'package:a2zonlinshoppy/components/homecategories3.dart';
import 'package:a2zonlinshoppy/components/homemobiles.dart';
import 'package:a2zonlinshoppy/components/homeofferzone.dart';
import 'package:a2zonlinshoppy/components/homerecentadded.dart';
import 'package:a2zonlinshoppy/components/hometoprated.dart';
import 'package:a2zonlinshoppy/pages/businesscart.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/drawer.dart';
import 'pages/privilegecard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeMobiles homeMobiles = new HomeMobiles();
  Icon _searchIcon = new Icon(Icons.search, color: Colors.white);
  Widget _appBarTitle = new Text(
    'A2Z Online Shoppy',
    textAlign: TextAlign.start,
    style: TextStyle(color: Colors.white),
  );

  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  Map<String, String> heaaders = {};

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red,
    ));
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  void isSignedIN() async {
    final String url1 = 'http://www.a2zonlineshoppy.com/api/getsearchtags';
    sharedPreferences = await SharedPreferences.getInstance();

    check().then((intenet) async {
      if (intenet != null && intenet) {
        dynamic respose1 = await http.get(url1, headers: heaaders);

        updateSearchtags(respose1);

        print("Internet connected");
      } else {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text("Check Your Internet Connection and try again."),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    exit(0);
                  },
                ),
              ],
            );
          },
        );
      }

      // No-Internet Case
    });
  }

  void updateSearchtags(http.Response response) async {
    List searchtags = [];
    print("searchtag response");
    print(response);
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();

    var bod = json.decode(response.body);
    var cats = bod["categories"];
    var subcats = bod["subcategories"];
    var prods = bod["products"];
    for (int i = 0; i < cats.length; i++) {
      searchtags.add(cats[i]["name"].toLowerCase());
    }
    for (int i = 0; i < subcats.length; i++) {
      searchtags.add(subcats[i]["name"].toLowerCase());
    }
    for (int i = 0; i < prods.length; i++) {
      searchtags.add(prods[i]["title"].toLowerCase());
    }
    print("searchtags1");
    print(searchtags);
    String stags = json.encode(searchtags);
    print("searchtag213s");
    print(stags);
    sharedPreferences.setString('searchtags', stags);
  }

  void updateCookie(http.Response response) async {
    print("response2");
    print(response);
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      sharedPreferences.setString(
          'Cookie', (index == -1) ? rawCookie : rawCookie.substring(0, index));
    }
    var bod = json.decode(response.body);
    String csrf = bod["csrf"];
    sharedPreferences.setString("csrf", csrf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: _appBarTitle,
        centerTitle: false,
        actions: <Widget>[
          new IconButton(
              icon: _searchIcon,
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              }),
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              }),
          new IconButton(
              icon: Icon(Icons.business_center, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BusinessCart()));
              })
        ],
      ),

      drawer: new Drawer(
        child: AtozDrawer(),
      ),

      //Body
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Banner1(),
          ),

          new Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: HomeCategories()),

          new Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 15.0, left: 5.0, right: 5.0),
              decoration: new BoxDecoration(
                color: Colors.grey.shade50,
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: new Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 15.0),
                          child: Text(
                            'A2Z Business Starting Package',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.justify,
                            textScaleFactor: 1.3,
                          )),
                    ),
                  ),
                  Image.asset(
                    'images/showcard.png',
                    width: MediaQuery.of(context).size.width * .45,
                  ),
                  Padding(
                      padding: EdgeInsets.all(0.0),
                      child: new Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 5, right: 5.0),
                          child: Text(
                            'Star A2Z Business and earn points to unlock special rewards and extra benefits.',
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.2,
                          ))),
                  new Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
                      child: ButtonTheme(
                        minWidth: 200.0,
                        height: 60.0,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PrivilegeCard()));
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("Enroll Now",
                                  textScaleFactor: 1.2,
                                  style: TextStyle(color: Colors.white)),
                              Icon(Icons.keyboard_arrow_right,
                                  color: Colors.white)
                            ],
                          ),
                        ),
                      )),
                  new Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 5.0, left: 25.0, right: 25.0),
                      child: ButtonTheme(
                        minWidth: 200.0,
                        height: 60.0,
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.red,
                          onPressed: () async {
                            await canLaunch("https://www.a2zonlinebusiness.com")
                                ? launch("https://www.a2zonlinebusiness.com")
                                : print(
                                    "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
                          },
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("Visit A2Z Online Business",
                                  textScaleFactor: 1.2,
                                  style: TextStyle(color: Colors.white)),
                              Icon(Icons.keyboard_arrow_right,
                                  color: Colors.white)
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 0.0),
            child: Container(
              color: Colors.grey.shade50,
              height: 300.0,
              child: homeMobiles,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Banner2(),
          ),

          new Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 15.0),
              child: HomeCategories2()),

          new Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Text(
              'Offer Zone',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              textScaleFactor: 1.3,
            ),
          ),
          //gridview for prducts
          new Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Container(
              color: Colors.grey.shade50,
              height: 290.0,
              child: HomeOfferZone(),
            ),
          ),
          Banner3(),

          new Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 5.0),
            child: new Text(
              'Latest Products, JUST IN!',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              textScaleFactor: 1.3,
            ),
          ),
          //gridview for prducts
          new Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              color: Colors.grey.shade50,
              height: 290.0,
              child: HomeRecentAdded(),
            ),
          ),

          new Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 15.0),
              child: HomeCategories3()),
          Banner4(),
          new Padding(
            padding: const EdgeInsets.only(top: 25.0, bottom: 5.0),
            child: new Text(
              'Top rated',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              textScaleFactor: 1.3,
            ),
          ),
          //gridview for prducts
          new Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Container(
              color: Colors.grey.shade50,
              height: 290.0,
              child: HomeTopRated(),
            ),
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    searchresults(query, context);
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return FutureBuilder(
        future: getrecentitems(),
        builder: (context, snapshot) {
          print("data is ");
          print(snapshot.data);
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  showResults(context);
                },
                leading: Icon(Icons.bubble_chart),
                title: snapshot.data[index],
              );
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          );
        },
      );
    } else {
      return FutureBuilder(
        future: getsuggestions(query),
        builder: (context, snapshot) {
          print("daaata is ");
          print(snapshot.data);
          List recent = [];
          List finallist = [];
          print("recent queriesfsdf");
          print(snapshot.data);
          if (snapshot.data == null) {
            recent = [];
          } else {
            recent = json.decode(snapshot.data);

            finallist =
                recent.where((p) => p.startsWith(query.toLowerCase())).toList();
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  query = finallist[index];
                  showResults(context);
                },
                leading: Icon(Icons.bubble_chart),
                title: Text(finallist[index]),
              );
            },
            itemCount: snapshot.data == null ? 0 : finallist.length,
          );
        },
      );
    }
  }

  Future<List> getrecentitems() async {
    List recent = [];
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String recentqueries = sharedPreferences.getString('recentqueries');
    if (recentqueries == null) {
      recent = [];
    } else {
      recent = json.decode(recentqueries);
    }
    return recent;
  }

  Future<String> getsuggestions(qry) async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getString('searchtags');
  }

  void searchresults(String key, context) async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('searchkey', key);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SearchResults()));
  }
}
