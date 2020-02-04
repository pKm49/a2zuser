import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/productview.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/Home.dart';

class SingleConfirmedProductView extends StatefulWidget {
  @override
  _SingleConfirmedProductViewState createState() => _SingleConfirmedProductViewState();
}

class _SingleConfirmedProductViewState extends State<SingleConfirmedProductView> {

  BuildContext bcont;
  var data;
  SharedPreferences sharedPreferences;
  String name,mobile,cook,csrf,tock;
  String productId;
  Map<String, String> heaaders = {};
  int totalMrp=0,len=0;
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
      cook = sharedPreferences.getString('Cookie');
      tock = sharedPreferences.getString('tocken');
      csrf = sharedPreferences.getString('csrf');

      if(tock!=null){
        heaaders['authorization'] = "tocken "+tock;
      }

      heaaders['Accept'] = "application/JSON";
      heaaders['Cookie'] = cook;
    });
  }

  Future<String> getJsonData() async{
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences = await SharedPreferences.getInstance();
    String products = sharedPreferences.getString('products');
    String total = sharedPreferences.getString('totalMrp');


    print("products");
    print(products);
    print("total");
    print(total);
    setState(() {
      data = json.decode(products);
      len = data.length;
      totalMrp = int.parse(total);
      print("data");
      print(data);
      print("data-length");
      print(len);

      print("totalMrp");
      print(totalMrp);
    });


      final String url = 'https://www.a2zonlineshoppy.com/api/checkout/saveonlineorder';
      var response = await http.get(
        Uri.encodeFull(url),
        headers: heaaders,
      );

      print(response.body);

      var bod = json.decode(response.body);
      String message = bod["message"];


      if(message=="success"){
print("successgjhgjh");
      }else{
        print("failjkhjkhkjed");
      }
    return "success";
  }
  @override
  Widget build(BuildContext context) {
    bcont =context;
    return ListView(
      children: <Widget>[
        Visibility(
          visible: len==0?false:true,
          child: Container(
            color: Colors.grey.shade50,
            height: MediaQuery.of(context).size.height *1,
            child: ListView(
              children: <Widget>[
                FittedBox(
                  fit: BoxFit.contain,
                  child: new Padding(padding: const EdgeInsets.all(15.0),child:
                  Text("Thank You For Shopping at A2ZOnlineshoppy",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.8)),
                ),
                new Padding(padding: const EdgeInsets.all(15.0),
                    child:Text("Order Total : ₹$totalMrp",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),textAlign: TextAlign.center,textScaleFactor: 1.5)
                ),

                new Padding(padding: const EdgeInsets.all(8.0),child:
                Text("Your Order Contains",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.2)),

                Container(

                  height: MediaQuery.of(context).size.height *.8,
                   decoration:  new BoxDecoration(

                       color: Colors.grey.shade50,
                   ),

                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: len,
                    itemBuilder: (BuildContext context, int index){
                      return Single_products(
                          title:data[index]['title'],
                          size:data[index]['size'],
                          color:data[index]['color'],
                          picture:'https://www.a2zonlineshoppy.com/public2/products/'+data[index]['id']+'imageone.jpg',
                          price:data[index]['price'],
                          id:data[index]['id'],
                          point:data[index]['point'],
                          qty:data[index]['qty']
                      );
                    },
                  ),
                ),

              ],
            ),
          )
        ),
      ],
    );
  }
  void clearcart() async{
    final String url = 'https://www.a2zonlineshoppy.com/api/clearcart';
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');


    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
    var response = await http.get(
        Uri.encodeFull(url),
        headers: heaaders
    );

    print(response.body);

    var bod = json.decode(response.body);
    var message = bod["message"];

    if(message == "success"){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()) );
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
  final color;
  final point;
  final price;

  Single_products({
    this.title,
    this.picture,
    this.rating,
    this.id,
    this.point,
    this.size,
    this.qty,
    this.color,
    this.price,

  });

  @override
  Widget build(BuildContext context) {

    int pr = price.round();
    int upr = (pr/qty).round();
    String clr;
    if(color==""){
      clr="default";
    }else{
      clr=color;
    }
    return    new Padding(padding: const EdgeInsets.only(top:20.0,bottom: 10.0),child:Container(

        decoration: new BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
            ),],
            color: Colors.white,
            borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
            border: new Border.all(color: Colors.white)
        ),
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width *.80 ,
        child:
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child:
              InkWell(
                onTap: ()async{
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setString('productId',id);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductView()) );
                },
                child:             Image.network('$picture',height: 100.0),

              ),
            ),
            Expanded(
              flex: 3,
              child:new Padding(padding: const EdgeInsets.all(5.0),child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('$title ($size) ($clr)',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1.2,),

                  new Padding(padding: const EdgeInsets.only(top:5.0),child:
                  Text('Unit Price : ₹$upr',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,))

                  ,new Padding(padding: const EdgeInsets.only(top:5.0),child:
                    Text('Qty : $qty',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,)),


                ],
              )),
            )
          ],
        ),
    ));
  }

  void remove(id,context) async{
    print("idada");
    print(id);
    print(size);
    print(color);
    SharedPreferences sharedPreferences;

    Map<String, String> heaaders = {};
    sharedPreferences = await SharedPreferences.getInstance();
    var csrf = sharedPreferences.getString('csrf');
    var  cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    final String url = 'https://www.a2zonlineshoppy.com/api/removeone?id=$id&size=$size&color=$color';
    dynamic mybody = {'size': '$size','color': '$color','id': '$id','_csrf':'$csrf'};


    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
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

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Cart()) );

  }


  void changeqty(qy,context) async{
    print("idada");
    print(id);
    print(size);
    print(color);
    SharedPreferences sharedPreferences;

    Map<String, String> heaaders = {};
    sharedPreferences = await SharedPreferences.getInstance();
    var csrf = sharedPreferences.getString('csrf');
    var  cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    final String url = 'https://www.a2zonlineshoppy.com/api/changeqty?id=$id&size=$size&color=$color&qty=$qy';
    dynamic mybody = {'size': '$size','color': '$color','id': '$id','_csrf':'$csrf'};


    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
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

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Cart()) );

  }


}

