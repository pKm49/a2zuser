
import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/productview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductSearchResults extends StatefulWidget {
  @override
  _ProductSearchResultsState createState() => new _ProductSearchResultsState();
}

class _ProductSearchResultsState extends State<ProductSearchResults> {

  List data;
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String csrf;
  String key;
  String urlcount;
  Map<String, String> heaaders = {};
  var cacheddata = new Map<int, Data>();
  var offsetLoaded = new Map<int, bool>();

  int _total = 0;

  @override
  void initState() {
    _getTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return new Column(
      children: <Widget>[
        Visibility(
          visible:_total == null?false:true,
          child: Padding(padding: const EdgeInsets.all(0.0),child:

          Container(
            color: Colors.grey.shade50,
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * .85,
            child: StaggeredGridView.countBuilder(
              crossAxisCount:  2,
              itemCount: _total,
              itemBuilder: (BuildContext context, int index) {
                Data daata = _getData(index);
                if(data == null){
                  return  Container(
                      child:Card(
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )

                  );
                }else{
                  if(daata.title == 'title'){
                    return  Container(
                        child:Card(
                          color: Colors.white,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )

                    );
                  }else {
                    return Single_product(
                      title: daata.title,
                      picture: 'https://www.a2zonlineshoppy.com/public2/products/' +
                          daata._id + 'imageone.jpg',
                      rating: daata.rating,
                      oldprice: daata.oldPrice,
                      offerpercent: daata.a2zPrice,
                      id: daata._id,
                      cod: daata.cod == true ? 'cash on delivery' : '',
                      assuredpicture: 'images/cats/assured.png',
                      newprice: daata.a2zMoney == null ? (daata.oldPrice -
                          ((daata.oldPrice * daata.a2zPrice) / 100).round()) : daata
                          .a2zMoney,
                    );
                  }}},
              staggeredTileBuilder:  (int index) =>
              new StaggeredTile.count(1, 1.4),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,

            ),
          )),
        ),
        Visibility(
          visible: _total == null?true:false,
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width * 1.0,
            height: MediaQuery.of(context).size.height * .85,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );


  }

  Future<List<Data>> _getDatas(int offset, int limit) async {
    final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));

// Find the Scaffold in the Widget tree and use it to show a SnackBar

    String jsonString = await _getJson(offset, limit);

    var mob = json.decode(jsonString);

    List list = mob["products"] as List;


    var datas = new List<Data>();

    if(list == null){

      return null;
    }else{
      list.forEach((element) {
        Map map = element as Map;
        datas.add(new Data.fromMap(map));
      });
      return datas;
    }
  }

  Future<String> _getJson(int offset, int limit) async {

    if(_total == offset){
      return null;
    }

    if(_total-offset<=8){
      limit = _total-offset;
      print("limit");
      print(limit);


    }

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');
    key = sharedPreferences.getString('searchkey');
    csrf = sharedPreferences.getString('csrf');


    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;
    final String urladd = 'https://www.a2zonlineshoppy.com/api/product/searchproducts/$offset/$limit';
    dynamic mybody = {'search': '$key','_csrf':'$csrf'};

    var response = await http.post(
        Uri.encodeFull(urladd),
        headers: heaaders,
      body: mybody
    );

    print(response.body);
    var mobiles = json.decode(response.body);

    setState(() {
      data = mobiles["products"];
    });


    return response.body;
  }


  Data _getData(int index) {

    Data data = cacheddata[index];
    if (data == null) {
      int offset = index ~/ 8 * 8;

      if (!offsetLoaded.containsKey(offset)) {
        offsetLoaded.putIfAbsent(offset, () => true);
        _getDatas(offset, 8)
            .then((List<Data> datas) => _updateDatas(offset, datas));
      }
      data = new Data.loading();
    }
    return data;
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


  Future<int> _getTotal() async {

    sharedPreferences = await SharedPreferences.getInstance();
    key = sharedPreferences.getString('searchkey');
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');
    urlcount = 'http://www.a2zonlineshoppy.com/api/product/getproductcount/searchs/$key';


    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;


    check().then((intenet) async{
      if (intenet != null && intenet) {
        var reponse = await http.get(
            Uri.encodeFull(urlcount),
            headers: heaaders
        );

        print(reponse.body);
        var mobiles = json.decode(reponse.body);

        setState(() {
          _total = mobiles["number"];
        });

        return  mobiles["number"];
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

        return 0;
      }

      // No-Internet Case
    });
  }

  void _updateDatas(int offset, List<Data> datas) {
    setState((){
      for (int i=0; i < datas.length; i++) {
        cacheddata.putIfAbsent(offset + i, () => datas[i]);
      }
    });
  }
}


class Data {

  String title;
  String _id;
  String code;
  String description;
  List details;
  List size;
  List imageurl;
  String imageone;
  String imagetwo;
  String imagethree;
  String maincategory;
  String subCategory;
  String type;
  double oldPrice;
  double basePrice;
  double marginPercent;
  double newPrice;
  double a2zPrice;
  double a2zMoney;
  double rating;
  int ratecount;
  bool cod;
  String codcharge;
  String source;
  String affiliatelink;
  String sellerId;
  String updated_at;
  double __v;
  String created_at;
  bool availability;
  bool approved;

  Data.loading() {
    title = "title";
    _id = "5c5c14fd97d4cc32e2053de2";
    code = "title";
    description = "title";
    details = [];
    size = [];
    imageurl = [];
    imageone = "https://ui-ex.com/images/gif-transparent-loading-4.gif";
    imagetwo = "title";
    imagethree = "title";
    maincategory = "title";
    subCategory = "title";
    type = "title";
    oldPrice = 100.0;
    basePrice = 100.0;
    marginPercent = 10.0;
    newPrice = 100.0;
    a2zPrice = 100.0;
    a2zMoney = 100.0;
    rating = 4.5;
    ratecount = 55;
    cod = true;
    codcharge = '11';
    source = "title";
    affiliatelink = "title";
    sellerId = "title";
    availability = true;
    approved = true;
    created_at = "title";
    updated_at = "title";
    __v = 0.0;
  }

  Data.fromMap(Map map) {
    title = map['title'] == null? null :map['title'];
    _id = map['_id'] == null? null :map['_id'];
    code = map['code'] == null? null :map['code'];
    description = map['description'] == null? null :map['description'];
    details = map['details'] == null? null :map['details'];
    size = map['size'] == null? null :map['size'];
    imageurl = map['imageurl'] == null? null :map['imageurl'];
    imageone = map['imageone'] == null? null :map['imageone'];
    imagetwo = map['imagetwo'] == null? null :map['imagetwo'];
    imagethree = map['imagethree'] == null? null :map['imagethree'];
    maincategory = map['maincategory'] == null? null :map['maincategory'];
    subCategory = map['subCategory'] == null? null :map['subCategory'];
    type = map['type'] == null? null :map['type'];
    oldPrice = map['oldPrice'] == null? null:map['oldPrice'].toDouble();
    basePrice = map['basePrice'] == null? null:map['basePrice'].toDouble();
    marginPercent =map['marginPercent'] == null? null: map['marginPercent'].toDouble();
    newPrice = map['newPrice'] == null? null: map['newPrice'].toDouble();
    a2zPrice = map['a2zPrice'] == null? null: map['a2zPrice'].toDouble();
    a2zMoney = map['a2zMoney'] == null? null:map['a2zMoney'].toDouble();
    rating = map['rating'] == null? null:map['rating'].toDouble();
    ratecount = map['ratecount'] == null? null :map['ratecount'];
    cod = map['cod'] == null? null :map['cod'];
    codcharge = map['codcharge'] == null? null :map['codcharge'].toString();
    source = map['source'] == null? null :map['source'];
    affiliatelink = map['affiliatelink'] == null? null :map['affiliatelink'];
    sellerId = map['sellerId'] == null? null :map['sellerId'];
    availability = map['availability'] == null? null :map['availability'];
    approved = map['approved'] == null? null :map['approved'];
    created_at = map['created_at'] == null? null :map['created_at'];
    updated_at = map['updated_at'] == null? null :map['updated_at'];
    __v =map['__v']== null? null: map['__v'].toDouble();
  }
}











class Single_product extends StatelessWidget {

  final title;
  final picture;
  final rating;
  final assuredpicture;
  final oldprice;
  final offerpercent;
  final newprice;
  final id;
  final cod;

  Single_product({
    this.title,
    this.picture,
    this.rating,
    this.assuredpicture,
    this.oldprice,
    this.offerpercent,
    this.newprice,
    this.id,
    this.cod,

  });

  @override
  Widget build(BuildContext context) {
    String titl =  title.length<=24 ? title : title.substring(0, 22)+'...';
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
          padding: const EdgeInsets.all(8.0),

          width: MediaQuery.of(context).size.width * .5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Expanded(
                flex: 5,
                child: new Padding(padding: const EdgeInsets.all(10.0),child:
                new CachedNetworkImage(
                  imageUrl: "$picture",
                  placeholder: (context, url) => new CircularProgressIndicator(),
                  height: MediaQuery.of(context).size.height *.13,
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),),
              ),

              Expanded(
                flex: 3,
                child: FittedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.contain,
                        child:                   Text('$titl',style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,textAlign: TextAlign.center),

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
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(' ₹$np  ',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                                Text(' ₹$op ',style: TextStyle(fontWeight: FontWeight.normal,decoration: TextDecoration.lineThrough,color: Colors.blueGrey ),textAlign: TextAlign.center),
                                Text(' $oper%off ',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),textAlign: TextAlign.center,),
                              ],
                            ),
                          )
                      ),
                      new Padding(padding: const EdgeInsets.all(6.0),child:

                      Text('$cod',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),maxLines: 1,textAlign: TextAlign.center),),

                    ],
                  ),
                ),
              ),


            ],
          ),

        ),
      ),
    );
  }
}