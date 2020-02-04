import 'dart:convert';

import 'package:a2zonlinshoppy/pages/bill.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  SharedPreferences sharedPreferences;
  String name, mobile, cook, csrf, tock;
  Map<String, String> heaaders = {};
  bool codenable = false, cod, sameasshipping = true;
  var products;

  bool fullnamevalid = true,
      isempty = false,
      executivevalid = true,
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

  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController executivecontroller = TextEditingController();
  TextEditingController fullnamecontrollerbill = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController mobilecontrollerbill = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController emailcontrollerbill = TextEditingController();
  TextEditingController housecontroller = TextEditingController();
  TextEditingController housecontrollerbill = TextEditingController();
  TextEditingController postofficecontroller = TextEditingController();
  TextEditingController postofficecontrollerbill = TextEditingController();
  TextEditingController nearesttowncontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController landmarkcontroller = TextEditingController();
  TextEditingController landmarkcontrollerbill = TextEditingController();
  TextEditingController nearesttowncontrollerbill = TextEditingController();
  TextEditingController locationcontrollerbill = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController districtcontrollerbill = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController statecontrollerbill = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  TextEditingController pincontrollerbill = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();

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
    String code = sharedPreferences.getString('cod');
    String pr = sharedPreferences.getString('products');

    print("cookiesaddress");
    print(cook);
    print("tocken is");
    print(tock);
    print("products");
    print(products);

    var prods = json.decode(pr);

    if (code == null) {
      message1 = "cod can't be empty";
    } else {
      message1 = "ok";
    }
    if (prods == null) {
      message2 = "color can't be empty";
    } else {
      message2 = "ok";
    }

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
    return new Scaffold(
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
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Icon(Icons.arrow_right,
                                              color: Colors.blue),
                                        ),
                                        Expanded(
                                          flex: 10,
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                              products[index]["title"],
                                              textAlign: TextAlign.start,
                                              textScaleFactor: 1,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.grey.shade800),
                                            ),
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
            Form(
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      style: BorderStyle.none,
                                      color: Colors.white,
                                      width: 1.0),
                                ),
                                errorBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      style: BorderStyle.none,
                                      color: Colors.red,
                                      width: 1.0),
                                ),
                                focusedBorder: InputBorder.none,
                                enabledBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      style: BorderStyle.none,
                                      color: Colors.white,
                                      width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    emailvalid = true;
                                    isempty = false;
                                  });
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
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
                                  borderRadius: new BorderRadius.circular(25.0),
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
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
                                  borderRadius: new BorderRadius.circular(25.0),
                                  borderSide: new BorderSide(
                                      color: Colors.white, width: 1.0),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    pinvalid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  Pattern pattern = r'^[0-9]{6}$';
                                  RegExp regex = new RegExp(pattern);
                                  if (!regex.hasMatch(value)) {
                                    setState(() {
                                      pinvalid = false;
                                      isempty = true;
                                    });
                                    return null;
                                  } else {
                                    setState(() {
                                      pinvalid = true;
                                    });
                                  }
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
                        padding: const EdgeInsets.only(top: 15.0),
                        child: new Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: executivevalid == true
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
                                hintText: 'Executive ID',
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
            Visibility(
              visible: sameasshipping ? false : true,
              child: Form(
                key: _formKey1,
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
                      if (_formKey.currentState.validate()) {
                        validateForm();
                      }
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
        String codproducts, pgproducts;
        var customername = fullnamecontroller.text;
        var billcustomername = fullnamecontrollerbill.text;
        var mobile = mobilecontroller.text;
        var billmobile = mobilecontrollerbill.text;
        var email = emailcontroller.text;
        var billemail = emailcontrollerbill.text;
        var house = housecontroller.text;
        var billhouse = housecontrollerbill.text;
        var postoffice = postofficecontroller.text;
        var billpostoffice = postofficecontrollerbill.text;
        var city = nearesttowncontroller.text;
        var location = locationcontroller.text;
        var landmark = landmarkcontroller.text;
        var billcity = nearesttowncontrollerbill.text;
        var billlocation = locationcontrollerbill.text;
        var billlandmark = landmarkcontrollerbill.text;
        var district = districtcontroller.text;
        var billdistrict = districtcontrollerbill.text;
        var state = statecontroller.text;
        var billstate = statecontrollerbill.text;
        var pincode = pincontroller.text;
        var billpincode = pincontrollerbill.text;
        var executiveid = executivecontroller.text;

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

        print("heaaders" + heaaders.toString());

        if (isempty == false) {
          dynamic mybody = {
            'sameasshipping': '$sameas',
            'codenable': '$codsend',
            'name': '$customername',
            'billname': '$billcustomername',
            'mobile': '$mobile',
            'billmobile': '$billmobile',
            'email': '$email',
            'billemail': '$billemail',
            'house': '$house',
            'landmark': '$landmark',
            'billhouse': '$billhouse',
            'postoffice': '$postoffice',
            'billpostoffice': '$billpostoffice',
            'location': '$location',
            'billlocation': '$billlocation',
            'nearesttown': '$city',
            'billcity': '$billcity',
            'district': '$district',
            'billdistrict': '$billdistrict',
            'billlandmark': '$billlandmark',
            'state': '$state',
            'billstate': '$billstate',
            'pincode': '$pincode',
            'billpincode': '$billpincode',
            'executiveid': '$executiveid',
            '_csrf': '$csrf'
          };

          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await http.post(
              "https://www.a2zonlineshoppy.com/api/checkout/guest",
              headers: heaaders,
              body: mybody);

          print("ressssssss");
          print(respons.body);
          print(respons.headers);

          var bod = json.decode(respons.body);
          String message = bod["message"];

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
          isempty = false;
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

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
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
