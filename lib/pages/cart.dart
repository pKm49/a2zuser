/// ListTile
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/components/singlecartproductview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:a2zonlinshoppy/pages/addresspage.dart';
import 'package:a2zonlinshoppy/pages/useraddresspage.dart';

class Cart extends StatefulWidget {
  @override
  CartState createState() => CartState();
}

class CartState extends State<Cart> {

  SharedPreferences sharedPreferences;
  Map<String, String> heaaders = {};
  String name;
  String mobile;
  int totalPrice=0,totalQty=0,len;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
    this.getJsonData();
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


  Future<String> getJsonData() async{
    sharedPreferences = await SharedPreferences.getInstance();
    final String url = 'https://www.a2zonlineshoppy.com/api/cart';

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }
    print("cookie");
    print(cook);
    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

    check().then((intenet) async{
      if (intenet != null && intenet) {
        var response = await http.get(
            Uri.encodeFull(url),
            headers: heaaders
        );

        print("respoinse");
        print(response.body);

        var mobiles = json.decode(response.body);

        print("totalPrice");
        print(mobiles["totalPrice"]);
        setState(() {

          totalPrice = mobiles["totalPrice"];
          totalQty = mobiles["totalQty"];
        });
        return "success";
      }else{
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

    return Scaffold(
      appBar:  new AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Shopping Cart"),
      ),

      //Body
      body: Container(
        color: Colors.grey.shade50,
        height: MediaQuery.of(context).size.height *1.0,
          child: SingleCartProductView(),
      ),

      bottomSheet:
      Visibility(
        visible: totalQty==0||totalQty == null?false:true,
        child: Container(
          decoration: new BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
              ),],
              color: Colors.white,
          ),
          height: 130.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: new Text("Cart Total ($totalQty items)  :  ₹$totalPrice",style: TextStyle(color: Colors.grey.shade800,fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.4,),

                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child:
                    new Padding(padding: const EdgeInsets.all(15.0),child:

                    new Container(
                      width: MediaQuery.of(context).size.width * 1.0,

                      decoration: new BoxDecoration(
                        boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4.0,
                        ),],
                        color: Colors.grey,
                        borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
                      ),
                      child: ButtonTheme(

                        minWidth: 200.0,
                        height: 60.0,
                        child: RaisedButton(

                          textColor: Colors.white,
                          color: Colors.blue,
                          onPressed: (){
                            checkout();
                          },
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          child: new Text("Check Out",textScaleFactor: 1.2,),
                        ),
                      ),
                    ),

                    ),
                  )
                ],
              )
            ],
          ),
        )
      )

    );
  }

  void checkout() async{
    String cook ;
    String tock ;
    String cod ;
    String products ;
    final String urlbuy = 'https://www.a2zonlineshoppy.com/api/checkout';

    sharedPreferences = await SharedPreferences.getInstance();
    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');

    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
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

    if(message=="error"){
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

      sharedPreferences.setString('cod',cod);
      sharedPreferences.setString('products',products);


      if(name == null){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AddressPage()) );
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UserAddressPage()) );
      }

    }


  }
}




