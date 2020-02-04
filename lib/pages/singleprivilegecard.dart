import 'dart:convert';

import 'package:a2zonlinshoppy/pages/businesscart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SinglePrivilegeCard extends StatefulWidget {
  @override
  _SinglePrivilegeCardState createState() => _SinglePrivilegeCardState();
}

class _SinglePrivilegeCardState extends State<SinglePrivilegeCard> {
  SharedPreferences sharedPreferences;
  String name, cardname, cardphoto, cardtext;
  String mobile, id;
  int cardprice, bv, qtychanged = 1, qty;
  Map<String, String> heaaders = {};
  var card, size;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  void isSignedIN() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String scard = sharedPreferences.getString('card');
    sharedPreferences.setString('quantity', qtychanged.toString());

    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');
      card = json.decode(scard);
      size = card["size"];
      cardname = card["name"];
      id = card["_id"];
      cardtext = card["description"];
      cardprice = card["offerprice"];
      bv = card["bv"];
      String tempurl = card["imageurl"];
      int index = tempurl.lastIndexOf("/");
      String yourCuttedString = tempurl.substring(index + 1, tempurl.length);
      cardphoto =
          "https://www.a2zonlineshoppy.com/public2/cards/" + yourCuttedString;
      print(cardphoto);
    });

    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("A2Z Business Starting Package"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.business_center, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BusinessCart()));
              })
        ],
      ),

      //Body
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 15.0, right: 8.0, left: 8.0),
            child: new Text(
              '$cardname ',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              textScaleFactor: 1.3,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 15.0, right: 8.0, left: 8.0),
            child: new Text(
              'BV : $bv ',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              textScaleFactor: 1.3,
            ),
          ),
          new Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: Text(
                      '',
                      style: TextStyle(color: Colors.transparent),
                    )),
                height: 260.0,
                decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4.0,
                    ),
                  ],
                  borderRadius:
                      new BorderRadius.all(const Radius.circular(5.0)),
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    fit: BoxFit.contain,
                    image: new NetworkImage(cardphoto, scale: .5),
                  ),
                ),
              )),
          new Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '     $cardtext ',
                textAlign: TextAlign.justify,
                textScaleFactor: 1.25,
              )),
          new Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 8.0, right: 8.0, left: 8.0),
            child: new Text(
              'Price : ₹$cardprice',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              textScaleFactor: 1.3,
            ),
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
                                      title: Text('Choose size'),
                                      content: size.length == 0
                                          ? Text("Size: Default",
                                              textScaleFactor: 1.2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold))
                                          : Size(
                                              siz: size,
                                              len: size.length,
                                            ));
                                });
                          },
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                'Size',
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
                                            180.0, // Change as per your requirement
                                        width:
                                            5.0, // Change as per your requirement
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Container(
                                              decoration: new BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  border: new Border.all(
                                                      color: Colors.grey,
                                                      width: 1.0)),
                                              child: Row(
                                                children: <Widget>[
                                                  new Radio(
                                                    onChanged: (int num) =>
                                                        onqtychang(num),
                                                    value: 1,
                                                    groupValue: qtychanged,
                                                  ),
                                                  new Text('1'),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: new BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  border: new Border.all(
                                                      color: Colors.grey,
                                                      width: 1.0)),
                                              child: Row(
                                                children: <Widget>[
                                                  new Radio(
                                                    onChanged: (int num) =>
                                                        onqtychang(num),
                                                    value: 2,
                                                    groupValue: qtychanged,
                                                  ),
                                                  new Text('2'),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: new BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  border: new Border.all(
                                                      color: Colors.grey,
                                                      width: 1.0)),
                                              child: Row(
                                                children: <Widget>[
                                                  new Radio(
                                                    onChanged: (int num) =>
                                                        onqtychang(num),
                                                    value: 3,
                                                    groupValue: qtychanged,
                                                  ),
                                                  new Text('3'),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                });
                          },
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Text(
                                'Qty',
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.2,
                              )),
                              Expanded(
                                child: Icon(Icons.arrow_drop_down),
                              )
                            ],
                          )),
                    ),
                  )
                ],
              )),
          new Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 8.0, right: 8.0, left: 8.0),
            child: new Text(
              '( Price Includes all taxes. Delivery charges, if applicable,  will be added on Checkout)',
              textScaleFactor: 1.1,
              textAlign: TextAlign.center,
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(15.0),
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
                borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
              ),
              child: ButtonTheme(
                minWidth: 200.0,
                height: 60.0,
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () {
                    addtocart();
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  child: new Text(
                    "Add to Bag",
                    textScaleFactor: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onqtychang(int tile) async {
    setState(() {
      qtychanged = tile;
      print("qty is");
      print(tile.toString());
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('quantity', tile.toString());

    Navigator.of(context).pop();
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

  void addtocart() async {
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
        final String urladd =
            'https://www.a2zonlineshoppy.com/api/addtobusinesscart';
        String message1 = "";
        String message2 = "";
        String message3 = "";
        String name;
        String mobile;
        String cook;
        String tock;
        String size;
        String color;
        String csrf;
        String cod;
        String products;
        String quantity;
        String productid;
        sharedPreferences = await SharedPreferences.getInstance();
        cook = sharedPreferences.getString('Cookie');
        tock = sharedPreferences.getString('tocken');
        size = sharedPreferences.getString('size');
        csrf = sharedPreferences.getString('csrf');
        quantity = sharedPreferences.getString('quantity');
        productid = id;
        print("cookiesproduct");
        print(cook);
        if (size == null) {
          message1 = "size is empty";
        } else {
          message1 = "ok";
        }

        if (quantity == null) {
          message2 = "quantity is empty";
        } else {
          message2 = "ok";
        }

        if (tock != null) {
          heaaders['authorization'] = "tocken " + tock;
        }

        heaaders['Accept'] = "application/JSON";
        heaaders['Cookie'] = cook;

        if (message1 == "ok" && message2 == "ok") {
          dynamic mybody = {
            'size': '$size',
            'color': '$color',
            'qty': '$quantity',
            'id': '$productid',
            '_csrf': '$csrf'
          };

          print('size');
          print('$size');
          print('quantity');
          print('$quantity');
          print('id');
          print('$productid');

          var response = await http.post(Uri.encodeFull(urladd),
              headers: heaaders, body: mybody);

          print(response.body);

          var bod = json.decode(response.body);
          var message = bod["message"];

          print("addtocart");
          print(message);

          if (message == "error") {
            Navigator.of(context).pop();

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
          } else {
            Navigator.of(context).pop();
            sharedPreferences.remove("size");
            sharedPreferences.remove("quantity");
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Success'),
                  content: Text("Added to cart Successfully!"),
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
        } else {
          Navigator.of(context).pop();

          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Empty Fields'),
                content: Text(message1 + "\n" + message2),
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
}

class Single_products extends StatelessWidget {
  final title;
  final picture;
  final price;
  final card;

  Single_products({
    this.title,
    this.picture,
    this.price,
    this.card,
  });

  @override
  Widget build(BuildContext context) {
    String tempurl = picture;
    int index = tempurl.lastIndexOf("/");
    String yourCuttedString = tempurl.substring(index + 1, tempurl.length);
    String cardphoto =
        "https://www.a2zonlineshoppy.com/public2/cards/" + yourCuttedString;
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
          margin: const EdgeInsets.only(
              top: 10.0, bottom: 10.0, left: 4.0, right: 4.0),
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width * .80,
          height: MediaQuery.of(context).size.height * .5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    '$title (₹$price)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.3,
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new CachedNetworkImage(
                        imageUrl: "$cardphoto",
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        height: MediaQuery.of(context).size.height * .25,
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ))),
              Expanded(
                flex: 2,
                child: new Padding(
                  padding: const EdgeInsets.all(15.0),
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
                        onPressed: () async {
                          SharedPreferences sharedPreferences;
                          sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              "card", json.encode(card));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SinglePrivilegeCard()));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        child: new Text(
                          "Learn More",
                          textScaleFactor: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class Size extends StatefulWidget {
  final siz;
  final len;

  const Size({Key key, this.siz, this.len}) : super(key: key);

  @override
  _SizeState createState() => _SizeState();
}

class _SizeState extends State<Size> {
  String sizechanged, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          color: Colors.grey.shade200,
          border: new Border.all(color: Colors.grey, width: 1.0)),
      height: widget.len * 50.0,
      width: MediaQuery.of(context).size.width * .7,
      // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.len,
        itemBuilder: (BuildContext context, int index) {
          if (widget.len == 1) {
            if (widget.siz[index] == "") {
              setsize("Default");
              title = "Default";
            } else {

              title = widget.siz[index];
              setsize(title);
            }
            sizechanged = title;
          } else if (widget.len == 2) {
            if (widget.siz[index] == "") {
              return null;
            } else {
              title = widget.siz[index];
              return Row(
                children: <Widget>[
                  new Radio(
                    onChanged: (String str) => onsizechang(str),
                    value: title,
                    groupValue: title,
                  ),
                  new Text(title),
                ],
              );
            }
          } else {
            title = widget.siz[index];
          }

          return Row(
            children: <Widget>[
              new Radio(
                onChanged: (String str) => onsizechang(str),
                value: title,
                groupValue: sizechanged,
              ),
              new Text(title),
            ],
          );
        },
      ),
    );
  }

  void onsizechang(String tile) async {
    setState(() {
      sizechanged = tile;
      print(sizechanged);
    });
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('size', '$tile');
    print(sharedPreferences.getString('size'));
    Navigator.of(context).pop();
  }

  Future setsize(String s) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('size', '$s');
  }
}
