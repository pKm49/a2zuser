import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/pages/account.dart';
import 'package:image_picker/image_picker.dart';


class ChangeAvatar extends StatefulWidget {
  @override
  _ChangeAvatarState createState() => _ChangeAvatarState();
}


class _ChangeAvatarState extends State<ChangeAvatar> {
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
  String userdata,profilepicurl;
  File picture;
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

    userdata = sharedPreferences.getString('userdata');
   var usrdata = json.decode(userdata);
    var imageurl = usrdata["avatarurl"];
    int index = imageurl.lastIndexOf("/");
    String yourCuttedString = imageurl.substring( index+1,imageurl.length);
    String cook = sharedPreferences.getString('Cookie');
    String uname = sharedPreferences.getString('username');
    csrf = sharedPreferences.getString('csrf');
    setState(() {
      profilepicurl = "https://www.a2zonlineshoppy.com/public2/avatars/"+yourCuttedString;

    });
      print("csrf");
      print(csrf);

      heaaders['Accept'] = "application/JSON";
      heaaders['Cookie'] = cook;

      if(uname == null){
        isLoggedin = false;
      }else{
        setState(() {

          isLoggedin = false;
        });
      }

      if(isLoggedin){
      }else{
        setState(() {
          loading = false;
        });
      }



  }

  void updateCookie(http.Response response) async{
    print("response2");
    print(response);
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      sharedPreferences.setString('Cookie', (index == -1) ? rawCookie : rawCookie.substring(0, index));
    }
    var bod = json.decode(response.body);
    String csrf = bod["csrf"];
    sharedPreferences.setString("csrf",csrf);
  }
  Future handleSignIn() async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

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
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Change Avatar"),
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
                              profilepicurl,
                              scale: .50,
                            )
                                : FileImage(picture),
                        )
                    )),



              ),




              new Padding(padding: const EdgeInsets.only(top:30.0),child:


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
                    child: new Text("Choose file",textScaleFactor: 1.2,),
                  ),
                ),
              ),

              ),


              new Padding(padding: const EdgeInsets.only(top:15.0),child:


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

              ),

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


  void updateuser(userdata) async{
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("userdata", userdata);

  }

  void validateForm() async{
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
        var data = json.decode(userdata);

        var id = data["_id"];

        dynamic mybody = {"id":'$id','_csrf': '$csrf'};

        if(message1 == "ok"){
          var stream = new http.ByteStream(DelegatingStream.typed(picture.openRead()));
          var length = await picture.length();
          var url = Uri.parse("https://www.a2zonlineshoppy.com/api/customer/edit/avatarupload");
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
              user = bod["user"];
              userdata = json.encode(user);
              print("userdata");
              print(userdata);
              updateuser(userdata);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Account()) );
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
}










