import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackPackagePage extends StatefulWidget {
  @override
  _TrackPackagePageState createState() => _TrackPackagePageState();
}

class _TrackPackagePageState extends State<TrackPackagePage> {
  BuildContext bcont;

  List orders = [];
  SharedPreferences sharedPreferences;
  String name, orderid, index;
  String mobile;
  String productId;
  Map<String, String> heaaders = {};
  int len, le;

  String title;
  String picture;
  String rating;
  String id;
  String status;
  String size;
  int qty;
  String cod;
  String color;
  int point;
  int price;
  String shippeddate;
  String fullfildate;
  String canceldate;
  String returndate;
  String returninitdate;
  String returncompleteformatdate;
  String createdat;
  String imageurl;
  String clr, trackinglink;
  var trackingpoints;

  String fullfilformatdate, shipformatdate, cancelformatdate, returnformatdate;
  bool iscancel, isreturn;
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
      orderid = sharedPreferences.getString('packageid');
      index = sharedPreferences.getString('packageindex');
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
    final String url =
        'https://www.a2zonlineshoppy.com/api/trackpackage/$orderid/$index';

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    check().then((intenet) async {
      if (intenet != null && intenet) {
        var response = await http.get(Uri.encodeFull(url), headers: heaaders);

        print(" track response is ");
        print(response.body);

        var mobiles = json.decode(response.body);
        String message = mobiles["message"];

        var dat = mobiles["order"];

        if (message == "success") {
          setState(() {
            title = dat['name'];
            imageurl = dat['imageurl'];
            id = dat['id'];
            picture = 'https://www.a2zonlineshoppy.com/' + imageurl;
            print("picture");
            print(picture);
            status = dat['status'];
            size = dat['size'];
            qty = dat['qty'];
            color = dat['color'];
            point = dat['totalpoints'];
            price = int.parse(dat['price']);
            shippeddate = dat['shippeddate'];
            fullfildate = dat['fullfildate'];
            canceldate = dat['canceldate'];
            returndate = dat['returndate'];
            trackingpoints = dat['trackingpoints'];
            trackinglink = dat['trackinglink'];
            len = trackingpoints.length;
            print("length is ");
            print(len);

            if (color == "") {
              clr = "default";
            } else {
              clr = color;
            }

            var format = new DateFormat("dd-MM-yyyy");
            if (shippeddate != null) {
              var sdat = DateTime.parse(shippeddate);
              shipformatdate = format.format(sdat);
            }

            if (canceldate != null) {
              var cdat = DateTime.parse(canceldate);
              cancelformatdate = format.format(cdat);
            }

            if (returninitdate != null) {
              var rdat = DateTime.parse(returninitdate);
              returnformatdate = format.format(rdat);
            }

            if (returndate != null) {
              var rdat = DateTime.parse(returndate);
              returncompleteformatdate = format.format(rdat);
            }

            if (fullfildate != null) {
              var fdat = DateTime.parse(fullfildate);
              fullfilformatdate = format.format(fdat);
            }
          });
        } else {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text("Something went wrong, please try again!"),
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

  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    print(todayDate);
    print(formatDate(todayDate,
        [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
    return todayDate;
  }

  @override
  Widget build(BuildContext context) {
    bcont = context;

    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Track Order"),
      ),

      //Body
      body: Visibility(
        visible: title == null ? false : true,
        child: Container(
            height: MediaQuery.of(context).size.height * 1.0,
            child: ListView(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, bottom: 40.0, left: 40.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Visibility(
                            visible: picture == null ? false : true,
                            child: Image.network('$picture', height: 100.0),
                          ),
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
                                  '$title ($size)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                  textScaleFactor: 1,
                                ),
                                new Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      price == null
                                          ? "Price : "
                                          : 'Price : ₹' +
                                              (price / qty).toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1,
                                    )),
                                new Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      'Qty : ' + qty.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.start,
                                      textScaleFactor: 1,
                                    )),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: status == "placed" ? true : false,
                  child: new Container(
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      padding: const EdgeInsets.all(2.0),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),
                        ],
                        color: Colors.blue,
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(40.0)),
                      ),
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 7.0, bottom: 7.0),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Status : Order is being Procesed',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                            )),
                      )),
                ),
                Visibility(
                  visible: status == "shipped" ? true : false,
                  child: new Container(
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      padding: const EdgeInsets.all(2.0),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),
                        ],
                        color: Colors.blue,
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(40.0)),
                      ),
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 7.0, bottom: 7.0),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Status : Shipped on $shipformatdate',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                            )),
                      )),
                ),
                Visibility(
                  visible: status == "fulfilled" ? true : false,
                  child: new Container(
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      padding: const EdgeInsets.all(2.0),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),
                        ],
                        color: Colors.blue,
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(40.0)),
                      ),
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 7.0, bottom: 7.0),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Status : Delivered on $fullfilformatdate',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                            )),
                      )),
                ),
                Visibility(
                  visible: status == "returninit" ? true : false,
                  child: new Container(
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      padding: const EdgeInsets.all(2.0),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),
                        ],
                        color: Colors.blue,
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(40.0)),
                      ),
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 7.0, bottom: 7.0),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Status : Return Initiated on $returnformatdate',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                            )),
                      )),
                ),
                Visibility(
                  visible: status == "returncomplete" ? true : false,
                  child: new Container(
                      margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                      padding: const EdgeInsets.all(2.0),
                      decoration: new BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),
                        ],
                        color: Colors.blue,
                        borderRadius:
                            new BorderRadius.all(const Radius.circular(40.0)),
                      ),
                      child: new Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 7.0, bottom: 7.0),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Status : Returned to the Selleron $returncompleteformatdate',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                            )),
                      )),
                ),
                Visibility(
                  visible: trackingpoints == null ? false : true,
                  child: Container(
                    padding: EdgeInsets.only(top: 30.0),
                    margin: EdgeInsets.only(top: 15, bottom: 30.0),
                    decoration: new BoxDecoration(
                      color: Colors.grey.shade50,
                    ),
                    height: len == null ? 100 : (len * 120.0) + 100,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: len,
                      itemBuilder: (BuildContext context, int index) {
                        return Single_order(
                          place: trackingpoints[index]['place'],
                          date: trackingpoints[index]['ondate'],
                          index: index,
                          len: len,
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
      ),
      bottomSheet: Visibility(
          visible: trackinglink == null ? false : true,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: BottomAppBar(
                  child: ButtonTheme(
                    minWidth: 200.0,
                    height: 60.0,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        if (await canLaunch(trackinglink)) {
                          await launch(trackinglink);
                        } else {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text("Try again later or contact us!"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('ok'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: new Text(
                        "Track your order",
                        textScaleFactor: 1.2,
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

class Single_order extends StatelessWidget {
  final place;
  final date;
  final index;
  final len;

  Single_order({
    this.place,
    this.date,
    this.index,
    this.len,
  });

  @override
  Widget build(BuildContext context) {
    var dat = DateTime.parse(date);
    var format = new DateFormat("dd-MM-yyyy");
    String formatdate = format.format(dat);

    return index == len - 1
        ? Column(
            children: <Widget>[
              Text(
                '|',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                textScaleFactor: 2.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1.0,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                padding: const EdgeInsets.all(10.0),
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
                child: Column(
                  children: <Widget>[
                    Text(
                      '$place',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.5,
                    ),
                    Text(
                      '$formatdate',
                      style: TextStyle(color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                    ),
                  ],
                ),
              ),
              Text(
                '|',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                textScaleFactor: 2.5,
              ),
            ],
          )
        : Column(
            children: <Widget>[
              Text(
                '|',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                textScaleFactor: 2.5,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 1.0,
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                padding: const EdgeInsets.all(20.0),
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
                child: Column(
                  children: <Widget>[
                    Text(
                      '$place',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.5,
                    ),
                    Text(
                      '$formatdate',
                      style: TextStyle(color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
