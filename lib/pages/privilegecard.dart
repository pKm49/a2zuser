import 'dart:convert';

import 'package:a2zonlinshoppy/components/singlecardview.dart';
import 'package:a2zonlinshoppy/pages/cardaddresspage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'businesscart.dart';

class PrivilegeCard extends StatefulWidget {
  @override
  _PrivilegeCardState createState() => _PrivilegeCardState();
}

class _PrivilegeCardState extends State<PrivilegeCard> {
  Icon _searchIcon = new Icon(Icons.search, color: Colors.white);
  Widget _appBarTitle = new Text('A2ZOnlineShoppy');
  final TextEditingController _filter = new TextEditingController();

  SharedPreferences sharedPreferences;
  String name;
  var showcard;
  String description;
  String mobile;
  Map<String, String> heaaders = {};
  final String url = 'https://www.a2zonlineshoppy.com/api/cards';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
    this.getJsonData();
  }

  void isSignedIN() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');
    });
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

  Future<String> getJsonData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    print("cookiessingleproduct");
    print(cook);

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
    final String url = 'https://www.a2zonlineshoppy.com/api/cards';

    check().then((intenet) async {
      if (intenet != null && intenet) {
        var response = await http.get(Uri.encodeFull(url), headers: heaaders);

        print("product is");
        print(response.body);

        setState(() {
          var mobiles = json.decode(response.body);
          showcard = mobiles["showcard"];
          description = showcard[0]["description"];
        });

        return "success";
        // Internet Present Case
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
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      return "success"; // No-Internet Case
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("A2Z Business Starting Package"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.business_center, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BusinessCart()));
              })
        ],
      ),

      //Body
      body: Visibility(visible: true, child: SingleCardView()),
    );
  }

  void buycard(String card) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Dialog(
            child: Container(
                color: Colors.transparent,
                height: 200.0,
                width: 100.0,
                child: Center(
                  child: CircularProgressIndicator(),
                )),
          );
        });

    check().then((intenet) async {
      if (intenet != null && intenet) {
        final String urladd =
            'https://www.a2zonlineshoppy.com/api/cardpurchase/$card';

        var response = await http.get(
          Uri.encodeFull(urladd),
          headers: heaaders,
        );

        print(response.body);
        var bod = json.decode(response.body);
        String message = bod["message"];

        if (message == "error") {
          Navigator.of(context).pop();

          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text("Something went wrong, try again."),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          var cards = bod["card"][0];
          print("card");
          print(cards);
          String card = json.encode(cards);
          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("card", card);
          Navigator.of(context).pop();

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CardAddressPage()));
        }
      } else {
        Navigator.of(context).pop();
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
                    Navigator.of(context).pop();
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
}
