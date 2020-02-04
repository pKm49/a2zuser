import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/productview.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/Home.dart';

class SingleCancelledProductView extends StatefulWidget {
  @override
  _SingleCancelledProductViewState createState() => _SingleCancelledProductViewState();
}

class _SingleCancelledProductViewState extends State<SingleCancelledProductView> {

  BuildContext bcont;
  var data;
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
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
            height: MediaQuery.of(context).size.height *1,
            child: ListView(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.all(8.0),child:
                Text("Your Order has been cancelled",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.2)),
                new Padding(padding: const EdgeInsets.all(8.0),child:
                Text("Order Items",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.2)),

                Container(
                   decoration:  new BoxDecoration(
                       color: Colors.white,
                       border: new Border(bottom: BorderSide(color: Colors.grey,width: 2.0),)
                   ),

                  height: MediaQuery.of(context).size.height *.4,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: len,
                    itemBuilder: (BuildContext context, int index){
                      return Single_products(
                        title:data[index]['items']['title'],
                        picture:'https://www.a2zonlineshoppy.com/public2/products/'+data[index]['items']['_id']+'imageone.jpg',
                        price:data[index]['items']['a2zMoney'] == null? (data[index]['items']['oldPrice']-((data[index]['items']['oldPrice'] * data[index]['items']['a2zPrice'])/100).round()):data[index]['items']['a2zMoney'],
                        id:data[index]['items']['_id'],
                        size:data[index]['size'],
                        color:data[index]['color'],
                        point:data[index]['point'],
                        qty:data[index]['qty']
                      );
                    },
                  ),
                ),

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: const EdgeInsets.all(8.0),child:
            Text("Order Details",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,textScaleFactor: 1.5)),
            new Padding(padding: const EdgeInsets.all(15.0),child:
            Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child:Text("Total:",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1.5,)),
                Expanded(
                    flex: 1,
                    child:Text("₹$totalMrp",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.end,textScaleFactor: 1.5)
                ),
              ],
            )),

          ],
        ),
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
          )
        ),
      ],
    );
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
    String clr;
    if(color==""){
      clr="default";
    }else{
      clr=color;
    }
    return   Container(
      decoration:  new BoxDecoration(
          border: new Border(top: BorderSide(color: Colors.grey.shade300,width: 1.0),)
      ),
      height: 200.0,
      child: Row(
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
                Text('$title',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1.2,),
                Text('Price : $pr',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Text('Size :$size',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Text('Color : $clr',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Text('Quantity : $qty',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),
                Text('Point : $point',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.start,textScaleFactor: 1,),

              ],
            )),
          )
        ],
      ),
    );
  }




}

