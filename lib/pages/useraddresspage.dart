import 'dart:convert';

import 'package:a2zonlinshoppy/pages/bill.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAddressPage extends StatefulWidget {
  @override
  _UserAddressPageState createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  SharedPreferences sharedPreferences;
  String name,
      mobile,
      cook,
      csrf,
      tock,
      userdata,
      deladress1,
      deladress2,
      deladress3,
      email;
  Map<String, String> heaaders = {};
  int deladdress = 1;
  bool codenable = false,
      cod,
      sameasshipping = true,
      shownewaddress = false,
      executivevalid = true,
      showstoredaddress1 = false,
      showstoredaddress2 = false,
      showstoredaddress3 = false;
  var products, userhouse1, userhouse2, userhouse3;

  bool fullnamevalid = true,
      isempty = false,
      fullnamevalidbill = true,
      mobilevalid = true,
      mobilevalidbill = true,
      emailvalid = true,
      emailvalidbill = true,
      housevalid = true,
      housevalidbill = true,
      postofficevalid = true,
      postofficevalidbill = true,
      nearesttownvalid = true,
      locationvalid = true,
      landmarkvalid = true,
      landmarkvalidbill = true,
      nearesttownvalidbill = true,
      locationvalidbill = true,
      districtvalid = true,
      districtvalidbill = true,
      statevalid = true,
      statevalidbill = true,
      pinvalid = true,
      pinvalidbill = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController executivecontroller = TextEditingController();

  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController fullnamecontrollerbill = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController deladdresscontroller = TextEditingController();
  TextEditingController mobilecontrollerbill = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController emailcontrollerbill = TextEditingController();
  TextEditingController housecontroller = TextEditingController();
  TextEditingController landmarkcontroller = TextEditingController();
  TextEditingController landmarkcontrollerbill = TextEditingController();
  TextEditingController housecontrollerbill = TextEditingController();
  TextEditingController postofficecontroller = TextEditingController();
  TextEditingController postofficecontrollerbill = TextEditingController();
  TextEditingController nearesttowncontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController nearesttowncontrollerbill = TextEditingController();
  TextEditingController locationcontrollerbill = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController districtcontrollerbill = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController statecontrollerbill = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  TextEditingController pincontrollerbill = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  void isSignedIN() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');
    });

    final String urlbuy = 'https://www.a2zonlineshoppy.com/api/buynow';
    String message1 = "";
    String message2 = "";
    String message3 = "";
    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');
    csrf = sharedPreferences.getString('csrf');
    userdata = sharedPreferences.getString('userdata');
    String code = sharedPreferences.getString('cod');
    String pr = sharedPreferences.getString('products');
    var prods = json.decode(pr);

    print("cookiesaddress");
    print(cook);
    print("cod");
    print(code);
    print("products");
    print(pr);

    print("cookiesuseraddress");
    print(cook);

    var user = json.decode(userdata);
    print("userdata");
    print(userdata);
    userhouse1 = (user["deladdress0"]);
    userhouse2 = (user["deladdress1"]);
    userhouse3 = (user["deladdress2"]);

    print("userhouse1");
    print(userhouse1);
    print("userhouse2");
    print(userhouse2);
    print("userhouse3");
    print(userhouse3);

    setState(() {
      if (userhouse1 == null) {
        showstoredaddress1 = false;
      } else {
        showstoredaddress1 = true;
        deladress1 = userhouse1["name"] +
            "\n" +
            userhouse1["house"] +
            "\n" +
            userhouse1["postoffice"] +
            "\n" +
            userhouse1["location"] +
            "\n" +
            userhouse1["landmark"] +
            "\n" +
            userhouse1["nearesttown"] +
            "\n" +
            userhouse1["district"] +
            "\n" +
            userhouse1["state"] +
            "\n" +
            userhouse1["pincode"].toString() +
            "\n" +
            userhouse1["mobile"].toString() +
            "\n" +
            userhouse1["email"];
      }

      if (userhouse2 == null) {
        showstoredaddress2 = false;
      } else {
        showstoredaddress2 = true;
        deladress2 = userhouse2["name"] +
            "\n" +
            userhouse2["house"] +
            "\n" +
            userhouse2["postoffice"] +
            "\n" +
            userhouse2["location"] +
            "\n" +
            userhouse2["landmark"] +
            "\n" +
            userhouse2["nearesttown"] +
            "\n" +
            userhouse2["district"] +
            "\n" +
            userhouse2["state"] +
            "\n" +
            userhouse2["pincode"].toString() +
            "\n" +
            userhouse2["mobile"].toString() +
            "\n" +
            userhouse2["email"];
      }

      if (userhouse3 == null) {
        showstoredaddress3 = false;
      } else {
        showstoredaddress3 = true;
        deladress3 = userhouse3["name"] +
            "\n" +
            userhouse3["house"] +
            "\n" +
            userhouse3["postoffice"] +
            "\n" +
            userhouse3["location"] +
            "\n" +
            userhouse3["landmark"] +
            "\n" +
            userhouse3["nearesttown"] +
            "\n" +
            userhouse3["district"] +
            "\n" +
            userhouse3["state"] +
            "\n" +
            userhouse3["pincode"].toString() +
            "\n" +
            userhouse3["mobile"].toString() +
            "\n" +
            userhouse3["email"];
      }

      if (showstoredaddress1 == false &&
          showstoredaddress2 == false &&
          showstoredaddress3 == false) {
        print("shownewaddress");
        print(shownewaddress);
        shownewaddress = true;
        print("shownewaddress");
        print(shownewaddress);
      }
    });
    if (code == null) {
      message1 = "cod can't be empty";
    } else {
      message1 = "ok";
    }

    if (prods == null) {
      message2 = "prods can't be empty";
    } else {
      message2 = "ok";
    }

    print("message1");
    print(message1);

    print("message2");
    print(message2);
    print("tocken");
    print(tock);

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    if (message1 == "ok" && message2 == "ok") {
      setState(() {
        if (code == "true") {
          cod = true;
        } else if (code == "false") {
          cod = false;
        }

        products = prods;

        print("hello products");
        print(products.length);
      });
    } else {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Empty fields'),
            content: Text(message1 + "\n" + message2 + "\n" + message3),
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
  }

  void oncodchanged(bool tile) async {
    setState(() {
      codenable = tile;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('codenabled', tile.toString());
    print('codenabled');
    print(sharedPreferences.getString('codenabled'));
  }

  void ondeladdresschanged(int tile) async {
    setState(() {
      deladdress = tile;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('codenabled', tile.toString());
    print('codenabled');
    print(sharedPreferences.getString('codenabled'));
  }

  void onsameasshippingchanged(bool tile) async {
    setState(() {
      sameasshipping = tile;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('sameasshipping', tile.toString());
    print('sameasshipping');
    print(sharedPreferences.getString('sameasshipping'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: Colors.red,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Checkout"),
        ),

        //Body
        body: Container(
          height: MediaQuery.of(context).size.height * 1.0,
          child: ListView(children: <Widget>[
            Visibility(
              visible: cod == true ? true : false,
              child: new Padding(
                padding:
                    const EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
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
                        new BorderRadius.all(const Radius.circular(10.0)),
                  ),
                  child: Column(
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Choose payment method for",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.2,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      new Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 0.0),
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                border: new Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 1.0))),
                            height: products.length * 50.0,
                            child: ListView.builder(
                              itemCount: products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, bottom: 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.arrow_right,
                                            color: Colors.blue),
                                        Flexible(
                                          child: Text(
                                            products[index]["title"],
                                            textAlign: TextAlign.start,
                                            textScaleFactor: 1.1,
                                            style: TextStyle(
                                                color: Colors.grey.shade800),
                                          ),
                                        )
                                      ],
                                    ));
                              },
                            ),
                          )),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Radio(
                                  onChanged: (bool str) => oncodchanged(str),
                                  value: true,
                                  groupValue: codenable,
                                ),
                                new Text("Cash On Delivery",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: <Widget>[
                                Radio(
                                  onChanged: (bool str) => oncodchanged(str),
                                  value: false,
                                  groupValue: codenable,
                                ),
                                new Text("Online Payment",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade800)),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
                visible: shownewaddress == false ? true : false,
                child: new Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      "Shipping Address",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.50,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800),
                    ))),
            Visibility(
              visible: showstoredaddress1 == true ? true : false,
              child: new Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(3.0),
                  width: MediaQuery.of(context).size.width * .8,
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Radio(
                          onChanged: (int str) => ondeladdresschanged(str),
                          value: 1,
                          groupValue: deladdress,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: new Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "$deladress1",
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.2,
                              style: TextStyle(),
                            )),
                      )
                    ],
                  )),
            ),
            Visibility(
              visible: showstoredaddress2 == true ? true : false,
              child: new Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(3.0),
                  width: MediaQuery.of(context).size.width * .8,
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Radio(
                          onChanged: (int str) => ondeladdresschanged(str),
                          value: 1,
                          groupValue: deladdress,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: new Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "$deladress2",
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.2,
                              style: TextStyle(),
                            )),
                      )
                    ],
                  )),
            ),
            Visibility(
              visible: showstoredaddress3 == true ? true : false,
              child: new Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(3.0),
                  width: MediaQuery.of(context).size.width * .8,
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.all(Radius.circular(
                            5.0) //                 <--- border radius here
                        ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Radio(
                          onChanged: (int str) => ondeladdresschanged(str),
                          value: 1,
                          groupValue: deladdress,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: new Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "$deladress3",
                              textAlign: TextAlign.left,
                              textScaleFactor: 1.2,
                              style: TextStyle(),
                            )),
                      )
                    ],
                  )),
            ),
            Visibility(
              visible: shownewaddress == false ? true : false,
              child: new Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 60.0,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (showstoredaddress1 == true) {
                            showstoredaddress1 = false;
                          }

                          if (showstoredaddress2 == true) {
                            showstoredaddress2 = false;
                          }

                          if (showstoredaddress3 == true) {
                            showstoredaddress3 = false;
                          }

                          shownewaddress = true;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: new Text(
                        "Enter another address",
                        textScaleFactor: 1.2,
                      ),
                    ),
                  )),
            ),
            Visibility(
              visible: shownewaddress == true ? true : false,
              child: Form(
                key: _formKey,
                child: new Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                    child: Column(
                      children: <Widget>[
                        new Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Shipping Address",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.50,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800),
                            )),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: fullnamevalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Full Name*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedErrorBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        style: BorderStyle.none,
                                        color: Colors.white,
                                        width: 1.0),
                                  ),
                                  errorBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        style: BorderStyle.none,
                                        color: Colors.red,
                                        width: 1.0),
                                  ),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        style: BorderStyle.none,
                                        color: Colors.white,
                                        width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        fullnamevalid = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        fullnamevalid = true;
                                      });
                                    }
                                  }

                                  return null;
                                },
                                controller: fullnamecontroller,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: mobilevalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Mobile*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        mobilevalid = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      Pattern pattern = r'^[0-9]{10}$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value)) {
                                        setState(() {
                                          mobilevalid = false;
                                          isempty = true;
                                        });
                                      } else {
                                        setState(() {
                                          mobilevalid = true;
                                        });
                                      }
                                      return null;
                                    }
                                  }
                                  return null;
                                },
                                controller: mobilecontroller,
                                keyboardType: TextInputType.phone,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: emailvalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Email',

                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      return null;
                                    } else {
                                      Pattern pattern =
                                          r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value)) {
                                        setState(() {
                                          emailvalid = false;
                                          isempty = true;
                                        });
                                      } else {
                                        setState(() {
                                          emailvalid = true;
                                        });
                                      }
                                      return null;
                                    }
                                  }
                                  return null;
                                },
                                controller: emailcontroller,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: housevalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'House*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        housevalid = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        housevalid = true;
                                      });
                                    }
                                    return null;
                                  }
                                  return null;
                                },
                                controller: housecontroller,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: locationvalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Location*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        locationvalid = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        locationvalid = true;
                                      });
                                    }
                                    return null;
                                  }

                                  return null;
                                },
                                controller: locationcontroller,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: locationvalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Landmark*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    setState(() {
                                      landmarkvalid = false;
                                      isempty = true;
                                    });
                                    return null;
                                  } else {
                                    setState(() {
                                      landmarkvalid = true;
                                    });
                                  }
                                  return null;
                                },
                                controller: landmarkcontroller,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: postofficevalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Post Office*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        postofficevalid = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        postofficevalid = true;
                                      });
                                    }
                                    return null;
                                  }
                                  return null;
                                },
                                controller: postofficecontroller,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: nearesttownvalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Nearest Town*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        nearesttownvalid = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        nearesttownvalid = true;
                                      });
                                    }
                                    return null;
                                  }

                                  return null;
                                },
                                controller: nearesttowncontroller,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: districtvalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'District*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        districtvalid = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        districtvalid = true;
                                      });
                                    }
                                    return null;
                                  }
                                  return null;
                                },
                                controller: districtcontroller,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: statevalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'State*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        statevalid = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        statevalid = true;
                                      });
                                    }
                                    return null;
                                  }
                                  return null;
                                },
                                controller: statecontroller,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: pinvalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Pin*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (shownewaddress) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        pinvalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      Pattern pattern = r'^[0-9]{6}$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value)) {
                                        setState(() {
                                          pinvalidbill = false;
                                          isempty = true;
                                        });
                                        return null;
                                      } else {
                                        setState(() {
                                          pinvalidbill = true;
                                        });
                                      }
                                    }
                                    return null;
                                  }
                                  return null;
                                },
                                controller: pincontroller,
                                keyboardType: TextInputType.number,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Billing Address",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.6,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800),
                            )),
                        new Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (bool str) =>
                                          onsameasshippingchanged(str),
                                      value: true,
                                      groupValue: sameasshipping,
                                    ),
                                    new Text("Same as shipping address"),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Radio(
                                      onChanged: (bool str) =>
                                          onsameasshippingchanged(str),
                                      value: false,
                                      groupValue: sameasshipping,
                                    ),
                                    new Text(
                                        "Choose a Different Billing Address"),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    )),
              ),
            ),
            Visibility(
              visible: shownewaddress == true ? true : false,
              child: new Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 60.0,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (userhouse1 != null) {
                            showstoredaddress1 = true;
                          }

                          if (userhouse2 != null) {
                            showstoredaddress2 = true;
                          }

                          if (userhouse3 != null) {
                            showstoredaddress3 = true;
                          }

                          shownewaddress = false;
                        });
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: new Text(
                        "Choose saved address",
                        textScaleFactor: 1.2,
                      ),
                    ),
                  )),
            ),
            Visibility(
              visible: true,
              child: Column(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Billing Address",
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.6,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800),
                      )),
                  new Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                onChanged: (bool str) =>
                                    onsameasshippingchanged(str),
                                value: true,
                                groupValue: sameasshipping,
                              ),
                              new Text("Same as shipping address"),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Radio(
                                onChanged: (bool str) =>
                                    onsameasshippingchanged(str),
                                value: false,
                                groupValue: sameasshipping,
                              ),
                              new Text("Choose a Different Billing Address"),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Visibility(
              visible: sameasshipping == true ? false : true,
              child: Form(
                key: _formKey,
                child: new Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                    child: Column(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: fullnamevalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Full Name*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        fullnamevalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        fullnamevalidbill = true;
                                      });
                                    }
                                  }
                                  return null;
                                },
                                controller: fullnamecontrollerbill,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: mobilevalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Mobile*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        mobilevalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      Pattern pattern = r'^[0-9]{10}$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value)) {
                                        mobilevalidbill = false;
                                        isempty = true;
                                      } else {
                                        setState(() {
                                          mobilevalidbill = true;
                                        });
                                      }
                                      return null;
                                    }
                                  }
                                  return null;
                                },
                                controller: mobilecontrollerbill,
                                keyboardType: TextInputType.phone,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: emailvalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Email',
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      return null;
                                    } else {
                                      Pattern pattern =
                                          r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value)) {
                                        setState(() {
                                          emailvalidbill = false;
                                          isempty = true;
                                        });
                                      } else {
                                        setState(() {
                                          emailvalidbill = true;
                                        });
                                      }
                                      return null;
                                    }
                                  }
                                  return null;
                                },
                                controller: emailcontrollerbill,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: housevalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'House*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        housevalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        housevalidbill = true;
                                      });
                                    }
                                  }
                                  return null;
                                },
                                controller: housecontrollerbill,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: locationvalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Location*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        locationvalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        locationvalidbill = true;
                                      });
                                    }
                                  }
                                  return null;
                                },
                                controller: locationcontrollerbill,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: landmarkvalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Landmark*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        landmarkvalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        landmarkvalidbill = true;
                                      });
                                    }
                                  }
                                  return null;
                                },
                                controller: landmarkcontrollerbill,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: postofficevalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Post Office*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        postofficevalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        postofficevalidbill = true;
                                      });
                                    }
                                  }
                                  return null;
                                },
                                controller: postofficecontrollerbill,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: nearesttownvalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Nearest Town*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        nearesttownvalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        nearesttownvalidbill = true;
                                      });
                                    }
                                  }
                                  return null;
                                },
                                controller: nearesttowncontrollerbill,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: districtvalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'District*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        districtvalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        districtvalidbill = true;
                                      });
                                    }
                                  }
                                  return null;
                                },
                                controller: districtcontrollerbill,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: statevalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'State*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        statevalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      setState(() {
                                        statevalidbill = true;
                                      });
                                    }
                                  }
                                  return null;
                                },
                                controller: statecontrollerbill,
                                keyboardType: TextInputType.text,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                        new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: pinvalidbill == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: TextFormField(
                                decoration: new InputDecoration(
                                  hintText: 'Pin*',
                                  hintStyle: TextStyle(color: Colors.red),
                                  contentPadding: const EdgeInsets.all(20.0),
                                  fillColor: Colors.white,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(
                                        color: Colors.white, width: 1.0),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (value) {
                                  if (sameasshipping == true) {
                                    if (value.isEmpty) {
                                      setState(() {
                                        pinvalidbill = false;
                                        isempty = true;
                                      });
                                      return null;
                                    } else {
                                      Pattern pattern = r'^[0-9]{6}$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value)) {
                                        setState(() {
                                          pinvalidbill = false;
                                          isempty = true;
                                        });
                                        return null;
                                      } else {
                                        setState(() {
                                          pinvalidbill = true;
                                        });
                                      }
                                    }
                                    return null;
                                  }

                                  return null;
                                },
                                controller: pincontrollerbill,
                                keyboardType: TextInputType.number,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              )),
                        ),
                      ],
                    )),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 25.0, right: 25.0, bottom: 30.0),
              child: new Container(
                  decoration: new BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:
                            executivevalid == true ? Colors.grey : Colors.red,
                        blurRadius: 4.0,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius:
                        new BorderRadius.all(const Radius.circular(40.0)),
                  ),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: 'Executive ID',
                      contentPadding: const EdgeInsets.all(20.0),
                      fillColor: Colors.white,
                      focusedBorder: InputBorder.none,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide:
                            new BorderSide(color: Colors.white, width: 1.0),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          executivevalid = true;
                          isempty = false;
                        });
                        return null;
                      } else {
                        setState(() {
                          executivevalid = true;
                        });
                      }
                      return null;
                    },
                    controller: executivecontroller,
                    keyboardType: TextInputType.text,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  )),
            ),
            new Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 25.0, right: 25.0, bottom: 30.0),
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
                      validateForm();
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    child: new Text(
                      "Check Out",
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
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

  void validateForm() async {
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
        var user = json.decode(userdata);
        String codproducts, pgproducts;
        bool isempty = false;
        String shippingaddress;

        var billcustomername = fullnamecontrollerbill.text;
        var billmobile = mobilecontrollerbill.text;
        var billemail = emailcontrollerbill.text;
        var billhouse = housecontrollerbill.text;
        var billpostoffice = postofficecontrollerbill.text;
        var billcity = nearesttowncontrollerbill.text;
        var billlocation = locationcontrollerbill.text;
        var billlandmark = landmarkcontrollerbill.text;
        var billdistrict = districtcontrollerbill.text;
        var billstate = statecontrollerbill.text;
        var billpincode = pincontrollerbill.text;
        var executiveid = executivecontroller.text;

        var customername,
            mobile,
            email,
            house,
            postoffice,
            city,
            location,
            landmark,
            district,
            state,
            pincode;

        if (shownewaddress == true) {
          customername = fullnamecontroller.text;
          mobile = mobilecontroller.text;
          email = emailcontroller.text;
          house = housecontroller.text;
          postoffice = postofficecontroller.text;
          city = nearesttowncontroller.text;
          landmark = landmarkcontroller.text;
          location = locationcontroller.text;
          district = districtcontroller.text;
          state = statecontroller.text;
          pincode = pincontroller.text;
          shippingaddress = "4";
          if (customername.isEmpty) {
            isempty = true;
            showdia("Name can't be empty");
          } else if (mobile.isEmpty) {
            isempty = true;
            showdia("Mobile can't be empty");
          } else if (!(mobile.isEmpty)) {
            Pattern pattern = r'^[0-9]{10}$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(mobile)) {
              isempty = true;
              showdia("MobileNumber is not valid");
            }
          } else if (email.isEmpty) {
            isempty = true;
            showdia("Email can't be empty");
          } else if (!(email.isEmpty)) {
            Pattern pattern =
                r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(email)) {
              isempty = true;
              showdia("Email is not valid");
            }
          } else if (house.isEmpty) {
            isempty = true;
            showdia("House can't be empty");
          } else if (postoffice.isEmpty) {
            isempty = true;
            showdia("Postoffice can't be empty");
          } else if (location.isEmpty) {
            isempty = true;
            showdia("Location can't be empty");
          } else if (city.isEmpty) {
            isempty = true;
            showdia("Nearest Town can't be empty");
          } else if (district.isEmpty) {
            isempty = true;
            showdia("District can't be empty");
          } else if (state.isEmpty) {
            isempty = true;
            showdia("State can't be empty");
          } else if (pincode.isEmpty) {
            isempty = true;
            showdia("Pincode can't be empty");
          }
        } else {
          print("shipping address1");
          print(shippingaddress);
          if (deladdress == 1) {
            print("shipping address2");
            print(shippingaddress);
            shippingaddress = "1";

            customername = userhouse1["name"];
            mobile = userhouse1["mobile"];
            email = userhouse1["email"];
            house = userhouse1["house"];
            postoffice = userhouse1["postoffice"];
            city = userhouse1["city"];
            location = userhouse1["location"];
            landmark = userhouse1["landmark"];
            district = userhouse1["district"];
            state = userhouse1["state"];
            pincode = userhouse1["pincode"];
          } else if (deladdress == 2) {
            print("shipping address3");
            print(shippingaddress);
            shippingaddress = "2";

            customername = userhouse2["name"];
            mobile = userhouse2["mobile"];
            email = userhouse2["email"];
            house = userhouse2["house"];
            postoffice = userhouse2["postoffice"];
            city = userhouse2["city"];
            location = userhouse2["location"];
            landmark = userhouse2["landmark"];
            district = userhouse2["district"];
            state = userhouse2["state"];
            pincode = userhouse2["pincode"];
          } else if (deladdress == 3) {
            print("shipping address4");
            print(shippingaddress);
            shippingaddress = "3";

            customername = userhouse3["name"];
            mobile = userhouse3["mobile"];
            email = userhouse3["email"];
            house = userhouse3["house"];
            postoffice = userhouse3["postoffice"];
            city = userhouse3["city"];
            landmark = userhouse3["landmark"];
            location = userhouse3["location"];
            district = userhouse3["district"];
            state = userhouse3["state"];
            pincode = userhouse3["pincode"];
          }
        }

        if (!sameasshipping) {
          if (billcustomername.isEmpty) {
            isempty = true;
            showdia("Name can't be empty");
          } else if (billmobile.isEmpty) {
            isempty = true;
            showdia("Mobile can't be empty");
          } else if (!(billmobile.isEmpty)) {
            Pattern pattern = r'^[0-9]{10}$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(billmobile)) {
              isempty = true;
              showdia("MobileNumber is not valid");
            }
          } else if (billemail.isEmpty) {
            isempty = true;
            showdia("Email can't be empty");
          } else if (!(billemail.isEmpty)) {
            Pattern pattern =
                r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(billemail)) {
              isempty = true;
              showdia("Email is not valid");
            }
          } else if (billhouse.isEmpty) {
            isempty = true;
            showdia("House can't be empty");
          } else if (billpostoffice.isEmpty) {
            isempty = true;
            showdia("Postoffice can't be empty");
          } else if (billlocation.isEmpty) {
            isempty = true;
            showdia("Location can't be empty");
          } else if (billcity.isEmpty) {
            isempty = true;
            showdia("Landmark can't be empty");
          } else if (billdistrict.isEmpty) {
            isempty = true;
            showdia("District can't be empty");
          } else if (billstate.isEmpty) {
            isempty = true;
            showdia("State can't be empty");
          } else if (billpincode.isEmpty) {
            isempty = true;
            showdia("Pincode can't be empty");
          } else if (!(billpincode.isEmpty)) {
            Pattern pattern = r'^[0-9]{6}$';
            RegExp regex = new RegExp(pattern);
            if (!regex.hasMatch(mobile)) {
              isempty = true;
              showdia("Pincode is not valid");
            }
          }
        }

        http.Response respons;

        print(heaaders);

        String sameas;
        String codsend;
        if (sameasshipping == true) {
          sameas = "true";
        } else {
          sameas = "false";
        }

        if (codenable == true) {
          codsend = "true";
        } else {
          codsend = "false";
        }

        if (isempty == false) {
          dynamic mybody = {
            'shippingaddress': '$shippingaddress',
            'executiveid': '$executiveid',
            'sameasshipping': '$sameas',
            'codenable': '$codsend',
            'customername': '$customername',
            'billcustomername': '$billcustomername',
            'mobile': '$mobile',
            'billmobile': '$billmobile',
            'email': '$email',
            'billemail': '$billemail',
            'house': '$house',
            'billhouse': '$billhouse',
            'postoffice': '$postoffice',
            'billpostoffice': '$billpostoffice',
            'location': '$location',
            'landmark': '$landmark',
            'billlocation': '$billlocation',
            'billlandmark': '$billlandmark',
            'city': '$city',
            'billcity': '$billcity',
            'district': '$district',
            'billdistrict': '$billdistrict',
            'state': '$state',
            'billstate': '$billstate',
            'pincode': '$pincode',
            'billpincode': '$billpincode',
            'executiveid': '$executiveid',
            '_csrf': '$csrf'
          };

          sharedPreferences = await SharedPreferences.getInstance();
          respons = await http.post(
              "https://www.a2zonlineshoppy.com/api/checkout/user",
              headers: heaaders,
              body: mybody);

          print("ressssssss");
          print(respons.body);

          var bod = json.decode(respons.body);
          String message = bod["message"];
          print("message");
          print(bod);
          if (message == "success") {
            String codenable = bod["cod"];

            var codprods = bod["codproducts"];

            codproducts = json.encode(codprods);

            var pgprods = bod["pgproducts"];

            pgproducts = json.encode(pgprods);

            sharedPreferences = await SharedPreferences.getInstance();

            sharedPreferences.setString("codenable", codenable);
            sharedPreferences.setString("codproducts", codproducts);
            sharedPreferences.setString("pgproducts", pgproducts);

            sharedPreferences.remove('products');
            sharedPreferences.remove('cod');
            Navigator.of(context).pop();

            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BillPage()));
          }
        } else {
          Navigator.of(context).pop();

          showdia("Try again with valid input");
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

  void showdia(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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
}
