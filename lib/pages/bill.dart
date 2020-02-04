import 'dart:convert';

import 'package:a2zonlinshoppy/components/billdetails.dart';
import 'package:a2zonlinshoppy/pages/orderconfirmed.dart';
import 'package:a2zonlinshoppy/pages/paymentgateway.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  SharedPreferences sharedPreferences;
  String name, mobile, cook, csrf, tock;
  Map<String, String> heaaders = {};
  bool codenable, cod, sameasshipping = true;
  var pgproducts;

  String fullnamecontroller;
  String fullnamecontrollerbill;
  int mobilecontroller;
  int mobilecontrollerbill;
  String emailcontroller;
  String emailcontrollerbill;
  String housecontroller;
  String locationcontroller;
  String landmarkcontroller;
  String locationcontrollerbill;
  String landmarkcontrollerbill;
  String housecontrollerbill;
  String postofficecontroller;
  String postofficecontrollerbill;
  String nearesttowncontroller;
  String nearesttowncontrollerbill;
  String districtcontroller;
  String districtcontrollerbill;
  String statecontroller;
  String statecontrollerbill;
  int pincontroller;
  int pincontrollerbill;

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

    String pgprods = sharedPreferences.getString('pgproducts');
    print("pg products" + pgprods);
    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');

      pgproducts = json.decode(pgprods);

      fullnamecontroller = pgproducts["deladdress"]["name"];
      housecontroller = pgproducts["deladdress"]["house"];
      landmarkcontroller = pgproducts["deladdress"]["landmark"];
      locationcontroller = pgproducts["deladdress"]["location"];
      postofficecontroller = pgproducts["deladdress"]["postoffice"];
      nearesttowncontroller = pgproducts["deladdress"]["nearesttown"];
      districtcontroller = pgproducts["deladdress"]["district"];
      statecontroller = pgproducts["deladdress"]["state"];
      pincontroller = pgproducts["deladdress"]["pincode"];
      mobilecontroller = pgproducts["deladdress"]["mobile"];
      emailcontroller = pgproducts["deladdress"]["email"];

      landmarkcontrollerbill = pgproducts["billaddress"]["landmark"];
      locationcontrollerbill = pgproducts["billaddress"]["location"];
      fullnamecontrollerbill = pgproducts["billaddress"]["name"];
      housecontrollerbill = pgproducts["billaddress"]["house"];
      postofficecontrollerbill = pgproducts["billaddress"]["postoffice"];
      nearesttowncontrollerbill = pgproducts["billaddress"]["nearesttown"];
      districtcontrollerbill = pgproducts["billaddress"]["district"];
      statecontrollerbill = pgproducts["billaddress"]["state"];
      pincontrollerbill = pgproducts["billaddress"]["pincode"];
      mobilecontrollerbill = pgproducts["billaddress"]["mobile"];
      emailcontrollerbill = pgproducts["billaddress"]["email"];
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
                                    "$fullnamecontroller \n$housecontroller  \n$locationcontroller  \n$landmarkcontroller"
                                            " \n$postofficecontroller \n$nearesttowncontroller \n" +
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
                                  "Billing Address",
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.4,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            new Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    "$fullnamecontrollerbill \n$housecontrollerbill \n$locationcontrollerbill \n$landmarkcontrollerbill "
                                            "\n$postofficecontrollerbill \n$nearesttowncontrollerbill \n" +
                                        "$districtcontrollerbill \n$statecontrollerbill \n$pincontrollerbill \n+91$mobilecontrollerbill \n$emailcontrollerbill",
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1.2)),
                          ],
                        ),
                      )),
                ),
                Visibility(
                  visible: true,
                  child: new Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.grey.shade50,
                        child: BillDetails(),
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
            'https://www.a2zonlineshoppy.com/api/checkout/paymentgateway';

        var response = await http.get(
          Uri.encodeFull(urlbuy),
          headers: heaaders,
        );

        print(response.body);

        var bod = json.decode(response.body);
        String message = bod["message"];
        String codonly = bod["codonly"];
        var products = bod["products"];
        int total = bod["totalPrice"];

        if (message == "success") {
          sharedPreferences.setString('products', json.encode(products));
          sharedPreferences.setString('totalMrp', total.toString());

          if (codonly == "true") {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => OrderConfirmed()));
          } else {
            String urle = bod["url"];
            var postData = bod["postData"];
            int orderId;

            String appId,
                orderCurrency,
                orderNote,
                customerName,
                customerEmail,
                returnUrl,
                notifyUrl,
                secretKey;
            int orderAmount, customerPhone;
            appId = postData["appId"];

            orderId = postData["orderId"];
            orderAmount = postData["orderAmount"];
            orderCurrency = postData["orderCurrency"];

            orderNote = postData["orderNote"];
            customerName = postData["customerName"];
            customerEmail = postData["customerEmail"];

            customerPhone = postData["customerPhone"];
            returnUrl = postData["returnUrl"];
            notifyUrl = postData["notifyUrl"];

            secretKey = postData["secretKey"];
            dynamic ybody = {
              'appId': '$appId',
              'orderId': '$orderId',
              'orderAmount': '$orderAmount',
              'orderCurrency': '$orderCurrency',
              'orderNote': '$orderNote',
              'customerName': '$customerName',
              'customerEmail': '$customerEmail',
              'customerPhone': '$customerPhone',
              'returnUrl': '$returnUrl',
              'notifyUrl': '$notifyUrl',
              'secretKey': '$secretKey'
            };

            http.Response response =
                await http.post(urle, headers: heaaders, body: ybody);
            print("cashfree response");
            print(response.body);

            var bode = json.decode(response.body);
            String status = bode["status"];
            String paymentLink = bode["paymentLink"];
            print(status);

            if (status == "OK") {
              sharedPreferences.setString('paymentLink', paymentLink);
              Navigator.of(context).pop();

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaymentGateway()));
            }
          }
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
