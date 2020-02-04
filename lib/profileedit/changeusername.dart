import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Home.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:a2zonlinshoppy/pages/account.dart';


class ChangeUserName extends StatefulWidget {
  @override
  _ChangeUserNameState createState() => _ChangeUserNameState();
}


class _ChangeUserNameState extends State<ChangeUserName> {
  final String url = 'https://www.a2zonlineshoppy.com/api/isloggedin';
  final String urllogin = 'https://www.a2zonlineshoppy.com/api/customer/signin';
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  SharedPreferences sharedPreferences;
  bool isLoggedin;
  bool mobilevisible;
  String csrf,oldusername;
  String userdata,changeitem,cardholder;
  var client = http.Client();
  var bod;
  Map<String, String> heaaders = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }


  void isSignedIN() async{
    final String url = 'https://www.a2zonlineshoppy.com/api/isloggedin';
    setState(() {
      mobilevisible = true;
    });
    sharedPreferences = await SharedPreferences.getInstance();
    String cook = sharedPreferences.getString('Cookie');
      print("cock is not null");
      print(cook);
      String uname = sharedPreferences.getString('username');
      csrf = sharedPreferences.getString('csrf');
    changeitem = sharedPreferences.getString('changeitem');
    userdata = sharedPreferences.getString('userdata');
    var data = json.decode(userdata);
    oldusername = data["username"];
    cardholder = data["cardholder"];
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




  }

  void updateCookie(http.Response response) async{
    print("response2");
    print(response);
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      print("cookies");
      print((index == -1) ? rawCookie : rawCookie.substring(0, index));
      sharedPreferences.setString('Cookie', (index == -1) ? rawCookie : rawCookie.substring(0, index));
    }
    var bod = json.decode(response.body);
    String csrf = bod["csrf"];
    sharedPreferences.setString("csrf",csrf);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: new AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.red,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Change Username"),
        ),
      body: Stack(
        children: <Widget>[

          Visibility(
            visible: mobilevisible ? true:false,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade50,
                child:
                new Padding(padding: const EdgeInsets.only(right: 25.0,left:25.0),child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    new Padding(padding: const EdgeInsets.only(top:15.0),child:


                    new Container(
                        decoration: new BoxDecoration(
                          boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),],
                          color: Colors.white,
                          borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
                        ),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'New Mobile',
                            contentPadding: const EdgeInsets.all(20.0),
                            fillColor: Colors.white,
                            focusedBorder: InputBorder.none,
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                                  color: Colors.white,width: 1.0
                              ),
                            ),
                            //fillColor: Colors.green
                          ),
                          controller: mobilecontroller,
                          keyboardType: TextInputType.phone,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        )
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
                      color: Colors.blue,
                      onPressed: (){
                        sendotp();
                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: new Text("Update",textScaleFactor: 1.2,),
                    ),
                  ),
                ),

                ),



                  ],
                )),
              ),
            ),
          ),

          Visibility(
            visible: mobilevisible==true ? false:true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade50,
                child:
                new Padding(padding: const EdgeInsets.only(right: 25.0,left:25.0),child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[


                    new Padding(padding: const EdgeInsets.only(top:15.0),child:


                    new Container(
                        decoration: new BoxDecoration(
                          boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),],
                          color: Colors.white,
                          borderRadius: new BorderRadius.all(const Radius.circular(40.0)),
                        ),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'OTP',
                            contentPadding: const EdgeInsets.all(20.0),
                            fillColor: Colors.white,
                            focusedBorder: InputBorder.none,
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                                  color: Colors.white,width: 1.0
                              ),
                            ),
                            //fillColor: Colors.green
                          ),
                          controller: otpcontroller,
                          keyboardType: TextInputType.number,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        )
                    ),

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
                            changeusername();
                          },
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          child: new Text("Update",textScaleFactor: 1.2,),
                        ),
                      ),
                    ),

                    ),



                  ],
                )),
              ),
            ),
          ),

    ]
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


  void changeusername() async{

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
        String message1 = "";
        String error = "";
        String message = "";
        var user;

        var otp = otpcontroller.text;


        if(otp.isEmpty){
          message1="OTP Can't be Empty";
        }else if (otp.length < 6 ){
          message1="OTP must be 6 charactors";
        }else{
          message1="ok";
        }




        print(csrf);


        dynamic mybody = {'oldusername':'$oldusername','cardholder':'$cardholder','otp':'$otp', '_csrf': '$csrf'};
        print(heaaders);

        if(message1 == "ok" ){

          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await client.post("https://www.a2zonlineshoppy.com/api/customer/edit/name",headers:heaaders,body:mybody);

          print("ressssssss");
          print(respons.body);

          bod = json.decode(respons.body);
          String tock = bod["tocken"];
          print("tocken");
          print(tock);

          error = bod["error"];
          message = bod["message"];
          if(message == "success"){
           setState(() {
             mobilevisible =false;
           });

          }else{
            Navigator.of(context).pop();

            showDialog<void>(
              context: context,
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



        }else{
          Navigator.of(context).pop();

          showDialog<void>(
            context: context,
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
        // Internet Present Case
      }else {
        Navigator.of(context).pop();
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

  void sendotp() async{

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
        String message1 = "";
        String error = "";
        String message = "";
        var username;

        var newusername = mobilecontroller.text;

        if(newusername.isEmpty){
          message1="MobileNumber Can't be Empty";
        }else{
          Pattern pattern = r'^[0-9]{10}$';
          RegExp regex = new RegExp(pattern);
          if(!regex.hasMatch(newusername)){
            message1="MobileNumber is not valid";
          }else{
            message1="ok";
          }
        }


        print(csrf);


        dynamic mybody = {'newusername': '$newusername', '_csrf': '$csrf'};
        print(heaaders);

        if(message1 == "ok"){

          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await client.post("https://www.a2zonlineshoppy.com/api/customer/edit/sendotp",headers:heaaders,body:mybody);

          print("ressssssss");
          print(respons.body);

          bod = json.decode(respons.body);
          String tock = bod["tocken"];
          print("tocken");
          print(tock);

          error = bod["error"];
          message = bod["message"];
          if(message == "success"){
            username = bod["username"];
            userdata = json.encode(username);
            print("userdata");
            print(userdata);
            updateuser(userdata);
            updateusername(username);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Account()) );
          }else{
            Navigator.of(context).pop();

            showDialog<void>(
              context: context,
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



        }else{
          Navigator.of(context).pop();

          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(message1 +"\n"),
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
        // Internet Present Case
      }else {
        Navigator.of(context).pop();
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



  void updateuser(userdata) async{

    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("userdata", userdata);

  }

  void updateusername(username) async{

    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("username", username);

  }

}
