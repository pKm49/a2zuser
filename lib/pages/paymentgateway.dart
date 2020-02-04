
import 'package:flutter/material.dart';
//appspecific imports
import 'package:http/http.dart' as http;

import  'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import  'package:a2zonlinshoppy/pages/orderconfirmedcard.dart';
import  'package:a2zonlinshoppy/pages/orderconfirmed.dart';
import  'package:a2zonlinshoppy/pages/ordercancelled.dart';
import  'package:a2zonlinshoppy/pages/ordercancelledcard.dart';
import  'package:a2zonlinshoppy/Home.dart';
import 'dart:convert';

class PaymentGateway extends StatefulWidget {
  @override
  _PaymentGatewayState createState() => _PaymentGatewayState();
}

class _PaymentGatewayState extends State<PaymentGateway> {
  String name,mobile,cook,csrf,tock;
  Map<String, String> heaaders = {};

int issendcard = 1,issendorder = 1;
  SharedPreferences sharedPreferences;
  String paymentLink;
  bool showwebview = false;
int countcard=0,countprod = 0;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isSignedIN();
  }

  void isSignedIN() async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      cook = sharedPreferences.getString('Cookie');
      tock = sharedPreferences.getString('tocken');
      csrf = sharedPreferences.getString('csrf');

      if(tock!=null){
        heaaders['authorization'] = "tocken "+tock;
      }

      heaaders['Accept'] = "application/JSON";
      heaaders['Cookie'] = cook;

      paymentLink = sharedPreferences.getString('paymentLink');
      print("paymentLink");
      print(paymentLink);
    });

    await new Future.delayed(const Duration(seconds: 2));

    setState(() {
      showwebview=true;
    });



  }
  @override
  Widget build(BuildContext context) {

    /*
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: Text('A2ZOnlineShoppy'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search,color: Colors.white), onPressed: (){}),
          new IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()) );

          })
        ],
      ),

      drawer: new Drawer(
        child: AtozDrawer(),
      ),

      //Body
      body:Visibility(
          visible: paymentLink == null?false:true,
          child: WebView(
        initialUrl: paymentLink,
            gestureRecognizers: gestureSet,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
              webViewController.evaluateJavascript('''inputs = document.querySelectorAll("input[type=text]");    inputs.forEach(function(inp) {  let finalInput = inp;  finalInput.addEventListener("focus", function() {onsole.log('focus'); input = finalInput; InputValue.postMessage(''); Focus.postMessage('focus'); }); finalInput.addEventListener("focusout", function() {console.log('unfocus'); Focus.postMessage('focusout');          });   });''');
            },
      )),

    );

    */



    flutterWebviewPlugin.onUrlChanged.listen((String url) async{
      print("url is ");
      print(url);

        if(url == "https://www.a2zonlineshoppy.com/api/checkout/ordercancelledcard"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OrdeCancelledCard()) );
        }
        else if(url == "https://www.a2zonlineshoppy.com/api/checkout/loadingcard"){

          print("count");
          print(countcard);
          if(countcard++ ==0){
            print("count one");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OrderConfirmedCard()) );
          }else{
            print("count else");
          }
        }
        if(url == "https://www.a2zonlineshoppy.com/api/checkout/ordercancelled"){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OrderCancelled()) );
        }else if(url == "https://www.a2zonlineshoppy.com/api/checkout/loading" ){
          print("count");
          print(countprod);
          if(countprod++ ==0){
            print("count one");
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OrderConfirmed()) );

          }else{
            print("count else");
          }
        }

    });

    return WebviewScaffold(
      url: paymentLink,
      withJavascript: true,
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text('Payment'),
        automaticallyImplyLeading: false,
      ),
      hidden: true,
      withLocalStorage: true,
      initialChild: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 1.0,
        height: MediaQuery.of(context).size.height * 1.0,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Redirecting to Payment Gateway",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.2,)
            ],
          )
        ),
      ),
    );


  }




}




/*
Stack(
          children: <Widget>[
            Card(
              child: Column(
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                  Text("Shipping Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                ],
              ),
            ),
            Card(
              child: Column(
                children: <Widget>[
                  new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                  Text("Billing Address",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                ],
              ),
            ),
            Visibility(
              visible: codproducts == null?false:true,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: ListView(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                      Text("COD products",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                    ],
                  ),
                ),
            ),
            Visibility(
              visible: pgproducts == null?false:true,
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: ListView(
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("COD products",textAlign: TextAlign.center,textScaleFactor: 2.0,style: TextStyle(fontWeight: FontWeight.bold),)),

                  ],
                ),
              ),
            ),

            new Padding(padding: const EdgeInsets.only(top: 25.0,right: 25.0,left:25.0),child:
            ButtonTheme(
              minWidth: 200.0,
              height: 60.0,
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                onPressed: (){
                  payment();
                },
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                child: new Text("Continue to Payment",textScaleFactor: 1.2,),
              ),
            )
            ),

          ]
      )

      */