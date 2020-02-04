import 'dart:async';
import 'dart:convert';

import 'package:a2zonlinshoppy/pages/singleprivilegecard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingleCardView extends StatefulWidget {
  @override
  _SingleCardViewState createState() => _SingleCardViewState();
}

class _SingleCardViewState extends State<SingleCardView> {
  var showcard;
  List cards;
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String productId;
  String size;
  String color, description;
  String quantity;
  double hght;
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
    final String url = 'https://www.a2zonlineshoppy.com/api/cards';

    check().then((intenet) async {
      if (intenet != null && intenet) {
        var response = await http.get(Uri.encodeFull(url), headers: heaaders);

        print("product is");
        print(response.body);

        setState(() {
          var mobiles = json.decode(response.body);
          cards = mobiles["cards"];
          showcard = mobiles["showcard"];
          description = showcard[0]["description"];
          hght = (MediaQuery.of(context).size.height * .522 * (cards.length)) +
              (30.0 * cards.length) +
              (MediaQuery.of(context).size.height * .2) +
              75.0;
        });

        return "success";
        // Internet Present Case
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
      return "success"; // No-Internet Case
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: cards == null ? false : true,
      child: new Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Container(
            height: (MediaQuery.of(context).size.height * 1.0),
            child: new Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: StaggeredGridView.countBuilder(
                scrollDirection: Axis.vertical,
                itemCount: cards == null ? 0 : cards.length,
                crossAxisCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return Single_products(
                    title: cards[index]['name'],
                    picture: cards[index]['imageurl'],
                    price: cards[index]['offerprice'],
                    bv: cards[index]['bv'],
                    card: cards[index],
                  );
                },
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(1, 1.4),
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
              ),
            ),
          )),
    );
  }
}

class Single_products extends StatelessWidget {
  final title;
  final picture;
  final price;
  final bv;
  final card;

  Single_products({
    this.title,
    this.picture,
    this.price,
    this.bv,
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
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () async {
          SharedPreferences sharedPreferences;
          sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString("card", json.encode(card));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SinglePrivilegeCard()));
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
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width * .80,
            height: MediaQuery.of(context).size.height * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                  flex: 1,
                  child: new Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: new Text(
                          '$title',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                        ),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: new Container(
                      margin: const EdgeInsets.all(3.0),
                      padding: const EdgeInsets.all(2.0),
                      decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(40.0)),
                          border: new Border.all(color: Colors.blueAccent)),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' ₹$price  ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      )),
                ),
                Expanded(
                  flex: 1,
                  child: new Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: new Text(
                      'BV : $bv',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.1,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
