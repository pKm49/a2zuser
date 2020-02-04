import 'dart:convert';

import 'package:a2zonlinshoppy/components/billcarddetails.dart';
import 'package:a2zonlinshoppy/pages/orderconfirmedcard.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BillCardPage extends StatefulWidget {
  @override
  _BillCardPageState createState() => _BillCardPageState();
}

class _BillCardPageState extends State<BillCardPage> {
  SharedPreferences sharedPreferences;
  String name, mobile, cook, csrf, tock;
  Map<String, String> heaaders = {};
  bool codenable, cod, sameasshipping = true;
  var pgproducts;

  String fullnamecontroller;
  int mobilecontroller;
  String emailcontroller;
  String housecontroller;
  String postofficecontroller;
  String locationcontroller;
  String landmarkcontroller;
  String nearesttowncontroller;
  String districtcontroller;
  String statecontroller;
  int pincontroller;
  var products;
  int totalPrice;
  int totalQty;
  int totalbv;
  int totalDeliveryCharge;
  var postData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  void isSignedIN() async {
    sharedPreferences = await SharedPreferences.getInstance();

    String code = sharedPreferences.getString('codenable');

    if (code == "true") {
      codenable = true;
    } else {
      codenable = false;
    }

    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');
    csrf = sharedPreferences.getString('csrf');

    String postDatas = sharedPreferences.getString('postData');
    print("postdata" + postDatas);

    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');

      pgproducts = json.decode(postDatas);

      fullnamecontroller = pgproducts["address"]["name"];
      housecontroller = pgproducts["address"]["house"];
      postofficecontroller = pgproducts["address"]["postoffice"];
      locationcontroller = pgproducts["address"]["location"];
      landmarkcontroller = pgproducts["address"]["landmark"];
      nearesttowncontroller = pgproducts["address"]["nearesttown"];
      districtcontroller = pgproducts["address"]["district"];
      statecontroller = pgproducts["address"]["state"];
      pincontroller = pgproducts["address"]["pincode"];
      mobilecontroller = pgproducts["address"]["mob"];
      emailcontroller = pgproducts["address"]["email"];
    });

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        child: Scaffold(
            appBar: new AppBar(
              automaticallyImplyLeading: true,
              centerTitle: true,
              backgroundColor: Colors.red,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text("Bill"),
            ),

            //Body
            body: Container(
              height: MediaQuery.of(context).size.height * 1.0,
              child: ListView(children: <Widget>[
                Visibility(
                  visible: true,
                  child: new Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
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
                        padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 10.0),
                                child: Text(
                                  "Shipping Address",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.4,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            new Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    "$fullnamecontroller \n$housecontroller \n$locationcontroller \n$landmarkcontroller \n$postofficecontroller \n$nearesttowncontroller \n" +
                                        "$districtcontroller \n$statecontroller \n$pincontroller \n+91$mobilecontroller \n$emailcontroller",
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1.2)),
                          ],
                        ),
                      )),
                ),
                Visibility(
                  visible: true,
                  child: new Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      child: Container(
                        color: Colors.grey.shade50,
                        child: BillCardDetails(),
                      )),
                ),
                new Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Text(
                      "(All price include tax)",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
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
                          payment();
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
            )),
        onWillPop: requestPop);
  }

  Future<bool> requestPop() async {
    print("helloooooo");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('codenable');
    sharedPreferences.remove('codproducts');
    sharedPreferences.remove('pgproducts');

    return true;
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

  void payment() async {
    check().then((intenet) async {
      if (intenet != null && intenet) {
        final String urlbuy =
            'https://www.a2zonlineshoppy.com/api/checkout/paymentgatewaycard';

        var response = await http.get(
          Uri.encodeFull(urlbuy),
          headers: heaaders,
        );

        print(response.body);

        var bod = json.decode(response.body);
        String message = bod["message"];

        if (message == "success") {
          Navigator.of(context).pop();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OrderConfirmedCard()));
        } else {
          Navigator.of(context).pop();

          showdia("Something went wrong, try again");
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
              },
            ),
          ],
        );
      },
    );
  }
}

/*
Stack(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                  Text("Shipping Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                  Text("Billing Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                ],
              ),
            ),
            Visibility(
              visible: codproducts == null?false:true,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                      Text("COD products",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                    ],
                  ),
                ),
            ),
            Visibility(
              visible: pgproducts == null?false:true,
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("COD products",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                  ],
                ),
              ),
            ),

            new Padding(padding: const EdgeInsets.only(top: 25.0,right: 25.0,left:25.0),child:
            ButtonTheme(
              minWidth: 200.0,
              height: 60.0,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: (){
                  payment();
                },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                child: new Text("Continue to Payment",textScaleFactor: 1.2,),
              ),
            )
            ),

          ]
      )

      */
