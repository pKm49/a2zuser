import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import  'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/productview.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeMobiles extends StatefulWidget {
  @override
  _HomeMobilesState createState() => _HomeMobilesState();
}

class _HomeMobilesState extends State<HomeMobiles> {

  SharedPreferences sharedPreferences ;
  Map<String, String> heaaders = {};
  String homemobiles;
  final String url = 'https://www.a2zonlineshoppy.com/api/homepagemobiles';
  List data;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');
    homemobiles = sharedPreferences.getString('homemobiles');

    print("mobiles");
    print(homemobiles);

    if(homemobiles == null){
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

      setState(() {
        var mobiles = json.decode(response.body);
        data = mobiles["bestmobiles"];
      });


      homemobiles = json.encode(data);
      sharedPreferences.setString('homemobiles', homemobiles);

      return "success";
    }else{
      setState(() {
        data = json.decode(homemobiles);
      });

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
      var mobiles = json.decode(response.body);
      data = mobiles["bestmobiles"];
      homemobiles = json.encode(data);
      sharedPreferences.setString('homemobiles', homemobiles);

      return "success";
    }


  }


  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: data==null?false:true,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        itemBuilder: (BuildContext context, int index){
          return Single_product(
            title:data[index]['title'],
            picture:'https://www.a2zonlineshoppy.com/public2/products/'+data[index]['_id']+'imageone.jpg',
            rating:data[index]['rating'],
            id:data[index]['_id'],
            assuredpicture:'images/cats/assured.png',
            oldprice:data[index]['oldPrice'],
            offerpercent:data[index]['a2zPrice'],
            newprice:data[index]['a2zMoney'] == null? (data[index]['oldPrice']-((data[index]['oldPrice'] * data[index]['a2zPrice'])/100).round()):data[index]['a2zMoney'],
          );
        },
      ),
    );
  }
}

class Single_product extends StatelessWidget {
  final title;
  final picture;
  final rating;
  final id;
  final assuredpicture;
  final oldprice;
  final offerpercent;
  final newprice;

  Single_product({
    this.title,
    this.picture,
    this.rating,
    this.id,
    this.assuredpicture,
    this.oldprice,
    this.offerpercent,
    this.newprice,
  });

  @override
  Widget build(BuildContext context) {
    String titl =  title.length<=27 ? title : title.substring(0, 27)+'...';
    int op = oldprice.round();
    int np = newprice.round();
    int oper = offerpercent.round();
    return Padding(padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () async{
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString('productId',id);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductView()) );
        },
        child: Container(
            decoration: new BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4.0,
                ),],
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
                border: new Border.all(color: Colors.white)
            ),
            margin: const EdgeInsets.only(top:10.0,bottom:10.0,left:4.0,right: 4.0),
            padding: const EdgeInsets.all(10.0),
            width: 200.0,
            child:
            FittedBox(
            fit: BoxFit.contain,
    child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(padding: const EdgeInsets.all(10.0),child:
                new CachedNetworkImage(
                  imageUrl: "$picture",
                  placeholder: (context, url) => new CircularProgressIndicator(),
                  height: MediaQuery.of(context).size.height *.15,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                )

                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child:Text('$titl',style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,textAlign: TextAlign.center),

                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    new Container(
                      margin: const EdgeInsets.all(3.0),
                      padding: const EdgeInsets.all(2.0),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
                        border: new Border.all(color: Colors.red),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text('$rating  ',style: TextStyle(color: Colors.white),textAlign: TextAlign.center),
                          Icon(Icons.star,color: Colors.white,size: 15.0,),
                        ],
                      ),
                    ),
                    Image.asset(assuredpicture,height: 20.0)                        ],
                ),
                new Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(2.0),
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
                        border: new Border.all(color: Colors.blueAccent)
                    ),
                    child:FittedBox(
                      fit: BoxFit.contain,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(' ₹$np ',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                          Text(' ₹$op ',style: TextStyle(fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough,color: Colors.blueGrey ),textAlign: TextAlign.center),
                          Text(' $oper%off ',style: TextStyle(color: Colors.green),textAlign: TextAlign.center,),
                        ],
                      ),
                    )
                ),
              ],
            )
            )
        ),
      ),
    );
  }
}


/*
InkWell(
      onTap: (){},
      child:
        new Padding(padding: const EdgeInsets.all(8.0),child:
      ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          new Padding(padding: const EdgeInsets.all(10.0),child: Image.network(picture,height: 110.0)),
          Text('$title',style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,textAlign: TextAlign.center),

          new Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(2.0),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
                border: new Border.all(color: Colors.blueAccent)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Rs.$newprice  ',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                Text('Rs.$oldprice',style: TextStyle(fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough,color: Colors.blueGrey ),textAlign: TextAlign.center),
                Text('  $offerpercent %off',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center,),
              ],
            )
          ),

        ],
      )),
    );
 */