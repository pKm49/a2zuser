import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//appspecific imports

import  'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/addresspage.dart';
import 'package:a2zonlinshoppy/pages/useraddresspage.dart';
import 'package:a2zonlinshoppy/components/singleproductview.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'dart:convert';
import 'package:a2zonlinshoppy/pages/searchresults.dart';

class ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {

  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);

  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String cook ;
  String tock ;
  String size ;
  String color ;
  String csrf ;
  String cod ;
  String products ;
  String quantity ;
  String productid ;
  Map<String, String> heaaders = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  void isSignedIN() async{
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


  void addtocart() async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  new Dialog(
            child:  Container(
                color: Colors.transparent,
                height: 200.0,
                width: 100.0,
                child:
                Center(
                  child: CircularProgressIndicator(),
                )
            ),
          );
        }
    );

    check().then((intenet) async{
      if (intenet != null && intenet) {
          final String urladd = 'https://www.a2zonlineshoppy.com/api/addtocart';
          String message1 = "";
          String message2 = "";
          String message3 = "";
          sharedPreferences = await SharedPreferences.getInstance();
          cook = sharedPreferences.getString('Cookie');
          tock = sharedPreferences.getString('tocken');
          size = sharedPreferences.getString('size');
          color = sharedPreferences.getString('color');
          csrf = sharedPreferences.getString('csrf');
          quantity = sharedPreferences.getString('quantity');
          productid = sharedPreferences.getString('productId');
          print("cookiesproduct");
          print(cook);
          if(size == null){
            message1 = "size can't be empty";
          }else{
            message1 = "ok";
          }

          if(color == null){
            message2 = "color can't be empty";
          }else{
            message2 = "ok";
          }

          if(quantity == null){
            quantity = '1';
          }

          if(tock!=null){
            heaaders['authorization'] = "tocken "+tock;
          }

          heaaders['Accept'] = "application/JSON";
          heaaders['Cookie'] = cook;

          if(message1 == "ok" && message2 =="ok"){
            dynamic mybody = {'size': '$size','color': '$color', 'qty': '$quantity', 'id': '$productid','_csrf':'$csrf'};

            print('size');
            print('$size');
            print('color');
            print('$color');
            print('quantity');
            print('$quantity');
            print('id');
            print('$productid');

            var response = await http.post(
                Uri.encodeFull(urladd),
                headers: heaaders,
                body:mybody
            );

            print(response.body);

            var bod = json.decode(response.body);
            var message = bod["message"];


            print("addtocart");
            print(message);

            if(message=="error"){
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
            }else{
              Navigator.of(context).pop();

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

          }else{
            Navigator.of(context).pop();

            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Empty Fields'),
                  content: Text(message1+"\n"+message2),
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
      }else{
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


  void buynow() async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return  new Dialog(
            child:  Container(
                color: Colors.transparent,
                height: 200.0,
                width: 100.0,
                child:
                Center(
                  child: CircularProgressIndicator(),
                )
            ),
          );
        }
    );

    check().then((intenet) async{
      if (intenet != null && intenet) {
          final String urlbuy = 'https://www.a2zonlineshoppy.com/api/buynow';
          String message1 = "";
          String message2 = "";
          String message3 = "";
          sharedPreferences = await SharedPreferences.getInstance();
          cook = sharedPreferences.getString('Cookie');
          tock = sharedPreferences.getString('tocken');
          size = sharedPreferences.getString('size');
          color = sharedPreferences.getString('color');
          csrf = sharedPreferences.getString('csrf');
          quantity = sharedPreferences.getString('quantity');
          productid = sharedPreferences.getString('productId');

          print("csrf");
          print(csrf);

          print("cook");
          print(cook);

          print("tock");
          print(tock);

          if(size == null){
            message1 = "size can't be empty";
          }else{
            message1 = "ok";
          }

          if(color == null){
            message2 = "color can't be empty";
          }else{
            message2 = "ok";
          }

          if(quantity == null){
            quantity = '1';
          }

          if(tock!=null){
            heaaders['authorization'] = "tocken "+tock;
          }

          heaaders['Accept'] = "application/JSON";
          heaaders['Cookie'] = cook;

          if(message1 == "ok" && message2 =="ok"){
            dynamic mybody = {'size': '$size','color': '$color', 'qty': '$quantity', 'id': '$productid', '_csrf': '$csrf'};

            var response = await http.post(
                Uri.encodeFull(urlbuy),
                headers: heaaders,
                body:mybody
            );

            print(response.body);

            var bod = json.decode(response.body);
            String message = bod["message"];

            print("buynow");
            print(bod);

            if(message=="error"){
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
            }else if((message=="success")){
              setState(() {
                cod = bod["cod"].toString();
                products = json.encode(bod["products"]);
              });

              print("codelivey");
              print(cod);

              print("productsare");
              print(products);

              sharedPreferences.setString('cod',cod);
              sharedPreferences.setString('products',products);

              if(name == null){
                Navigator.of(context).pop();

                Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressPage()) );
              }else{
                Navigator.of(context).pop();

                Navigator.push(context, MaterialPageRoute(builder: (context)=> UserAddressPage()) );
              }

            }

          }else{
            Navigator.of(context).pop();

            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Empty fields'),
                  content: Text(message1+"\n"+message2),
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

      }else{
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


  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
        child:Scaffold(
          appBar: new AppBar(
            automaticallyImplyLeading: true,
            centerTitle: true,
            backgroundColor: Colors.red,
            iconTheme: IconThemeData(color: Colors.white),            title: Text("Product Details"),
            actions: <Widget>[
              new IconButton(icon:_searchIcon, onPressed: (){
                showSearch(context: context, delegate: DataSearch());
              }),
              new IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()) );

              })
            ],
          ),



          //Body
          body:  new Padding(padding: const EdgeInsets.only(top:5.0,bottom:0.0),child: SingleProductView()),

          bottomSheet:
          Container(
            decoration: new BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
              ),],
              color: Colors.white,
            ),
            height: 80.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new Padding(padding: const EdgeInsets.only(left:10.0,right:5.0),child: ButtonTheme(
                      minWidth: 200.0,
                      height: 60.0,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: (){
                          buynow();
                        },
                        child: new Text("Buy Now",textScaleFactor: 1.2,),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:


                  new Padding(padding: const EdgeInsets.only(left:5.0,right:10.0),child:


                  new Container(
                    width: MediaQuery.of(context).size.width * 1.0,

                    decoration: new BoxDecoration(

                      color: Colors.white,
                      borderRadius: new BorderRadius.all(const Radius.circular(30.0)),
                      border: Border.all(color: Colors.red,width: 2)
                    ),
                    child: ButtonTheme(

                      minWidth: 200.0,
                      height: 60.0,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                        textColor: Colors.white,
                        color: Colors.white,
                        onPressed: (){
                          addtocart();
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.add_shopping_cart,color: Colors.red,),
                            new Text("Add to Cart",textScaleFactor: 1.2,style: TextStyle(color: Colors.red),),
                          ],
                        ),
                      ),
                    ),
                  ),

                  )
                )
              ],
            ),
          )




        )
        ,
        onWillPop: requestPop);

  }

  Future<bool> requestPop() async {
    print("helloooooo");
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove('quantity');
      sharedPreferences.remove('color');
      sharedPreferences.remove('size');
      return true;
    }

}


class DataSearch extends SearchDelegate<String>{



  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.close), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
            icon:AnimatedIcons.menu_arrow,
            progress: transitionAnimation),
        onPressed: (){
          close(context, null);
        });  }

  @override
  Widget buildResults(BuildContext context) {
    searchresults (query,context);
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty){
      return FutureBuilder(
        future: getrecentitems(),
        builder: (context,snapshot){

          print("data is ");
          print(snapshot.data);
          return  ListView.builder(
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                onTap: (){
                  showResults(context);
                },
                leading: Icon(Icons.bubble_chart),
                title: snapshot.data[index],
              );
            },
            itemCount: snapshot.data == null?0:snapshot.data.length,
          );
        },
      );
    }else{
      return FutureBuilder(
        future: getsuggestions(query),
        builder: (context,snapshot){
          print("daaata is ");
          print(snapshot.data);
          List recent = [];
          List finallist = [];
          print("recent queriesfsdf");
          print(snapshot.data);
          if(snapshot.data == null){
            recent =[];
          }else{
            recent = json.decode(snapshot.data);

            finallist = recent.where((p)=> p.startsWith(query.toLowerCase())).toList();

          }
          return  ListView.builder(
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                onTap: (){
                  query = finallist[index];
                  showResults(context);
                },
                leading: Icon(Icons.bubble_chart),
                title: Text(finallist[index]),
              );
            },
            itemCount: snapshot.data == null?0:finallist.length,
          );
        },
      );
    }
  }



  Future<List> getrecentitems() async{
    List recent =[];
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String recentqueries = sharedPreferences.getString('recentqueries');
    if(recentqueries == null){
      recent =[];
    }else{
      recent = json.decode(recentqueries);
    }
    return recent;
  }

  Future<String> getsuggestions(qry)async{
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String recentqueries = sharedPreferences.getString('searchtags');


    return sharedPreferences.getString('searchtags');
  }

  void searchresults(String key,context) async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('searchkey',key);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SearchResults()) );

  }


}

