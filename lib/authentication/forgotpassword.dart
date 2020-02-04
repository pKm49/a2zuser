import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Home.dart';
import 'changepassword.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final String url = 'https://www.a2zonlineshoppy.com/api/isloggedin';
  final String urllogin = 'https://www.a2zonlineshoppy.com/api/customer/signin';
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  SharedPreferences sharedPreferences;
  bool isLoggedin;
  bool loading, mobilesend = true;
  String csrf;
  String userdata;
  var client = http.Client();
  var bod;
  Map<String, String> heaaders = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  void isSignedIN() async {
    setState(() {
      loading = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    print("cock is not null");
    print(cook);
    String uname = sharedPreferences.getString('username');
    csrf = sharedPreferences.getString('csrf');

    print("csrf");
    print(csrf);

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    if (uname == null) {
      isLoggedin = false;
    } else {
      setState(() {
        isLoggedin = false;
      });
    }

    if (isLoggedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void updateCookie(http.Response response) async {
    print("response2");
    print(response);
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      print("cookies");
      print((index == -1) ? rawCookie : rawCookie.substring(0, index));
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
        body: Stack(children: <Widget>[
      Visibility(
        visible: mobilesend ? true : true,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.shade50,
            child: new Padding(
                padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "forgot password?",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.6,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: new Container(
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4.0,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(40.0)),
                          ),
                          child: TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'Enter Mobile Number',
                              contentPadding: const EdgeInsets.all(20.0),
                              fillColor: Colors.white,
                              focusedBorder: InputBorder.none,
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              //fillColor: Colors.green
                            ),
                            controller: usernamecontroller,
                            keyboardType: TextInputType.phone,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: new Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(40.0)),
                        ),
                        child: ButtonTheme(
                          minWidth: 200.0,
                          height: 60.0,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              sendOTP();
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            child: new Text(
                              "send OTP",
                              textScaleFactor: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
      Visibility(
        visible: mobilesend ? false : true,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            color: Colors.grey.shade50,
            child: new Padding(
                padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "enter otp",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.6,
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: new Container(
                          decoration: new BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4.0,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(40.0)),
                          ),
                          child: TextFormField(
                            decoration: new InputDecoration(
                              hintText: 'OTP',
                              contentPadding: const EdgeInsets.all(20.0),
                              fillColor: Colors.white,
                              focusedBorder: InputBorder.none,
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                    color: Colors.white, width: 1.0),
                              ),
                              //fillColor: Colors.green
                            ),
                            controller: passwordcontroller,
                            keyboardType: TextInputType.phone,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          )),
                    ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: new Container(
                        width: MediaQuery.of(context).size.width * 1.0,
                        decoration: new BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4.0,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(40.0)),
                        ),
                        child: ButtonTheme(
                          minWidth: 200.0,
                          height: 60.0,
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () {
                              submitOTP();
                            },
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            child: new Text(
                              "submit",
                              textScaleFactor: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      )
    ]));
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

  void sendOTP() async {
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
        String message1 = "";
        String message2 = "";
        String error = "";
        String message = "";

        var username = usernamecontroller.text;

        if (username.isEmpty) {
          message1 = "MobileNumber Can't be Empty";
        } else {
          Pattern pattern = r'^[0-9]{10}$';
          RegExp regex = new RegExp(pattern);
          if (!regex.hasMatch(username)) {
            message1 = "MobileNumber is not valid";
          } else {
            message1 = "ok";
          }
        }

        print(csrf);

        dynamic mybody = {'mobile': '$username', '_csrf': '$csrf'};
        print(heaaders);

        if (message1 == "ok") {
          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await client.post(
              "https://www.a2zonlineshoppy.com/api/customer/forgotpassword/sendotp/",
              headers: heaaders,
              body: mybody);

          print("ressssssss");
          print(respons.body);

          bod = json.decode(respons.body);
          String tock = bod["tocken"];
          print("tocken");
          print(tock);

          error = bod["error"];
          message = bod["message"];
          if (message == "success") {
            Navigator.of(context).pop();

            sharedPreferences = await SharedPreferences.getInstance();

            sharedPreferences.setString("username", username);
            setState(() {
              loading = false;
              mobilesend = false;
            });
          } else {
            Navigator.of(context).pop();

            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text(error),
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
        } else {
          Navigator.of(context).pop();

          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(message1 + "\n" + message2),
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
        // Internet Present Case
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

  void submitOTP() async {
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
        String message1 = "";

        String error = "";
        String message = "";

        var password = passwordcontroller.text;

        if (password.isEmpty) {
          message1 = "OTP can't be empty";
        } else if (password.length < 4) {
          message1 = "OTP must be 4 charactors atleast";
        } else {
          message1 = "ok";
        }

        print(csrf);

        dynamic mybody = {'otp': '$password', '_csrf': '$csrf'};
        print(heaaders);

        if (message1 == "ok") {
          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await client.post(
              "https://www.a2zonlineshoppy.com/api/customer/forgotpassword/changepassword",
              headers: heaaders,
              body: mybody);

          print("ressssssss");
          print(respons.body);

          bod = json.decode(respons.body);
          String tock = bod["tocken"];
          print("tocken");
          print(tock);

          error = bod["error"];
          message = bod["message"];
          if (message == "success") {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ChangePassword()));
          } else {
            Navigator.of(context).pop();

            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text(error),
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
        } else {
          Navigator.of(context).pop();

          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(message1 + "\n"),
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
        // Internet Present Case
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
