import 'dart:async';
import 'dart:convert';

import 'package:a2zonlinshoppy/pages/cancelpage.dart';
import 'package:a2zonlinshoppy/pages/productview.dart';
import 'package:a2zonlinshoppy/pages/returnpage.dart';
import 'package:a2zonlinshoppy/pages/trackpage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleOrderProductView extends StatefulWidget {
  @override
  _SingleOrderProductViewState createState() => _SingleOrderProductViewState();
}

class _SingleOrderProductViewState extends State<SingleOrderProductView> {
  BuildContext bcont;

  List orders = [];
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String productId;
  Map<String, String> heaaders = {};
  int len, le;
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

  Future<String> getJsonData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String url = 'https://www.a2zonlineshoppy.com/api/orders';

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');
    print("tocken");
    print(tock);
    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    check().then((intenet) async {
      if (intenet != null && intenet) {
        var response = await http.get(Uri.encodeFull(url), headers: heaaders);

        print("orders are");
        print(response.body);

        var mobiles = json.decode(response.body);

        var dat = mobiles["orders"];

        setState(() {
          orders = dat;
          len = dat == null ? 0 : dat.length;

          print("length is ");
          print(len);
        });
        return "success";
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
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
      return "success";
    });
  }

  @override
  Widget build(BuildContext context) {
    bcont = context;
    return ListView(
      children: <Widget>[
        Visibility(
          visible: len == null || len == 0 ? false : true,
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.grey.shade50,
            ),
            height: MediaQuery.of(context).size.height * .72,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: len,
              itemBuilder: (BuildContext context, int index) {
                return Single_order(
                  orderdate: orders[index]['created_at'],
                  ordertotal: orders[index]['ordertotalprice'],
                  ordernumber: orders[index]['ordernumber'],
                  orderid: orders[index]['_id'],
                  products: orders[index]['products'],
                );
              },
            ),
          ),
        ),
        Visibility(
          visible: len == null || len == 0 ? true : false,
          child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * .90,
              child: Text(
                'Your haven\'t placed any orders yet',
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              )),
        )
      ],
    );
  }
}

class Single_products extends StatelessWidget {
  final title;
  final picture;
  final rating;
  final id;
  final index;
  final status;
  final size;
  final qty;
  final cod;
  final color;
  final point;
  final price;
  final shippeddate;
  final fullfildate;
  final canceldate;
  final returndate;
  final createdat;

  Single_products({
    this.title,
    this.picture,
    this.rating,
    this.id,
    this.index,
    this.status,
    this.point,
    this.cod,
    this.size,
    this.qty,
    this.color,
    this.price,
    this.shippeddate,
    this.canceldate,
    this.fullfildate,
    this.returndate,
    this.createdat,
  });

  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    print(todayDate);
    print(formatDate(todayDate,
        [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
    return todayDate;
  }

  @override
  Widget build(BuildContext context) {
    int pr = price.round();
    var upr = (pr / qty).round();
    String clr;
    if (color == "") {
      clr = "default";
    } else {
      clr = color;
    }
    String fullfilformatdate,
        shipformatdate,
        cancelformatdate,
        returnformatdate;
    SharedPreferences sharedPreferences;

    bool iscancel, isreturn;
    var format = new DateFormat("dd-MM-yyyy");
    if (shippeddate != null) {
      var sdat = DateTime.parse(shippeddate);
      shipformatdate = format.format(sdat);
    }

    if (canceldate != null) {
      var cdat = DateTime.parse(canceldate);
      cancelformatdate = format.format(cdat);
    }

    if (returndate != null) {
      var rdat = DateTime.parse(returndate);
      returnformatdate = format.format(rdat);
    }

    if (fullfildate != null) {
      var fdat = DateTime.parse(fullfildate);
      fullfilformatdate = format.format(fdat);
    }

    if (status == "placed" || status == "processed" || status == "shipped") {
      var secondDate = new DateTime.now();
      var oneDay = 24 * 60 * 60 * 1000; // hours*minutes*seconds*milliseconds
      var firstDate = convertDateFromString(createdat);
      var dif =
          firstDate.millisecondsSinceEpoch - secondDate.millisecondsSinceEpoch;
      print("firstDate is ");
      print(firstDate);
      print("secondDate is ");
      print(secondDate);
      var diffDays = (((dif) / (oneDay))).round();
      print("days are ");
      print(diffDays);
      if (diffDays > 2) {
        iscancel = false;
      } else {
        iscancel = true;
      }
    } else {
      iscancel = false;
    }

    if (status == "fulfilled") {
      var secondDate = new DateTime.now();
      var oneDay = 24 * 60 * 60 * 1000;
      var firstDate = convertDateFromString(fullfildate);
      var dif =
          firstDate.millisecondsSinceEpoch - secondDate.millisecondsSinceEpoch;

      print("firstDate is ");
      print(firstDate);
      print("secondDate is ");
      print(secondDate);

      var diffDays = (((dif) / (oneDay))).round();

      if (diffDays > 2) {
        isreturn = false;
      } else {
        isreturn = true;
      }
    } else {
      isreturn = false;
    }

    return new Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
        child: Container(
          decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4.0,
                ),
              ],
              color: Colors.white,
              borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
              border: new Border.all(color: Colors.white)),
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.only(top: 0.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setString('productId', id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductView()));
                      },
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
                              '$title ($size) ($clr)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1,
                            ),
                            new Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  'Unit Price : ₹$upr',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                  textScaleFactor: 1,
                                )),
                            new Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Text(
                                  'Qty : $qty',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                  textScaleFactor: 1,
                                )),
                            Visibility(
                              visible: point != 0 ? true : false,
                              child: new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Point : $point',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                  )),
                            ),
                            Visibility(
                              visible: status == "placed" ? true : false,
                              child: new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Processing',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                  )),
                            ),
                            Visibility(
                              visible: status == "processed" ? true : false,
                              child: new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Packing',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                  )),
                            ),
                            Visibility(
                              visible: status == "shipped" ? true : false,
                              child: new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Shipped on $shipformatdate',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                  )),
                            ),
                            Visibility(
                              visible: status == "fulfilled" ? true : false,
                              child: new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Delivered on $fullfilformatdate',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                  )),
                            ),
                            Visibility(
                              visible: status == "cancelled" ? true : false,
                              child: new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Cancelled on $cancelformatdate',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                  )),
                            ),
                            Visibility(
                              visible: status == "returninit" ? true : false,
                              child: new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Return Initiated on $returnformatdate',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                  )),
                            ),
                            Visibility(
                              visible:
                                  status == "returncomplete" ? true : false,
                              child: new Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    'Returned to the Seller',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                    textScaleFactor: 1,
                                  )),
                            ),
                          ],
                        )),
                  )
                ],
              ),
              new Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                          visible: iscancel == true ? true : false,
                          child: Expanded(
                            child: new Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: RaisedButton(
                                    textColor: Colors.grey.shade800,
                                    color: Colors.grey.shade50,
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('confirm'),
                                            content: Text("Are you sure?"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Yes'),
                                                onPressed: () async {
                                                  sharedPreferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  Navigator.of(context).pop();
                                                  sharedPreferences =
                                                      await SharedPreferences
                                                          .getInstance();

                                                  sharedPreferences.setString(
                                                      "orderid", id);
                                                  sharedPreferences.setString(
                                                      "productindex",
                                                      index.toString());
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              CancelPage()));
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('No'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                          'Cancel',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1.2,
                                        )),
                                      ],
                                    )),
                              ),
                            ),
                          )),
                      Visibility(
                          visible: iscancel == true ? false : true,
                          child: Expanded(
                            child: new Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: RaisedButton(
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Failed'),
                                            content: Text(
                                                "You cannot cancel this order now."),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Ok'),
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    textColor: Colors.grey.shade800,
                                    color: Colors.grey.shade50,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                          'Cancel',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1.2,
                                        )),
                                      ],
                                    )),
                              ),
                            ),
                          )),
                      Expanded(
                          child: new Padding(
                              padding:
                                  const EdgeInsets.only(right: 0.0, left: 0.0),
                              child: ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: RaisedButton(
                                    textColor: Colors.grey.shade800,
                                    color: Colors.grey.shade50,
                                    onPressed: () async {
                                      sharedPreferences =
                                          await SharedPreferences.getInstance();

                                      sharedPreferences.setString(
                                          "orderid", id);
                                      sharedPreferences.setString(
                                          "productindex", index.toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TrackPage()));
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                          'Track',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1.2,
                                        ))
                                      ],
                                    )),
                              ))),
                      Visibility(
                          visible: isreturn == true ? true : false,
                          child: Expanded(
                            child: new Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: ButtonTheme(
                                minWidth: 100.0,
                                height: 50.0,
                                child: RaisedButton(
                                    textColor: Colors.grey.shade800,
                                    color: Colors.grey.shade50,
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('confirm'),
                                            content: Text("Are you sure?"),
                                            actions: <Widget>[
                                              FlatButton(
                                                child: Text('Yes'),
                                                onPressed: () async {
                                                  sharedPreferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  Navigator.of(context).pop();

                                                  sharedPreferences.setString(
                                                      "orderid", id);
                                                  sharedPreferences.setString(
                                                      "productindex",
                                                      index.toString());
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ReturnPage()));
                                                },
                                              ),
                                              FlatButton(
                                                child: Text('No'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                            child: Text(
                                          'Return',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 1.2,
                                        ))
                                      ],
                                    )),
                              ),
                            ),
                          )),
                      Visibility(
                          visible: isreturn == true ? false : true,
                          child: Expanded(
                            child: new Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: ButtonTheme(
                                  minWidth: 100.0,
                                  height: 50.0,
                                  child: RaisedButton(
                                      onPressed: () {
                                        showDialog<void>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Failed'),
                                              content: Text(
                                                  "You cannot return this order now."),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('Ok'),
                                                  onPressed: () async {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      disabledColor: Colors.grey.shade500,
                                      disabledTextColor: Colors.grey.shade50,
                                      textColor: Colors.grey.shade800,
                                      color: Colors.grey.shade50,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: Text(
                                            'Return',
                                            textAlign: TextAlign.center,
                                            textScaleFactor: 1.2,
                                          )),
                                        ],
                                      )),
                                )),
                          )),
                    ],
                  )),
            ],
          ),
        ));
  }
}

class Single_order extends StatelessWidget {
  final orderdate;
  final ordertotal;
  final ordernumber;
  final orderid;
  final products;

  Single_order({
    this.orderdate,
    this.ordertotal,
    this.ordernumber,
    this.orderid,
    this.products,
  });

  @override
  Widget build(BuildContext context) {
    var dat = DateTime.parse(orderdate);
    var format = new DateFormat("dd-MM-yyyy");
    int lent = products.length;
    print("length");
    print(lent);
    String formatdate = format.format(dat);

    return Container(
      height: (lent * 250.0),
      child: new Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      '#$ordernumber',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Placed On :$formatdate',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Total : ₹$ordertotal',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                    ),
                  ),
                ],
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 0.0, right: 6.0, left: 6.0),
                child: Container(
                  alignment: Alignment.center,
                  height: (lent * 210.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: lent,
                    itemBuilder: (BuildContext context, int index) {
                      return Single_products(
                        title: products[index]['title'],
                        size: products[index]['size'],
                        color: products[index]['color'],
                        picture:
                            'https://www.a2zonlineshoppy.com/public2/products/' +
                                products[index]['id'] +
                                'imageone.jpg',
                        price: products[index]['totalprice'],
                        id: orderid,
                        index: index,
                        status: products[index]['status'],
                        cod: products[index]['cod'],
                        point: products[index]['totalpoints'],
                        qty: products[index]['quantity'],
                        fullfildate: products[index]['fullfildate'],
                        canceldate: products[index]['canceldate'],
                        returndate: products[index]['returninitdate'],
                        shippeddate: products[index]['shippeddate'],
                        createdat: orderdate,
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
