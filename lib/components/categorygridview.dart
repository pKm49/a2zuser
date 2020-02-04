import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/category.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class CategoryGridView extends StatefulWidget {
  @override
  _CategoryGridViewState createState() => _CategoryGridViewState();
}

class _CategoryGridViewState extends State<CategoryGridView> {

  BuildContext bcont;
  List data;
  SharedPreferences sharedPreferences;
  String name;
  String mobile;
  String productId;
  Map<String, String> heaaders = {};
  int len;

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
    final String url = 'https://www.a2zonlineshoppy.com/api/categories';

    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
    String tock = sharedPreferences.getString('tocken');

    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

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

        print("categories");
        print(mobiles["categories"]);
        setState(() {
          data = mobiles["categories"];
          len =data.length;
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
    bcont =context;
    return Visibility(
      visible: data == null?false:true,
      child: Container(
        color: Colors.grey.shade50,
        child:
        Padding(padding: const EdgeInsets.only(left:10.0,right:10.0),child:new StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: len,
          itemBuilder: (BuildContext context, int index){
            return Single_category(
              title:data[index]['title'],
              imgurl:data[index]['imgurl'],
              name:data[index]['name'],
            );
          },

          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(2, 2),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        )
        ),
      ),
    );
  }



}




class Single_category extends StatelessWidget {

  final title;
  final name;
  final imgurl;

  Single_category({
    this.title,
    this.name,
    this.imgurl,
  });

  @override
  Widget build(BuildContext context) {

    SharedPreferences sharedPreferences;
    var imageurl = imgurl;
    int index = imageurl.lastIndexOf("/");
    String yourCuttedString = imageurl.substring( index+1,imageurl.length);
    String categoryimageurl = "https://www.a2zonlineshoppy.com/public2/categories/"+yourCuttedString;
    print("second string");
    print(yourCuttedString);
    return    Card(
        child:new InkWell(
          onTap: ()async{

            sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString('type','category');
            sharedPreferences.setString('key',name);
            sharedPreferences.setString('categoryimageurl',categoryimageurl);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Category()) );
          },
          child: Container(
            alignment: Alignment.bottomLeft,
            child:Padding(padding: const EdgeInsets.only(left:2.0),child:
            Text(title,textScaleFactor: 1.3,style: TextStyle(color: Colors.grey.shade50,fontWeight: FontWeight.bold))),

            decoration: new BoxDecoration(
              boxShadow: [BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
              ),],
              borderRadius: new BorderRadius.all(const Radius.circular(5.0)),
              color: const Color(0xff7c94b6),
              image: new DecorationImage(
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                image: new NetworkImage(categoryimageurl,scale: .5),
              ),
            ),
          ),
        )

    );
  }


}

