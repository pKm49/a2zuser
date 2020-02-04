import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillDetails extends StatefulWidget {
  @override
  _BillDetailsState createState() => _BillDetailsState();
}

class _BillDetailsState extends State<BillDetails> {
  List data;
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String productId;
  bool codenable, pgloading = false, codloading = false;
  int totalMrppg = 0,
      totalPricepg = 0,
      totalDiscpg = 0,
      totalDelypg = 0,
      len,
      totalPaypg = 0,
      pglength;
  int totalMrpcod = 0,
      totalPricecod = 0,
      totalDisccod = 0,
      totalDelycod = 0,
      totalPaycod = 0,
      codlength;
  var codproducts, pgproducts;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var codproduct;

    int otalMrpcod = 0,
        otalPricecod = 0,
        otalDisccod = 0,
        otalDelycod = 0,
        otalPaycod = 0,
        odlength;
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences = await SharedPreferences.getInstance();
    String code = sharedPreferences.getString('codenable');
    String codprods = sharedPreferences.getString('codproducts');
    String pgprods = sharedPreferences.getString('pgproducts');
    if (code == "true") {
      codenable = true;
      codproduct = json.decode(codprods);
      print("codproducts");
      print(codproduct["products"]);

      print("codproductslength");
      odlength = codproduct["products"].length;
      print(odlength);

      otalMrpcod = codproduct["ordertotalmrp"];
      otalDisccod = codproduct["ordertotaldisc"];
      otalPricecod = codproduct["ordertotalprice"];
      otalDelycod = codproduct["ordertotaldelcharge"];

      if (otalDelycod == null) {
        otalDelycod = 0;
      }
      otalPaycod = otalDelycod + otalPricecod;
    } else {
      codenable = false;
    }

    setState(() {
      codloading = codenable;
      codlength = odlength;
      codproducts = codproduct;

      totalMrpcod = otalMrpcod;
      totalDisccod = otalDisccod;
      totalPricecod = otalPricecod;
      totalDelycod = otalDelycod;
      totalPaycod = otalPaycod;

      pgproducts = json.decode(pgprods);

      print("pgproducts");
      print(pgproducts["products"]);

      print("pgproductslength");
      pglength = pgproducts["products"].length;
      print(pglength);

      if (pglength == 0) {
        pgloading = false;
      } else {
        pgloading = true;
      }
      totalMrppg = pgproducts["ordertotalmrp"];
      totalDiscpg = pgproducts["ordertotaldisc"];
      totalPricepg = pgproducts["ordertotalprice"];
      totalDelypg = pgproducts["ordertotaldelcharge"];

      print("deliverycharge");
      print(totalDelypg);
      if (totalDelypg == null) {
        totalDelypg = 0;
      }
      totalPaypg = totalDelypg + totalPricepg;
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(
            visible: codloading ? true : false,
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
              margin: EdgeInsets.only(bottom: 40.0),
              child: Column(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("COD Orders ",
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
                    height: codlength == null ? 0.0 : codlength * 220.0,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: codlength,
                      itemBuilder: (BuildContext context, int index) {
                        return Single_products(
                          title: codproducts["products"][index]['title'],
                          picture:
                              'https://www.a2zonlineshoppy.com/public2/products/' +
                                  codproducts["products"][index]['id'] +
                                  'imageone.jpg',
                        );
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
                                    "Total MRP:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1.1,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text("₹$totalMrpcod",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                      textScaleFactor: 1.1)),
                            ],
                          )),
                      new Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 15, right: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Total Discount:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1.1,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text("₹$totalDisccod",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                      textScaleFactor: 1.1)),
                            ],
                          )),
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
                                  child: Text("₹$totalPricecod",
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
                                  child: Text("₹$totalDelycod",
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
                                      "Total Payable On Delivery:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1.2,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text("₹$totalPaycod",
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
        Visibility(
            visible: pgloading ? true : false,
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
              child: Column(
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("Online Payment Orders ",
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
                    height: pglength == null ? 0.0 : pglength * 220.0,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: pglength,
                      itemBuilder: (BuildContext context, int index) {
                        return Single_products(
                          title: pgproducts["products"][index]['title'],
                          picture:
                              'https://www.a2zonlineshoppy.com/public2/products/' +
                                  pgproducts["products"][index]['id'] +
                                  'imageone.jpg',
                        );
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
                                    "Total MRP:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1.1,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text("₹$totalMrppg",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                      textScaleFactor: 1.1)),
                            ],
                          )),
                      new Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 15, right: 15),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Total Discount:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1.1,
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Text("₹$totalDiscpg",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                      textScaleFactor: 1.1)),
                            ],
                          )),
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
                                  child: Text("₹$totalPricepg",
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
                                  child: Text("₹$totalDelypg",
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
                                      "Total Payable On Checkout:",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1.2,
                                    )),
                                Expanded(
                                    flex: 1,
                                    child: Text("₹$totalPaypg",
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
  final picture;

  Single_products({
    this.title,
    this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: new Border(
        top: BorderSide(color: Colors.grey.shade300, width: 1.0),
      )),
      height: 200.0,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Image.network('$picture', height: 100.0),
            ),
          ),
          Expanded(
            flex: 3,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.2,
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
