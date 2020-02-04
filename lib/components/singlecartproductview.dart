import 'dart:async';
import 'dart:convert';

import 'package:a2zonlinshoppy/pages/addresspage.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/pages/productview.dart';
import 'package:a2zonlinshoppy/pages/useraddresspage.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingleCartProductView extends StatefulWidget {
  @override
  _SingleCartProductViewState createState() => _SingleCartProductViewState();
}

class _SingleCartProductViewState extends State<SingleCartProductView> {
  BuildContext bcont;
  List data;
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String productId;
  Map<String, String> heaaders = {};
  int totalPrice = 0, totalQty = 0, len;

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
    final String url = 'https://www.a2zonlineshoppy.com/api/cart';

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }
    print("cookie");
    print(cook);
    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    check().then((intenet) async {
      if (intenet != null && intenet) {
        var response = await http.get(Uri.encodeFull(url), headers: heaaders);

        print(response.body);

        var mobiles = json.decode(response.body);

        print("prods");
        print(mobiles["products"]);
        setState(() {
          data = mobiles["products"];
          print("specs");
          print(mobiles["totalMrp"]);
          len = data == null ? 0 : data.length;
          totalPrice = mobiles["totalPrice"];
          totalQty = mobiles["totalQty"];
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
      // No-Internet Case
    });
  }

  @override
  Widget build(BuildContext context) {
    bcont = context;
    return ListView(
      children: <Widget>[
        Visibility(
          visible: totalQty == 0 ? false : true,
          child: Column(
            children: <Widget>[
              Container(
                decoration: new BoxDecoration(
                  color: Colors.grey.shade50,
                ),
                padding: EdgeInsets.only(bottom: 0.0),
                height: (MediaQuery.of(context).size.height * .9) - 135.0,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: len,
                  itemBuilder: (BuildContext context, int index) {
                    return Single_products(
                        title: data[index]['title'],
                        size: data[index]['size'],
                        color: data[index]['color'],
                        picture:
                            'https://www.a2zonlineshoppy.com/public2/products/' +
                                data[index]['id'] +
                                'imageone.jpg',
                        price: data[index]['price'],
                        id: data[index]['id'],
                        cod: data[index]['cod'],
                        point: data[index]['point'],
                        qty: data[index]['qty']);
                  },
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: totalQty == 0 ? true : false,
          child: Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 1.0,
              child: Text(
                'Your Cart is Empty',
                textAlign: TextAlign.center,
                textScaleFactor: 1.5,
              )),
        )
      ],
    );
  }

  void checkout() async {
    String cook;
    String tock;
    String cod;
    String products;
    final String urlbuy = 'https:/www.a2zonlineshoppy.com/api/checkout';
    String message1 = "";
    String message2 = "";
    String message3 = "";
    sharedPreferences = await SharedPreferences.getInstance();
    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    var response = await http.get(
      Uri.encodeFull(urlbuy),
      headers: heaaders,
    );

    print(response.body);

    var bod = json.decode(response.body);
    String message = bod["message"];

    print("checkout");
    print(bod);

    if (message == "error") {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text("Something went wrong, try again."),
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
    } else if ((message == "success")) {
      setState(() {
        cod = bod["cod"].toString();
        products = json.encode(bod["products"]);
      });

      sharedPreferences.setString('cod', cod);
      sharedPreferences.setString('products', products);

      if (name == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddressPage()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserAddressPage()));
      }
    }
  }
}

class Single_products extends StatelessWidget {
  final title;
  final picture;
  final rating;
  final id;
  final size;
  final qty;
  final cod;
  final color;
  final point;
  final price;

  Single_products({
    this.title,
    this.picture,
    this.rating,
    this.id,
    this.point,
    this.cod,
    this.size,
    this.qty,
    this.color,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    int pr = price.round();
    int upr = (pr / qty).round();
    String clr;
    if (color == "") {
      clr = "default";
    } else {
      clr = color;
    }
    return new Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 2.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
                border: new Border.all(color: Colors.white)),
            margin: const EdgeInsets.only(top: 5.0, left: 4.0, right: 4.0),
            padding: const EdgeInsets.only(top: 15.0),
            width: MediaQuery.of(context).size.width * .80,
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
                                style: TextStyle(color: Colors.grey.shade800),
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.2,
                              ),
                              Visibility(
                                visible: qty != 1 ? true : false,
                                child: new Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      'Unit Price : ₹$upr',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade800),
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1,
                                    )),
                              ),
                              Visibility(
                                visible: point != 0 ? true : false,
                                child: new Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      'Points : $point',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1,
                                    )),
                              ),
                              Visibility(
                                  visible: cod == true ? true : false,
                                  child: new Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        'cash on delivery available',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                        textScaleFactor: 1,
                                      ))),
                            ],
                          )),
                    )
                  ],
                ),
                new Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: RaisedButton(
                                textColor: Colors.grey.shade700,
                                color: Colors.white,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Text('Quantity',
                                                textAlign: TextAlign.center),
                                            content: Container(
                                              alignment: Alignment.center,
                                              height:
                                                  200.0, // Change as per your requirement
                                              width:
                                                  10.0, // Change as per your requirement
                                              child: ListView(
                                                shrinkWrap: true,
                                                children: <Widget>[
                                                  ListTile(
                                                    onTap: () async {
                                                      changeqty(1, context);
                                                    },
                                                    title: Text('1',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                  ListTile(
                                                    onTap: () async {
                                                      changeqty(2, context);
                                                    },
                                                    title: Text('2',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                  ListTile(
                                                    onTap: () async {
                                                      changeqty(3, context);
                                                    },
                                                    title: Text('3',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ),
                                                ],
                                              ),
                                            ));
                                      });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      '$qty',
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.2,
                                    )),
                                    Expanded(
                                      child: Icon(Icons.arrow_drop_down),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        Expanded(
                          child: ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: RaisedButton(
                                textColor: Colors.blue,
                                color: Colors.white,
                                onPressed: () {},
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      '₹$pr',
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.2,
                                    ))
                                  ],
                                )),
                          ),
                        ),
                        Expanded(
                          child: ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: RaisedButton(
                                textColor: Colors.grey.shade700,
                                color: Colors.white,
                                onPressed: () {
                                  remove(id, context);
                                },
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      'Delete',
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 1.2,
                                    ))
                                  ],
                                )),
                          ),
                        ),
                      ],
                    )),
              ],
            )));
  }

  void remove(id, context) async {
    print("idada");
    print(id);
    print(size);
    print(color);
    SharedPreferences sharedPreferences;

    Map<String, String> heaaders = {};
    sharedPreferences = await SharedPreferences.getInstance();
    var csrf = sharedPreferences.getString('csrf');
    var cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    final String url =
        'https://www.a2zonlineshoppy.com/api/removeone?id=$id&size=$size&color=$color';
    dynamic mybody = {
      'size': '$size',
      'color': '$color',
      'id': '$id',
      '_csrf': '$csrf'
    };

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }
    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
    var response = await http.get(
      Uri.encodeFull(url),
      headers: heaaders,
    );
    print(response.body);

    var mobiles = json.decode(response.body);
    print('message');
    print(mobiles["message"]);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Cart()));
  }

  void changeqty(qy, context) async {
    print("idada");
    print(id);
    print(size);
    print(color);
    SharedPreferences sharedPreferences;

    Map<String, String> heaaders = {};
    sharedPreferences = await SharedPreferences.getInstance();
    var csrf = sharedPreferences.getString('csrf');
    var cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    final String url =
        'https://www.a2zonlineshoppy.com/api/changeqty?id=$id&size=$size&color=$color&qty=$qy';
    dynamic mybody = {
      'size': '$size',
      'color': '$color',
      'id': '$id',
      '_csrf': '$csrf'
    };

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }
    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
    var response = await http.get(
      Uri.encodeFull(url),
      headers: heaaders,
    );
    print(response.body);

    var mobiles = json.decode(response.body);
    print('message');
    print(mobiles["message"]);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Cart()));
  }
}
