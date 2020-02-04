/// ListTile

import 'package:flutter/material.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/components/singleconfirmedproductview.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/Home.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:a2zonlinshoppy/pages/searchresults.dart';


class OrdeCancelledCard extends StatefulWidget {
  @override
  OrdeCancelledCardState createState() => OrdeCancelledCardState();
}

class OrdeCancelledCardState extends State<OrdeCancelledCard> {

  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);
  Widget _appBarTitle = new Text( 'A2ZOnlineShoppy' );
  final TextEditingController _filter = new TextEditingController();

  SharedPreferences sharedPreferences;
  String cardname;
  int baseprice;
  var card;
  Map<String, String> heaaders = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }


  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onSubmitted: searchresults,
          style: new TextStyle(color: Colors.white),
          controller: _filter,
          decoration: new InputDecoration(
              hintStyle: TextStyle(color: Colors.grey.shade50),
              prefixIcon: new Icon(Icons.search,color: Colors.white),
              hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search,color: Colors.white);
        this._appBarTitle = new Text('A2ZOnlineShoppy');

      }
    });
  }
  void searchresults(String key) async {

    sharedPreferences.setString('searchkey',key);

    Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchResults()) );

  }

  void isSignedIN() async{
    sharedPreferences = await SharedPreferences.getInstance();

    final String urlbuy = 'https://www.a2zonlineshoppy.com/api/buynow';
    String cards = sharedPreferences.getString('card');
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');
        if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    setState(() {

      card = json.decode(cards);
      cardname = card["name"];
      baseprice = card["baseprice"];

      print("card");
      print(card);
      print(cardname);
      print(baseprice);

    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  new AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Order Cancelled"),
      ),


      //Body
      body: Container(
        alignment: Alignment.center,
        color: Colors.grey.shade100,
        height: MediaQuery.of(context).size.height *1.0,
          child: ListView(
            children: <Widget>[
              new Padding(padding: const EdgeInsets.all(8.0),child:
              Text("You order has been cancelled",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.2)),
              new Padding(padding: const EdgeInsets.all(8.0),child:
              Text("$cardname card",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.4)),
              new Padding(padding: const EdgeInsets.all(6.0),child:
              new CachedNetworkImage(
                imageUrl: "https://a2zonlineshoppy.com/public2/cards/diamond.jpg",
                height: MediaQuery.of(context).size.height *.30,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.all(15.0),child:
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child:Text("Total:",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1.5,)),
                      Expanded(
                          flex: 1,
                          child:Text("₹$baseprice",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.end,textScaleFactor: 1.5)
                      ),
                    ],
                  )),

                ],
              ),

              new Padding(padding: const EdgeInsets.all(8.0),child:
              Text("Our Executives will contact you soon for further proceedings",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.2)),

              ButtonTheme(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                minWidth: 100.0,
                height: MediaQuery.of(context).size.height *.08,
                child:
                new Padding(padding: const EdgeInsets.all(5.0),child:
                RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: (){

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()) );

                    },
                    child: Text('Continue Shopping',textAlign: TextAlign.center,textScaleFactor: 1.5,)
                )),
              )
            ],
          ),
      ),


    );
  }


}




