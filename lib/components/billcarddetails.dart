import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillCardDetails extends StatefulWidget {
  @override
  _BillCardDetailsState createState() => _BillCardDetailsState();
}

class _BillCardDetailsState extends State<BillCardDetails> {
  List data;
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  var products;
  String totalPrice;
  String totalQty;
  String totalbv;
  int totalDeliveryCharge = 0, ordertotal = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences = await SharedPreferences.getInstance();
    String productss = sharedPreferences.getString('products');
    String totalPrices = sharedPreferences.getString('totalPrice');
    String totalQtys = sharedPreferences.getString('totalQty');
    String totalbvs = sharedPreferences.getString('totalbv');

    setState(() {
      products = json.decode(productss);

      totalPrice = totalPrices;
      totalQty = totalQtys;
      totalbv = totalbvs;

      int totalPricee = int.parse(totalPrice);
      totalDeliveryCharge = 50;

      ordertotal = totalPricee + totalDeliveryCharge;
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
            visible: true,
            child: Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
              ),
              padding: EdgeInsets.only(left: 5.0, bottom: 5.0),
              margin: EdgeInsets.only(bottom: 10.0),
              child: Column(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Order Details ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.5)),
                  Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: new Border(
                          bottom: BorderSide(
                              color: Colors.grey.shade400, width: 1.0),
                        )),
                    margin: EdgeInsets.only(left: 5.0, right: 5.0),
                    height: products == null ? 0.0 : (products.length * 120.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: products == null ? 0 : products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Single_products(
                            title: products[index]['name'] +
                                '(' +
                                products[index]['size'] +
                                ')',
                            price: products[index]['price'],
                            qty: products[index]['qty'],
                            picture: 'https://www.a2zonlineshoppy.com/' +
                                products[index]['imageurl']);
                      },
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text("Price Details ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.5)),
                      new Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 15, right: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Order Total:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1.1,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text("₹$totalPrice",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                      textScaleFactor: 1.1)),
                            ],
                          )),
                      new Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 15, right: 15, bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Delivery Charges:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1.1,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text("₹$totalDeliveryCharge",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                      textScaleFactor: 1.1)),
                            ],
                          )),
                      Container(
                        decoration: new BoxDecoration(
                            border: new Border(
                          top: BorderSide(
                              color: Colors.grey.shade500, width: 1.0),
                        )),
                        child: new Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 8, right: 8, bottom: 15.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Total Payable :",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1.2,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text("₹$ordertotal",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                        textScaleFactor: 1.4)),
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
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
