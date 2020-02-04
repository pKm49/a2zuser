import 'dart:convert';
import 'dart:io';

import 'package:a2zonlinshoppy/authentication/loginregister.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class PreHomePage extends StatefulWidget {
  @override
  _PreHomePageState createState() => _PreHomePageState();
}

class _PreHomePageState extends State<PreHomePage> {
  SharedPreferences sharedPreferences;
  Map<String, String> heaaders = {};

  @override
  void initState() {
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
    final String url = 'http://www.a2zonlineshoppy.com/api/isloggedin';

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');

    if (cook == null) {
      check().then((intenet) async {
        if (intenet != null && intenet) {
          dynamic respose = await http.get(url, headers: heaaders);
          updateCookie(respose);
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
    } else {
      var username = sharedPreferences.getString('username');
      print("username");
      print(username);
      username == null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginRegister()))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  void updateCookie(http.Response response) async {
    var Cook;
    print("response2");
    print(response);
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      Cook = (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
    print("Cookie is");
    print(Cook);
    sharedPreferences.setString('Cookie', Cook);
    var bod = json.decode(response.body);
    String csrf = bod["csrf"];
    sharedPreferences.setString("csrf", csrf);
    print("csrf is");
    print(csrf);
    var username = sharedPreferences.getString('username');
    var isloggedin = sharedPreferences.getString('isloggedin');
    print("username");
    print(username);
    print("isloggedin");
    print(isloggedin);
    isloggedin == null
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginRegister()))
        : Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Center(
        child: Image.asset(
          'images/splashlogo.png',
          width: MediaQuery.of(context).size.width * .2,
        ),
      ),
    );
  }
}
