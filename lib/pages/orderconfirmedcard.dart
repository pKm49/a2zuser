import 'package:a2zonlinshoppy/Home.dart';
import 'package:a2zonlinshoppy/components/singleconfirmedcardproductview.dart';

/// ListTile

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderConfirmedCard extends StatefulWidget {
  @override
  OrderConfirmedCardState createState() => OrderConfirmedCardState();
}

class OrderConfirmedCardState extends State<OrderConfirmedCard> {
  SharedPreferences sharedPreferences;
  Map<String, String> heaaders = {};
  String name;
  String mobile;
  int totalPrice = 0, totalQty = 0, len;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String url = 'https://www.a2zonlineshoppy.com/api/cart';

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');
    String total = sharedPreferences.getString('totalMrp');

    if (tock != null) {
      heaaders['authorization'] = "tocken " + tock;
    }
    print("cookie");
    print(cook);
    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    setState(() {
      totalPrice = int.parse(total);
    });
  }

  Icon _searchIcon = new Icon(Icons.search, color: Colors.white);
  Widget _appBarTitle = new Text('A2ZOnlineShoppy');
  final TextEditingController _filter = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.red,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Order Confirmed"),
        ),
        //Body
        body: Container(
          color: Colors.grey.shade50,
          height: MediaQuery.of(context).size.height * 1.0,
          child: SingleConfirmedCardProductView(),
        ),
        bottomSheet: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
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
                    color: Colors.grey,
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: new Text(
                        "Continue Shopping",
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
