import 'dart:convert';

import 'package:a2zonlinshoppy/pages/searchresults.dart';
import 'package:a2zonlinshoppy/pages/uploadphoto.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CardAddressPage extends StatefulWidget {
  @override
  _CardAddressPageState createState() => _CardAddressPageState();
}

class _CardAddressPageState extends State<CardAddressPage> {
  Icon _searchIcon = new Icon(Icons.search, color: Colors.white);
  Widget _appBarTitle = new Text('A2ZOnlineShoppy');
  final TextEditingController _filter = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SharedPreferences sharedPreferences;
  String name,
      mobile,
      cook,
      csrf,
      size,
      tock,
      cardname,
      agevalue,
      codtemp = "true",
      affiliatelink;
  int bv, baseprice, delcharge;
  Map<String, String> heaaders = {};
  bool codenable = false,
      cod,
      sameasshipping = false,
      diamondtwo = false,
      diamondthree = false;
  var card;
  List sizes;

  bool fullnamevalid = true,
      fatherhusbandvalid = true,
      proffessionvalid = true,
      mobilevalid = true,
      dobvalid = true,
      agevalid = true,
      emailvalid = true,
      housevalid = true,
      postofficevalid = true,
      nearesttownvalid = true,
      districtvalid = true,
      statevalid = true,
      pinvalid = true,
      locationvalid = true,
      nomineevalid = true,
      relationshipvalid = true,
      executiveidvalid = true,
      diamondnamevalid1 = true,
      diamondrelationshipvalid1 = true,
      diamondagevalid1 = true,
      diamondnomineevalid1 = true,
      diamondnamevalid2 = true,
      diamondrelationshipvalid2 = true,
      diamondagevalid2 = true,
      diamondnomineevalid2 = true,
      diamondnamevalid3 = true,
      diamondrelationshipvalid3 = true,
      diamondagevalid3 = true,
      landmarkvalid = true,
      isempty = false,
      diamondnomineevalid3 = true;

  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController fatherhusbandcontroller = TextEditingController();
  TextEditingController proffessioncontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController housecontroller = TextEditingController();
  TextEditingController postofficecontroller = TextEditingController();
  TextEditingController nearesttowncontroller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  DateTime dateobcontroller = DateTime.now();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController landmarkcontroller = TextEditingController();
  int agecontroller;
  TextEditingController nomineecontroller = TextEditingController();
  TextEditingController relationshipcontroller = TextEditingController();
  TextEditingController executiveidcontroller = TextEditingController();

  TextEditingController holdernamecontroller = TextEditingController();
  TextEditingController bankcontroller = TextEditingController();
  TextEditingController acnocontroller = TextEditingController();
  TextEditingController ifsccontroller = TextEditingController();

  TextEditingController diamondnamecontroller1 = TextEditingController();
  TextEditingController diamondrelationshipcontroller1 =
      TextEditingController();
  TextEditingController diamondagecontroller1 = TextEditingController();
  TextEditingController diamondnomineecontroller1 = TextEditingController();

  TextEditingController diamondnamecontroller2 = TextEditingController();
  TextEditingController diamondrelationshipcontroller2 =
      TextEditingController();
  TextEditingController diamondagecontroller2 = TextEditingController();
  TextEditingController diamondnomineecontroller2 = TextEditingController();

  TextEditingController diamondnamecontroller3 = TextEditingController();
  TextEditingController diamondrelationshipcontroller3 =
      TextEditingController();
  TextEditingController diamondagecontroller3 = TextEditingController();
  TextEditingController diamondnomineecontroller3 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

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
              prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search, color: Colors.white);
        this._appBarTitle = new Text('A2ZOnlineShoppy');
      }
    });
  }

  void searchresults(String key) async {
    sharedPreferences.setString('searchkey', key);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchResults()));
  }

  void isSignedIN() async {
    sharedPreferences = await SharedPreferences.getInstance();

    final String urlbuy = 'https://www.a2zonlineshoppy.com/api/buynow';
    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');
    csrf = sharedPreferences.getString('csrf');
    String cards = sharedPreferences.getString('card');

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');

      card = json.decode(cards);
      cardname = card["name"];
      baseprice = card["offerprice"];
      bv = card["bv"];
      affiliatelink = card["affiliatelink"];
      delcharge = card["baseprice"];
      sizes = card["size"];
    });
  }

  void onsizechanged(String tile) async {
    setState(() {
      size = tile;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('size', size);
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

  void oncodchanged(bool tile) async {
    setState(() {
      codenable = tile;
      if (codenable == true) {
        codtemp = 'true';
      } else {
        codtemp = 'false';
      }
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('codenabled', tile.toString());
    print('codenabled');
    print(codenable);
    print(codtemp);
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
              Form(
                key: _formKey,
                child: new Padding(
                    padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                    child: Column(children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Text(
                            "Personal Info",
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
                                  color: fatherhusbandvalid == true
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
                                hintText: 'Father / Husband*',
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
                                    fatherhusbandvalid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    fatherhusbandvalid = true;
                                  });
                                }
                                return null;
                              },
                              controller: fatherhusbandcontroller,
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
                                  color: proffessionvalid == true
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
                                hintText: 'Proffession*',
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
                                    proffessionvalid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    proffessionvalid = true;
                                  });
                                }
                                return null;
                              },
                              controller: proffessioncontroller,
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
                                  color: landmarkvalid == true
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
                                hintText: 'Land Mark*',
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
                                  color: dobvalid == true
                                      ? Colors.grey
                                      : Colors.red,
                                  blurRadius: 4.0,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(
                                  const Radius.circular(40.0)),
                            ),
                            child: ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width * 1.0,
                              height: 60.0,
                              child: RaisedButton(
                                textColor: Colors.grey.shade600,
                                color: Colors.white,
                                onPressed: () {
                                  _selectDate(context);
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                    side: BorderSide(
                                        color: Colors.white, width: 1.0)),
                                child: new Text(
                                  "Select Date of Birth ",
                                  style: TextStyle(color: Colors.grey.shade800),
                                  textScaleFactor: 1.2,
                                ),
                              ),
                            )),
                      ),
                      Visibility(
                        visible: agecontroller == null ? false : true,
                        child: new Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: new Container(
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: agevalid == true
                                        ? Colors.grey
                                        : Colors.red,
                                    blurRadius: 4.0,
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: new BorderRadius.all(
                                    const Radius.circular(40.0)),
                              ),
                              child: ButtonTheme(
                                minWidth:
                                    MediaQuery.of(context).size.width * 1.0,
                                height: 60.0,
                                child: RaisedButton(
                                  textColor: Colors.grey.shade600,
                                  color: Colors.white,
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: Colors.white, width: 1.0)),
                                  child: new Text(
                                    "Age: $agecontroller",
                                    style:
                                        TextStyle(color: Colors.grey.shade800),
                                    textScaleFactor: 1.2,
                                  ),
                                ),
                              )),
                        ),
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
                                  color: nomineevalid == true
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
                                hintText: 'Nominee*',
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
                                    nomineevalid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    nomineevalid = true;
                                  });
                                }
                                return null;
                              },
                              controller: nomineecontroller,
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
                                  color: relationshipvalid == true
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
                                hintText: 'Relationship*',
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
                                    relationshipvalid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    relationshipvalid = true;
                                  });
                                }
                                return null;
                              },
                              controller: relationshipcontroller,
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
                                  color: executiveidvalid == true
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
                                hintText: 'Executive ID*',
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
                                    executiveidvalid = false;
                                    isempty = true;
                                  });
                                  return null;
                                } else {
                                  setState(() {
                                    executiveidvalid = true;
                                  });
                                }
                                return null;
                              },
                              controller: executiveidcontroller,
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
                                hintText: 'Account Holder',
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
                              controller: holdernamecontroller,
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
                                hintText: 'Bank',
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
                              controller: bankcontroller,
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
                                hintText: 'Account Number',
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
                              controller: acnocontroller,
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
                                hintText: 'IFSC',
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
                              controller: ifsccontroller,
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            )),
                      ),
                      new Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                onChanged: (bool value) =>
                                    onsameasshippingchanged(value),
                                value: sameasshipping,
                              ),
                              new InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Terms and Conditions'),
                                        content: Text(
                                            "- Minimum 24 hours admit in hospital \n-Original hospital documents, Bills & Discharge Summary \n-Road accidents FIR attested copy \n-Death certificate \n-Postmortem Report \n-Privilege Card Copy \n-Identity Card Copy \n-Bank Details Copy "),
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
                                },
                                child: new Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "I agree to terms and conditions",
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade600),
                                    )),
                              ),
                            ],
                          )),
                      new Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 0.0, right: 0.0, bottom: 30.0),
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
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(40.0)),
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
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              child: new Text(
                                "Check out",
                                textScaleFactor: 1.2,
                              ),
                            ),
                          ),
                        ),
                      )
                    ])),
              )
            ])));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateobcontroller,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateobcontroller) dateobcontroller = picked;

    final birthday = dateobcontroller;
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
    agecontroller = (difference / 365).round();
    print("age");
    print(dateobcontroller);
    print(date2);
    print(agecontroller);

    setState(() {
      dateobcontroller = picked;
      agecontroller = (difference / 365).round();
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
        dynamic mybody;

        var name = fullnamecontroller.text;
        var fatherhusband = fatherhusbandcontroller.text;
        var proffession = proffessioncontroller.text;
        var mobile = mobilecontroller.text;
        var email = emailcontroller.text;
        var house = housecontroller.text;
        var post = postofficecontroller.text;
        var location = locationcontroller.text;
        var landmark = landmarkcontroller.text;
        var nearesttown = nearesttowncontroller.text;
        var district = districtcontroller.text;
        var state = statecontroller.text;
        var pincode = pincontroller.text;
        DateTime dateob = dateobcontroller;
        var age = agecontroller;
        var nominee = nomineecontroller.text;
        var relationship = relationshipcontroller.text;
        var executiveid = executiveidcontroller.text;

        var holdername = holdernamecontroller.text;
        var bank = bankcontroller.text;
        var acno = acnocontroller.text;
        var ifsc = ifsccontroller.text;

        if (dateob == null) {
          isempty = true;
          setState(() {
            dobvalid = false;
          });
        } else {
          setState(() {
            dobvalid = true;
          });
        }
        if (age == null) {
          isempty = true;
          setState(() {
            agevalid = false;
          });
        } else {
          setState(() {
            agevalid = true;
          });
        }
        print("is empty" + isempty.toString());

        if (isempty == false) {
          mybody = {
            'ifsc': '$ifsc',
            'bank': '$bank',
            'acno': '$acno',
            'holdername': '$holdername',
            'executiveid': '$executiveid',
            'codenable': '$codtemp',
            'name': '$name',
            'fatherhusband': '$fatherhusband',
            'proffession': '$proffession',
            'mobile': '$mobile',
            'email': '$email',
            'house': '$house',
            'dob': '$dateob',
            'age': '$age',
            'postoffice': '$post',
            'location': '$location',
            'landmark': '$landmark',
            'city': '$nearesttown',
            'nominee': '$nominee',
            'relationship': '$relationship',
            'district': '$district',
            'state': '$state',
            'pincode': '$pincode',
            '_csrf': '$csrf',
          };
          print(heaaders);

          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await http.post(
              "https://www.a2zonlineshoppy.com/api/checkout/card/details",
              headers: heaaders,
              body: mybody);

          print("ressssssss");
          print(respons.body);

          var bod = json.decode(respons.body);
          String message = bod["message"];

          print("message");
          print(message);

          if (message == "success") {
            String cardrequestid = bod["id"];
            sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString("cardrequestid", cardrequestid);
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Uploadphoto()));
          } else {
            Navigator.of(context).pop();

            showdia("Something went wrong, try again");
          }
        } else {
          isempty = false;
          showdia("Check the inputs and try again.");
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
    Navigator.of(context).pop();

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
              },
            ),
          ],
        );
      },
    );
  }
}
