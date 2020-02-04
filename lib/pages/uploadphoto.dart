import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/billcard.dart';
import 'package:image_picker/image_picker.dart';


class Uploadphoto extends StatefulWidget {
  @override
  _UploadphotoState createState() => _UploadphotoState();
}


class _UploadphotoState extends State<Uploadphoto> {
  final String url = 'https://www.a2zonlineshoppy.com/api/isloggedin';
  final String urllogin = 'https://www.a2zonlineshoppy.com/api/customer/signin';
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  SharedPreferences sharedPreferences;
  bool isLoggedin;
  bool loading,otpesend =true;
  var client = http.Client();
  Map<String, String> heaaders = {};
  var csrf;
  var bod;
  File picture;
  String id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }
  void isSignedIN() async{
    setState(() {
      loading =true;
    });

    heaaders['Accept'] = "application/JSON";
    sharedPreferences = await SharedPreferences.getInstance();

    String cook = sharedPreferences.getString('Cookie');
    csrf = sharedPreferences.getString('csrf');
    id = sharedPreferences.getString('cardrequestid');

      print("csrf");
      print(csrf);

      heaaders['Accept'] = "application/JSON";
      heaaders['Cookie'] = cook;





  }



  Future<void> _optionsDialogBox() {

    return showDialog(context: context,
        builder: (BuildContext context) {

          return AlertDialog(
            content:
            new SingleChildScrollView(
              child:
              new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child:Padding(
                  padding: EdgeInsets.all(15.0),
                    child:
                    new Text('Take a picture',textScaleFactor: 1.1)),
                    onTap: openCamera,
                  ),
                  GestureDetector(
                    child:Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new Text('Select from gallery',textScaleFactor: 1.1),
                    ),

                    onTap: openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: new AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: Colors.red,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Upload Photo"),
        ),
        body: Container(
          alignment: Alignment.center,
          child:
    new Padding(padding: const EdgeInsets.only(right: 25.0,left:25.0),child:
    Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 20.0),
                child:
                new Container(
                    width: 190.0,
                    height: 190.0,
                    decoration: new BoxDecoration(

                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: picture == null
                                ?  NetworkImage(
                              'https://www.a2zonlineshoppy.com/public2/avatars/default.png',
                              scale: .50,
                            )
                                : FileImage(picture),
                        )
                    )),



              ),


              new Padding(padding: const EdgeInsets.only(top:30.0,left:0.0,right:0.0,bottom:30.0),child:


              new Container(
                width: MediaQuery.of(context).size.width * 1.0,

                decoration: new BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                  ),],
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
                ),
                child: ButtonTheme(

                  minWidth: 200.0,
                  height: 60.0,
                  child: RaisedButton(

                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: (){
                      _optionsDialogBox();

                    },
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: new Text("Choose File",textScaleFactor: 1.2,),
                  ),
                ),
              ),

              ),
              new Padding(padding: const EdgeInsets.only(top:0.0,left:0.0,right:0.0,bottom:30.0),child:


              new Container(
                width: MediaQuery.of(context).size.width * 1.0,

                decoration: new BoxDecoration(
                  boxShadow: [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4.0,
                  ),],
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
                ),
                child: ButtonTheme(

                  minWidth: 200.0,
                  height: 60.0,
                  child: RaisedButton(

                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: (){
                      validateForm();

                    },
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    child: new Text("Upload",textScaleFactor: 1.2,),
                  ),
                ),
              ),

              )


            ],
          )
    ),
        )
    );
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

  void openCamera() async{

    var  image = await ImagePicker.pickImage(
      source: ImageSource.
      camera,
    );
    Navigator.of(context).pop();

    setState(() {
      picture = image;
    });
  }

  void openGallery() async{
    var  image = await ImagePicker.pickImage(
      source: ImageSource.
      gallery,
    );
    Navigator.of(context).pop();

    setState(() {
      picture = image;
    });
  }

  void updateuser(userdata) async{
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("userdata", userdata);

  }

  void validateForm() async{
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context){
          return  new Dialog(

            child:  Container(
                color: Colors.transparent,
                height: 200.0,
                width: 100.0,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Uploading photo....",textScaleFactor: 1.3,style: TextStyle(fontWeight: FontWeight.bold),),
                new Padding(padding: const EdgeInsets.only(top:5.0,),child:
                Text("Donot press back button!",textScaleFactor: 1.2,)

                )
                  ],
                )
            ),
          );
        }
    );

    check().then((intenet) async{
      if (intenet != null && intenet) {
var user;
var mobile;
        String message1 = "";

        String error = "";
        String message = "";



        if(picture == null){
          message1="Picture Can't be null";
        }else {
           message1="ok";

        }


        sharedPreferences = await SharedPreferences.getInstance();


        dynamic mybody = {"id":'$id','_csrf': '$csrf'};

        if(message1 == "ok"){
          var stream = new http.ByteStream(DelegatingStream.typed(picture.openRead()));
          var length = await picture.length();
          var url = Uri.parse("https://www.a2zonlineshoppy.com/api/checkout/card/photo/");
          var request = new http.MultipartRequest("POST", url);
          print("path");
          int index = picture.path.lastIndexOf("/");
          String yourCuttedString = picture.path.substring( index+1,picture.path.length);
          print(yourCuttedString);
          var multipartFile = new http.MultipartFile('photo', stream, length,
              filename: yourCuttedString,contentType: new MediaType('image', 'png'));
          request.files.add(multipartFile);
          request.headers.addAll(heaaders);
          request.fields.addAll(mybody);
          var respons = await request.send();

          print(respons.statusCode);
          respons.stream.transform(utf8.decoder).listen((value) {
            print("message was");
            print(value);
            bod = json.decode(value);
            error = bod["error"];
            message = bod["message"];

            if(message == "success"){
              var products= bod["products"];
                  var totalPrice= bod["totalPrice"];
            var totalQty= bod["totalQty"];
            var totalbv= bod["totalbv"];
            var totalDeliveryCharge= bod["totalDeliveryCharge"];
              var postData = bod["postData"];
              sharedPreferences.setString('postData',json.encode(postData));
              sharedPreferences.setString('products',json.encode(products));
              sharedPreferences.setString('totalPrice',totalPrice.toString());
              sharedPreferences.setString('totalQty',totalQty.toString());
              sharedPreferences.setString('totalbv',totalbv.toString());
              sharedPreferences.setString('totalDeliveryCharge',totalDeliveryCharge.toString());
              Navigator.of(context).pop();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BillCardPage()));


            }else{
              Navigator.of(context).pop();

              showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(error),
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
          });


        }else{
          Navigator.of(context).pop();

          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(message1),
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



      }else {
        Navigator.of(context).pop();

        showDialog<void>(
          context: context,
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

}










