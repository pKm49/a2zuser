import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/category.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class HomeCategories3 extends StatefulWidget {
  @override
  _HomeCategories3State createState() => _HomeCategories3State();
}

class _HomeCategories3State extends State<HomeCategories3> {

  BuildContext bcont;
  List data,categories;
  SharedPreferences sharedPreferences;
  String name,homecategories2;
  String mobile;
  String productId;
  Map<String, String> heaaders = {};
  int len;
  double hght;

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
    homecategories2 = sharedPreferences.getString('homecategories2');

    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;


    if(homecategories2 == null){



    check().then((intenet) async{
      if (intenet != null && intenet) {
        var response = await http.get(
            Uri.encodeFull(url),
            headers: heaaders
        );

        print("respoinse");
        print(response.body);

        var mobiles = json.decode(response.body);
        categories = mobiles["categories"];
        List tempdata =[];
        int templen;
        var count = categories.length-3;
        print("count");
        print(count);
        if(count%2== 0){
          templen=(count/2).round();
          for(int i =(templen+3);i<(templen*2)+3;i++){
            tempdata.add(categories[i]);
          }
        }else if(count%2 == 1){
          templen=((count-1)/2).round();
          print("templen");
          print(templen);
          for(int i =(templen+3);i<templen+templen+4;i++){
            print("I");
            print(i);
            tempdata.add(categories[i]);
          }
          templen ++;
        }

        double temphgt;
        if(templen==1){

          temphgt = MediaQuery.of(context).size.width/2 ;
          print("height1");
          print(temphgt);
        }else{
          if(templen.isOdd){
            temphgt = (MediaQuery.of(context).size.width/2)*((templen+1)/2) ;
            print("height2");
            print(temphgt);
          }else{
            temphgt = (MediaQuery.of(context).size.width/2) *(templen/2);
            print("height3");
            print(temphgt);
          }
        }
        homecategories2 = json.encode(tempdata);
        sharedPreferences.setString('homecategories2', homecategories2);


        print("categories");
        print(mobiles["categories"]);
        setState(() {
          data = tempdata;
          len =templen;
          hght = temphgt;

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

    }else{
      List tempdata = json.decode(homecategories2);
      int templen =tempdata.length;


      double temphgt;
      if(templen==1){

        temphgt = MediaQuery.of(context).size.width/2 ;
        print("height1");
        print(temphgt);
      }else{
        if(templen.isOdd){
          temphgt = (MediaQuery.of(context).size.width/2)*((templen+1)/2) ;
          print("height2");
          print(temphgt);
        }else{
          temphgt = (MediaQuery.of(context).size.width/2) *(templen/2);
          print("height3");
          print(temphgt);
        }
      }

      print("categories");
      setState(() {
        data = tempdata;
        len =templen;
        hght = temphgt;

      });


      var response = await http.get(
          Uri.encodeFull(url),
          headers: heaaders
      );

      print("respoinse");
      print(response.body);

      var mobiles = json.decode(response.body);
      categories = mobiles["categories"];
      var count = categories.length-3;
      print("count");
      print(count);
      tempdata =[];

      if(count%2== 0){
        templen=(count/2).round();
        for(int i =(templen+3);i<(templen*2)+3;i++){
          tempdata.add(categories[i]);
        }
      }else if(count%2 == 1){
        templen=((count-1)/2).round();
        print("templen");
        print(templen);
        for(int i =(templen+3);i<templen+templen+4;i++){
          print("I");
          print(i);
          tempdata.add(categories[i]);
        }
        templen ++;
      }

      homecategories2 = json.encode(tempdata);
      sharedPreferences.setString('homecategories2', homecategories2);

    }
  }


  @override
  Widget build(BuildContext context) {
    bcont =context;
    return Visibility(
      visible: data == null?false:true,
      child: Container(
        color: Colors.grey.shade50,
        height: hght,
        child:
        Padding(padding: const EdgeInsets.all(10.0),child:new StaggeredGridView.countBuilder(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          itemCount: len,
          itemBuilder: (BuildContext context, int index){
            return Single_category(
              title:data[index]['title'],
              imgurl:data[index]['imgurl'],
              name:data[index]['name'],
            );
          },

          staggeredTileBuilder: (int index) =>
          new StaggeredTile.count(len.isOdd?index==(len-1)?2:1:1,1),
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
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
            child:Padding(padding: const EdgeInsets.only(left:5.0),child:
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

