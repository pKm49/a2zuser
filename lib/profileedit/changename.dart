import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Home.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:a2zonlinshoppy/pages/account.dart';


class ChangeName extends StatefulWidget {
  @override
  _ChangeNameState createState() => _ChangeNameState();
}


class _ChangeNameState extends State<ChangeName> {
  final String url = 'https://www.a2zonlineshoppy.com/api/isloggedin';
  final String urllogin = 'https://www.a2zonlineshoppy.com/api/customer/signin';
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController execidcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController oldpasswordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  SharedPreferences sharedPreferences;
  bool isLoggedin;
  bool loading;
  String csrf,id;
  String userdata,changeitem;
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
      loading = true;
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
    id = data["_id"];
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
          title: Text("Change $changeitem"),
        ),
      body: Stack(
        children: <Widget>[
          Visibility(
            visible: changeitem=='executive ID' ? true:false,
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
                            hintText: 'Executive ID',
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
                          controller: execidcontroller,
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
                            submitexecid();
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
            visible: changeitem=='name' ? true:false,
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
                        changename();
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
            visible: changeitem=='password' ? true:false,
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
                            hintText: 'Old Password',
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
                          controller: oldpasswordcontroller,
                          keyboardType: TextInputType.number,
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
                            hintText: 'New Password',
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
                          keyboardType: TextInputType.number,
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
                            hintText: 'Confirm Password',
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
                          controller: confirmpasswordcontroller,
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
                            changepassword();
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
            visible: changeitem=='email' ? true:false,
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
                            changeemail();
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



  void changename() async{

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

        var name = namecontroller.text;

        if(name.isEmpty){
          message1="Name Can't be Empty";
        }else{
          message1 = "ok";
        }



        print(csrf);


        dynamic mybody = {'id': '$id','name': '$name', '_csrf': '$csrf'};
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
            user = bod["user"];
            userdata = json.encode(user);
            print("userdata");
            print(userdata);
            updateuser(userdata);
            updatename(user["name"]);

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

  void changepassword() async{

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
        String error = "";
        String message = "";
        var user;

        var oldpassword = oldpasswordcontroller.text;
        var password = passwordcontroller.text;
        var confirmpassword = confirmpasswordcontroller.text;


        if(oldpassword.isEmpty){
          message1="Old Password Can't be Empty";
        }else if (password.length < 6 ){
          message1="Password must be 6 charactors atleast";
        }else{
          message1="ok";
        }


        if(password.isEmpty){
          message2="New Password Can't be Empty";
        }else if (password.length < 6 ){
          message2="New Password must be 6 charactors atleast";
        }else{
          message2="ok";
        }

        if(confirmpassword.isEmpty){
          message3="Confirm Password Can't be Empty";
        }else if (confirmpassword !=  password ){
          message3="Confirm Password must be same as New Password";
        }else{
          message3="ok";
        }


        print(csrf);


        dynamic mybody = {'id': '$id','oldpassword': '$oldpassword','newpassword': '$password', '_csrf': '$csrf'};
        print(heaaders);

        if(message1 == "ok" &&  message2 == "ok" && message3 == "ok"){

          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await client.post("https://www.a2zonlineshoppy.com/api/customer/edit/password",headers:heaaders,body:mybody);

          print("ressssssss");
          print(respons.body);

          bod = json.decode(respons.body);
          String tock = bod["tocken"];
          print("tocken");
          print(tock);

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
                content: Text(message1 +"\n" + message2 +"\n" + message3),
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

  void changeemail() async{

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

        var email = emailcontroller.text;


        if(email.isEmpty){
          message1="Email Can't be Empty";
        }else{
          Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
          RegExp regex = new RegExp(pattern);
          if(!regex.hasMatch(email)){
            message1="Email is not valid";
          }else{
            message1="ok";
          }
        }



        print(csrf);


        dynamic mybody = {'id': '$id','email': '$email', '_csrf': '$csrf'};
        print(heaaders);

        if(message1 == "ok" ){

          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await client.post("https://www.a2zonlineshoppy.com/api/customer/edit/email",headers:heaaders,body:mybody);

          print("ressssssss");
          print(respons.body);

          bod = json.decode(respons.body);
          String tock = bod["tocken"];
          print("tocken");
          print(tock);

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
  void submitexecid() async{

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

        var execid = execidcontroller.text;


        if(execid.isEmpty){
          message1="Email Can't be Empty";
        }else{
          message1="ok";
        }



        print(csrf);


        dynamic mybody = {'id': '$id','executiveid': '$execid', '_csrf': '$csrf'};
        print(heaaders);

        if(message1 == "ok" ){

          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await client.post("https://www.a2zonlineshoppy.com/api/customer/edit/executiveid",headers:heaaders,body:mybody);

          print("ressssssss");
          print(respons.body);

          bod = json.decode(respons.body);
          String tock = bod["tocken"];
          print("tocken");
          print(tock);

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

  void updateuser(userdata) async{

    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("userdata", userdata);

  }

  void updatename(name) async{

    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("name", name);

  }

  void updatepassword(password) async{

    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("password", password);

  }

  void updateemail(email) async{

    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString("email", email);

  }
}
