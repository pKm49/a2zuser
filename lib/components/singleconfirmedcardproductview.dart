import 'dart:async';
import 'dart:convert';

import 'package:a2zonlinshoppy/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingleConfirmedCardProductView extends StatefulWidget {
  @override
  _SingleConfirmedCardProductViewState createState() =>
      _SingleConfirmedCardProductViewState();
}

class _SingleConfirmedCardProductViewState
    extends State<SingleConfirmedCardProductView> {
  BuildContext bcont;
  var data;
  SharedPreferences sharedPreferences;
  String name, mobile, cook, csrf, tock;
  String productId;
  Map<String, String> heaaders = {};
  int totalMrp = 0, len = 0;
  String totalPrice;
  String totalQty;
  String totalbv;
  int totalDeliveryCharge, ordertotal = 0;
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
      cook = sharedPreferences.getString('Cookie');
      tock = sharedPreferences.getString('tocken');
      csrf = sharedPreferences.getString('csrf');

      if (tock != null) {
        heaaders['authorization'] = "tocken " + tock;
      }

      heaaders['Accept'] = "application/JSON";
      heaaders['Cookie'] = cook;
    });
  }

  Future<String> getJsonData() async {
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences = await SharedPreferences.getInstance();
    String products = sharedPreferences.getString('products');
    String productss = sharedPreferences.getString('products');
    String totalPrices = sharedPreferences.getString('totalPrice');
    String totalQtys = sharedPreferences.getString('totalQty');
    String totalbvs = sharedPreferences.getString('totalbv');
    String totalDeliveryCharges =
        sharedPreferences.getString('totalDeliveryCharge');

    print("products");
    print(products);
    print("total");
    setState(() {
      data = json.decode(products);
      len = data.length;
      totalPrice = totalPrices;
      totalQty = totalQtys;
      totalbv = totalbvs;

      int totalPricee = int.parse(totalPrice);
      totalDeliveryCharge = 50;

      ordertotal = totalPricee + totalDeliveryCharge;
      print("data");
      print(data);
      print("data-length");
      print(len);

      print("totalMrp");
      print(totalMrp);
    });

    final String url =
        'https://www.a2zonlineshoppy.com/api/checkout/saveonlineorder';
    var response = await http.get(
      Uri.encodeFull(url),
      headers: heaaders,
    );

    print(response.body);

    var bod = json.decode(response.body);
    String message = bod["message"];

    if (message == "success") {
      print("successgjhgjh");
    } else {
      print("failjkhjkhkjed");
    }
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    bcont = context;
    return ListView(
      children: <Widget>[
        Visibility(
            visible: len == 0 ? false : true,
            child: Container(
              color: Colors.grey.shade50,
              height: MediaQuery.of(context).size.height * 1,
              child: ListView(
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.contain,
                    child: new Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Thank You For Shopping at A2ZOnlineshoppy",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.8)),
                  ),
                  new Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Order Total : ₹$ordertotal",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.5)),
                  new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Your Order Contains",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.2)),
                  Container(
                    height: MediaQuery.of(context).size.height * .8,
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade50,
                    ),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: len,
                      itemBuilder: (BuildContext context, int index) {
                        return Single_products(
                            title: data[index]['name'] +
                                '(' +
                                data[index]['size'] +
                                ')',
                            price: data[index]['price'],
                            qty: data[index]['qty'],
                            picture: 'https://www.a2zonlineshoppy.com/' +
                                data[index]['imageurl']);
                      },
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  void clearcart() async {
    final String url = 'https://www.a2zonlineshoppy.com/api/clearcart';
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
    var response = await http.get(Uri.encodeFull(url), headers: heaaders);

    print(response.body);

    var bod = json.decode(response.body);
    var message = bod["message"];

    if (message == "success") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}

class Single_products extends StatelessWidget {
  final title;
  final price;
  final qty;
  final picture;

  Single_products({
    this.title,
    this.qty,
    this.picture,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(
        top: BorderSide(color: Colors.grey.shade300, width: 1.0),
      )),
      height: 120.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.network('$picture', height: 100.0),
            ),
          ),
          Expanded(
            flex: 3,
            child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        '$title',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                        textScaleFactor: 1.2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Unit Price : Rs.' + (price / qty).toString(),
                        textAlign: TextAlign.start,
                        textScaleFactor: 1.2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Qty : ' + qty.toString(),
                        textAlign: TextAlign.start,
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
