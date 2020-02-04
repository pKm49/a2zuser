
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Home.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}


class _RegisterState extends State<Register> {
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
  String userdata;
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
    String uname = sharedPreferences.getString('username');
    csrf = sharedPreferences.getString('csrf');

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
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()) );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: <Widget>[

              Visibility(
                visible: otpesend ? true:true,
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

                        Text("register",textAlign: TextAlign.center,textScaleFactor: 1.6,style: TextStyle(color: Colors.grey.shade700),),


                        new Padding(padding: const EdgeInsets.only(top:25.0),child:

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
                                hintText: 'Name',
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
                              controller: namecontroller,
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            )
                        ),

                        ),


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
                                hintText: 'Email',
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
                              controller: emailcontroller,
                              keyboardType: TextInputType.text,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            )
                        ),

                        ),


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
                                hintText: 'Mobile',
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
                              controller: usernamecontroller,
                              keyboardType: TextInputType.phone,
                              style: new TextStyle(
                                fontFamily: "Poppins",
                              ),
                            )
                        ),

                        ),


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
                                hintText: 'Password',
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
                              controller: passwordcontroller,
                              keyboardType: TextInputType.text,
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
                                sendOTP();
                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              child: new Text("register",textScaleFactor: 1.2,),
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
                visible: otpesend ? false:true,
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

                        Text("enter OTP",textAlign: TextAlign.center,textScaleFactor: 1.6,style: TextStyle(color: Colors.grey.shade700),),

                        new Padding(padding: const EdgeInsets.only(top:25.0),child:


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
                              color: Colors.red,
                              onPressed: (){
                                validateForm();
                              },
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              child: new Text("Submit",textScaleFactor: 1.2,),
                            ),
                          ),
                        ),

                        ),
                      ],
                    )),
                  ),
                ),
              )


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


  void sendOTP() async{
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
        String message2 = "";
        String message3 = "";
        String message4 = "";
        String error = "";
        String message = "";
        String mobile = "";
        String name = "";
        var user;

        var username = usernamecontroller.text;
        var usersname = namecontroller.text;
        var password = passwordcontroller.text;
        var email = emailcontroller.text;


        if(usersname.isEmpty){
          message1="Name Can't be Empty";
        }else if (usersname.length < 4 ){
          message1="Password must be 4 charactors atleast";
        }else{
          message1="ok";
        }

        print(usersname);

        if(email.isEmpty){
          message2="Name Can't be Empty";
        }else{
          Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
          RegExp regex = new RegExp(pattern);
          if(!regex.hasMatch(email)){
            message2="Email is not valid";
          }else{
            message2="ok";
          }
        }

        if(username.isEmpty){
          message3="MobileNumber Can't be Empty";
        }else{
          Pattern pattern = r'^[0-9]{10}$';
          RegExp regex = new RegExp(pattern);
          if(!regex.hasMatch(username)){
            message3="MobileNumber is not valid";
          }else{
            message3="ok";
          }
        }

        if(password.isEmpty){
          message4="Password Can't be Empty";
        }else if (password.length < 6 ){
          message4="Password must be 6 charactors atleast";
        }else{
          message4="ok";
        }
        var cardholder = "false";
        dynamic mybody = {"cardholder":'$cardholder',"name":'$usersname','email': '$email','username': '$username','password': '$password', '_csrf': '$csrf'};

        if(message1 == "ok" && message2 =="ok" && message3 =="ok"&& message4 =="ok"){

          dynamic respons = await client.post("https://www.a2zonlineshoppy.com/api/customer/register",headers:heaaders,body:mybody);

          print(respons.body);
          print(respons.headers['set-cookie']);

          bod = json.decode(respons.body);

          error = bod["error"];
          message = bod["message"];
          print("response is as follows");
          print(error);
          print(bod);
          if(message == "success"){


            sharedPreferences = await SharedPreferences.getInstance();

            sharedPreferences.setString("name", usersname);
            sharedPreferences.setString("mobile", mobile);
            sharedPreferences.setString("email", email);
            sharedPreferences.setString("username", username);
            sharedPreferences.setString("password", password);
            Navigator.of(context).pop();
            setState(() {
              otpesend = false;
            });
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
        }else{
          Navigator.of(context).pop();

          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(message1+"\n"+message2+"\n"+message3+"\n"+message4),
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


        var otp = otpcontroller.text;


        if(otp.isEmpty){
          message1="OTP can't be empty";
        }else if (otp.length < 4 ){
          message1="OTP must be 4 charactors atleast";
        }else{
          message1="ok";
        }


        sharedPreferences = await SharedPreferences.getInstance();

        var name = sharedPreferences.getString("name");
        var email =   sharedPreferences.getString("email");
        var username =  sharedPreferences.getString("username");
        var password = sharedPreferences.getString("password");
        var cardholder = "false";




        dynamic mybody = {"cardholder":'$cardholder',"name": "$name",'email': '$email','username': '$username','password': '$password','otp': '$otp', '_csrf': '$csrf'};

        if(message1 == "ok"){

          dynamic respons = await client.post("https://www.a2zonlineshoppy.com/api/customer/signup",headers:heaaders,body:mybody);

          print(respons.body);
          print(respons.headers['set-cookie']);

          bod = json.decode(respons.body);
          String tock = bod["tocken"];

          error = bod["error"];
          message = bod["message"];
          if(message == "success"){
            user = bod["user"];
            userdata = json.encode(user);
            print("userdata");
            print(userdata);
            name = user["name"];
            mobile = user["username"];
            email = user["email"];
            print(error);
            print(respons);
            print(name);
            print(mobile);
            print(email);
            print(username);
            print(password);

            sharedPreferences = await SharedPreferences.getInstance();

            sharedPreferences.setString("name", name);
            sharedPreferences.setString("mobile", mobile);
            sharedPreferences.setString("isloggedin", "true");
            sharedPreferences.setString("email", email);
            sharedPreferences.setString("userdata", userdata);
            sharedPreferences.setString("tocken", tock);
            sharedPreferences.setString("username", username);
            sharedPreferences.setString("password", password);
            Navigator.of(context).pop();

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()) );
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










