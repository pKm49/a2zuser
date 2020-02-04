import 'dart:async';
import 'dart:convert';

import 'package:a2zonlinshoppy/pages/imageview.dart';
import 'package:a2zonlinshoppy/pages/productview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingleProductView extends StatefulWidget {
  @override
  _SingleProductViewState createState() => _SingleProductViewState();
}

class _SingleProductViewState extends State<SingleProductView> {
  List data;
  List pdts;
  SharedPreferences sharedPreferences;
  String name, picurl1, picurl2, picurl3;
  String mobile;
  String productId;
  String size;
  String color;
  String quantity;
  Map<String, String> heaaders = {};
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
    productId = sharedPreferences.getString('productId');
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    print("cookiessingleproduct");
    print(cook);

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
    final String url =
        'https://www.a2zonlineshoppy.com/api/product/getproduct/$productId/';

    check().then((intenet) async {
      if (intenet != null && intenet) {
        var response = await http.get(Uri.encodeFull(url), headers: heaaders);

        print("product is");
        print(response.body);
        var mobiles = json.decode(response.body);
        List tempdata = mobiles["product"];
        List tempcat = mobiles["cat"];

        final String purl1 =
            'https://www.a2zonlineshoppy.com/public2/products/' +
                tempdata[0]['_id'] +
                'imageone.jpg';
        var responsepic1 =
            await http.get(Uri.encodeFull(purl1), headers: heaaders);

        final String purl2 =
            'https://www.a2zonlineshoppy.com/public2/products/' +
                tempdata[0]['_id'] +
                'imagetwo.jpg';
        var responsepic2 =
            await http.get(Uri.encodeFull(purl2), headers: heaaders);

        final String purl3 =
            'https://www.a2zonlineshoppy.com/public2/products/' +
                tempdata[0]['_id'] +
                'imagethree.jpg';
        var responsepic3 =
            await http.get(Uri.encodeFull(purl3), headers: heaaders);

        setState(() {
          data = tempdata;
          pdts = tempcat;

          if (responsepic1.statusCode == 200) {
            picurl1 = purl1;
          } else {
            picurl1 = null;
          }

          if (responsepic2.statusCode == 200) {
            picurl2 = purl2;
          } else {
            picurl2 = null;
          }

          if (responsepic3.statusCode == 200) {
            picurl3 = purl3;
          } else {
            picurl3 = null;
          }
        });
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
    });

    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data == null ? false : true,
      child: Container(
        color: Colors.grey.shade50,
        padding: EdgeInsets.only(bottom: 70.0),
        height: MediaQuery.of(context).size.height * .94,
        child: Single_product(
            title: data[0]['title'],
            id: data[0]['_id'],
            picture1: picurl1,
            picture2: picurl2,
            picture3: picurl3,
            rating: data[0]['rating'],
            ratecount: data[0]['ratecount'],
            assuredpicture: 'images/cats/assured.png',
            oldprice: data[0]['oldPrice'],
            size: data[0]['size'] == null ? [] : data[0]['size'],
            color: data[0]['details'] == null ? [] : data[0]['details'],
            details: data[0]['description'],
            offerpercent: data[0]['a2zPrice'],
            newprice: data[0]['a2zMoney'] == null
                ? (data[0]['oldPrice'] -
                    ((data[0]['oldPrice'] * data[0]['a2zPrice']) / 100).round())
                : data[0]['a2zMoney'],
            cod: data[0]['cod'] == true ? 'cash on delivery available' : '',
            lispdts: pdts),
      ),
    );
  }
}

class Single_product extends StatelessWidget {
  final title;
  final id;
  final picture1;
  final picture2;
  final picture3;
  final rating;
  final ratecount;
  final assuredpicture;
  final oldprice;
  final offerpercent;
  final newprice;
  final size;
  final color;
  final cod;
  final details;
  final lispdts;

  Single_product({
    this.title,
    this.picture1,
    this.id,
    this.picture2,
    this.picture3,
    this.rating,
    this.ratecount,
    this.assuredpicture,
    this.oldprice,
    this.offerpercent,
    this.newprice,
    this.cod,
    this.size,
    this.color,
    this.details,
    this.lispdts,
  });

  void share() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String productid = sharedPreferences.getString('productId');

    Share.share(
        'Hey, Check out this product on A2ZOnlineShoppy! https://www.a2zonlineshoppy.com/product/getproduct/$productid');
  }

  @override
  Widget build(BuildContext context) {
    sizecolor();
    int oper = offerpercent.round();
    print("asdasd");
    return Container(
      child: new Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView(
            children: <Widget>[
              new Padding(
                  padding: const EdgeInsets.only(
                      top: 25.0, bottom: 25.0, left: 30.0, right: 30.0),
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    height: MediaQuery.of(context).size.height * .4,
                    child: InkWell(
                        onTap: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              'imagethree', '$picture3');
                          sharedPreferences.setString('imagetwo', '$picture2');
                          sharedPreferences.setString('imageone', '$picture1');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageView()));
                        },
                        child: Scrollbar(
                            child: ListView(
                          physics: PageScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Visibility(
                              visible: picture1 == null ? false : true,
                              child: Container(
                                  width: MediaQuery.of(context).size.width * .8,
                                  child: Image.network(picture1 == null
                                      ? 'https://a2zonlineshoppy.com/images/product.png'
                                      : picture1)),
                            ),
                            Visibility(
                                visible: picture2 == null ? false : true,
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .8,
                                    child: Image.network(picture2 == null
                                        ? 'https://a2zonlineshoppy.com/images/product.png'
                                        : picture2))),
                            Visibility(
                                visible: picture3 == null ? false : true,
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * .8,
                                    child: Image.network(picture3 == null
                                        ? 'https://a2zonlineshoppy.com/images/product.png'
                                        : picture3)))
                          ],
                        ))),
                  )),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$title',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                ),
              ),
              new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                        margin: const EdgeInsets.all(3.0),
                        padding: const EdgeInsets.all(2.0),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(5.0)),
                          border: new Border.all(color: Colors.red),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text('$rating  ',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15.0,
                            ),
                          ],
                        ),
                      ),
                      Text('($ratecount)   ', textAlign: TextAlign.center),
                      Image.asset(assuredpicture, height: 20.0),
                      new Container(
                          margin: const EdgeInsets.all(6.0),
                          padding: const EdgeInsets.all(4.0),
                          decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: new BorderRadius.all(
                                const Radius.circular(5.0)),
                            border: new Border.all(color: Colors.green),
                          ),
                          child: InkWell(
                            onTap: () {
                              share();
                            },
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  )),
              new Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '₹$newprice  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                      ),
                      Text(
                        '₹$oldprice',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.blueGrey,
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                      ),
                      Text(
                        '  $oper %off',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                      ),
                    ],
                  )),
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
                                                      fontWeight:
                                                          FontWeight.bold))
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
                                          title: Text('Choose color'),
                                          content: color.length == 0
                                              ? Text("Color: Default",
                                                  textScaleFactor: 1.2,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))
                                              : Color(
                                                  color: color,
                                                  leng: color.length,
                                                ));
                                    });
                              },
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    'Color',
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
                                                200.0, // Change as per your requirement
                                            width:
                                                10.0, // Change as per your requirement
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: <Widget>[
                                                ListTile(
                                                  onTap: () async {
                                                    SharedPreferences
                                                        sharedPreferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    sharedPreferences.setString(
                                                        'quantity', '1');
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text('1',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                                ListTile(
                                                  onTap: () async {
                                                    SharedPreferences
                                                        sharedPreferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    sharedPreferences.setString(
                                                        'quantity', '2');
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text('2',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center),
                                                ),
                                                ListTile(
                                                  onTap: () async {
                                                    SharedPreferences
                                                        sharedPreferences =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    sharedPreferences.setString(
                                                        'quantity', '3');
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text('3',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
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
                padding: const EdgeInsets.all(15.0),
                child: Text('$cod',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                    maxLines: 1,
                    textScaleFactor: 1.2,
                    textAlign: TextAlign.center),
              ),
              new Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Description',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.2,
                  )),
              new Padding(
                  padding:
                      const EdgeInsets.only(top: 12.0, right: 6.0, left: 6.0),
                  child: Text(
                    '$details',
                    style: TextStyle(color: Colors.grey.shade800),
                    textAlign: TextAlign.justify,
                    textScaleFactor: 1.1,
                  )),
              new Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Related Products',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.2,
                  )),
              new Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: Container(
                    height: 290.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (BuildContext context, int index) {
                        return Single_products(
                          title: lispdts[index]['title'],
                          picture:
                              'https://www.a2zonlineshoppy.com/public2/products/' +
                                  lispdts[index]['_id'] +
                                  'imageone.jpg',
                          rating: lispdts[index]['rating'],
                          id: lispdts[index]['_id'],
                          assuredpicture: 'images/cats/assured.png',
                          oldprice: lispdts[index]['oldPrice'],
                          offerpercent: lispdts[index]['a2zPrice'],
                          cod: lispdts[index]['cod'] == true
                              ? 'cash on delivery'
                              : '',
                          newprice: lispdts[index]['a2zMoney'] == null
                              ? (lispdts[index]['oldPrice'] -
                                  ((lispdts[index]['oldPrice'] *
                                              lispdts[index]['a2zPrice']) /
                                          100)
                                      .round())
                              : lispdts[index]['a2zMoney'],
                        );
                      },
                    ),
                  )),
              BottomAppBar()
            ],
          )),
    );
  }

  void sizecolor() async {
    print(size.length);
    print(color.length);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (size.length == 0) {
      sharedPreferences.setString('size', 'default');
    }
    if (size.length == 1) {
      print("seize daa");
      print(size[0]);
      if (size[0] == "") {
        sharedPreferences.setString('size', 'default');
      } else {
        sharedPreferences.setString('size', size[0]);
      }
    }

    if (size.length == 2) {
      if (size[1] == "") {
        sharedPreferences.setString('size', size[0]);
      }
    }

    if (color.length == 0) {
      sharedPreferences.setString('color', 'default');
    }
    if (color.length == 1) {
      print("seize daa");
      print(color[0]);

      if (color[0] == "") {
        sharedPreferences.setString('color', 'default');
      } else {
        sharedPreferences.setString('color', color[0]);
      }
    }

    if (color.length == 2) {
      if (color[1] == "") {
        sharedPreferences.setString('color', color[0]);
      }
    }
  }
}

class Single_products extends StatelessWidget {
  final title;
  final picture;
  final rating;
  final id;
  final assuredpicture;
  final oldprice;
  final offerpercent;
  final newprice;
  final cod;

  Single_products({
    this.title,
    this.picture,
    this.rating,
    this.id,
    this.assuredpicture,
    this.oldprice,
    this.offerpercent,
    this.newprice,
    this.cod,
  });

  @override
  Widget build(BuildContext context) {
    String titl = title.length < 20 ? title : title.substring(0, 20) + '...';
    int op = oldprice.round();
    int np = newprice.round();
    int oper = offerpercent.round();
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('productId', id);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProductView()));
        },
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
            padding: const EdgeInsets.all(8.0),
            width: 200.0,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new CachedNetworkImage(
                        imageUrl: "$picture",
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        height: MediaQuery.of(context).size.height * .15,
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      )),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text('$titl',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                        margin: const EdgeInsets.all(3.0),
                        padding: const EdgeInsets.all(2.0),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(5.0)),
                          border: new Border.all(color: Colors.red),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text('$rating  ',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 15.0,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(assuredpicture, height: 20.0)
                    ],
                  ),
                  new Container(
                      margin: const EdgeInsets.all(3.0),
                      padding: const EdgeInsets.all(2.0),
                      decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(40.0)),
                          border: new Border.all(color: Colors.blueAccent)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('   ₹$np ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          Text('₹$op',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.blueGrey),
                              textAlign: TextAlign.center),
                          Text(
                            '  $oper %off   ',
                            style: TextStyle(color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                  new Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text('$cod',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green),
                        maxLines: 1,
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            )),
      ),
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
              title = "Default";
            } else {
              title = widget.siz[index];
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
}

class Color extends StatefulWidget {
  final color;
  final leng;

  const Color({Key key, this.color, this.leng}) : super(key: key);

  @override
  _ColorState createState() => _ColorState();
}

class _ColorState extends State<Color> {
  String colorchanged, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.leng * 50.0,
      decoration: new BoxDecoration(
          color: Colors.grey.shade200,
          border: new Border.all(color: Colors.grey, width: 1.0)),
      width: MediaQuery.of(context).size.width * .7,
      // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.leng,
        itemBuilder: (BuildContext context, int index) {
          if (widget.leng == 1) {
            if (widget.color[index] == "") {
              title = "Default";
            } else {
              title = widget.color[index].length <= 17
                  ? widget.color[index]
                  : widget.color[index].substring(0, 12);
            }
            colorchanged = title;
          } else if (widget.leng == 2) {
            print("asd");
            if (widget.color[index] == "") {
              return null;
            } else {
              print("asd");
              title = widget.color[index].length <= 17
                  ? widget.color[index]
                  : widget.color[index].substring(0, 12);
              return Row(
                children: <Widget>[
                  new Radio(
                    onChanged: (String str) => onsizechange(str),
                    value: title,
                    groupValue: title,
                  ),
                  new Text(title),
                ],
              );
            }
          } else if (widget.leng == 3) {
            print("asd");
            if (widget.color[index] == "") {
              return null;
            } else {
              print("asd");
              title = widget.color[index].length <= 17
                  ? widget.color[index]
                  : widget.color[index].substring(0, 12);
              return Row(
                children: <Widget>[
                  new Radio(
                    onChanged: (String str) => onsizechange(str),
                    value: title,
                    groupValue: title,
                  ),
                  new Text(title),
                ],
              );
            }
          } else {
            title = widget.color[index].length <= 17
                ? widget.color[index]
                : widget.color[index].substring(0, 12);
          }
          return Row(
            children: <Widget>[
              new Radio(
                onChanged: (String str) => onsizechange(str),
                value: title,
                groupValue: colorchanged,
              ),
              new Text(title),
            ],
          );
        },
      ),
    );
  }

  void onsizechange(String tile) async {
    setState(() {
      colorchanged = tile;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('color', tile);
    print('color');
    print(sharedPreferences.getString('color'));
    Navigator.of(context).pop();
  }
}
