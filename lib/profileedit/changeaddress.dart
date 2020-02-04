import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Home.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:a2zonlinshoppy/pages/account.dart';


class ChangeAddress extends StatefulWidget {
  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}


class _ChangeAddressState extends State<ChangeAddress> {
  final String url = 'https://www.a2zonlineshoppy.com/api/isloggedin';
  final String urllogin = 'https://www.a2zonlineshoppy.com/api/customer/signin';
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController housecontroller = TextEditingController();
  TextEditingController postofficecontroller = TextEditingController();
  TextEditingController nearesttowncontroller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
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
          title: Text("Change Address"),
        ),
      body:

          Container(

            child: ListView(
              children: <Widget>[


                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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
                        hintText: 'Full Name',
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
                      controller: fullnamecontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                ),

                ),

                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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
                      controller: mobilecontroller,
                      keyboardType: TextInputType.phone,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                ),

                ),

                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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

                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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
                        hintText: 'House',
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
                      controller: housecontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                ),

                ),

                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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
                        hintText: 'Post Office',
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
                      controller: postofficecontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                ),

                ),


                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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
                        hintText: 'Location',
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
                      controller: locationcontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                ),

                ),



                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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
                        hintText: 'Nearest Town',
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
                      controller: nearesttowncontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                ),

                ),

                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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
                        hintText: 'District',
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
                      controller: districtcontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                ),

                ),

                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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
                        hintText: 'State',
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
                      controller: statecontroller,
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                ),

                ),

                new Padding(padding: const EdgeInsets.only(top:15.0,right: 25.0,left:25.0),child:
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
                        hintText: 'Pin',
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
                      controller: pincontroller,
                      keyboardType: TextInputType.number,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    )
                ),

                ),




                new Padding(padding: const EdgeInsets.only(top:30.0,right: 25.0,left:25.0,bottom: 30.0),child:


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
                        changeaddress();
                      },
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: new Text("Update",textScaleFactor: 1.2,),
                    ),
                  ),
                ),

                ),

              ],
            ),
          ),



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


  void changeaddress() async{

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



        var customername = fullnamecontroller.text;
        var mobile=mobilecontroller.text;
        var email=emailcontroller.text;
        var house=housecontroller.text;
        var postoffice=postofficecontroller.text;
        var city = nearesttowncontroller.text;
        var location = locationcontroller.text;
        var district=districtcontroller.text;
        var state=statecontroller.text;
        var pincode= pincontroller.text;


        bool isempty =false;
        if(customername.isEmpty){
          isempty =true;
          showdia("Name can't be empty");
        }else if(mobile.isEmpty){
          isempty =true;
          showdia("Mobile can't be empty");
        }else if(!(mobile.isEmpty)){
          Pattern pattern = r'^[0-9]{10}$';
          RegExp regex = new RegExp(pattern);
          if(!regex.hasMatch(mobile)){
            isempty =true;
            showdia("MobileNumber is not valid");
          }
        }else if(email.isEmpty){
          isempty =true;
          showdia("Email can't be empty");
        }else if(!(email.isEmpty)){
          Pattern pattern = r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$';
          RegExp regex = new RegExp(pattern);
          if(!regex.hasMatch(email)){
            isempty =true;
            showdia("Email is not valid");
          }
        }else if(house.isEmpty){
          isempty =true;
          showdia("House can't be empty");
        }else if(postoffice.isEmpty){
          isempty =true;
          showdia("Postoffice can't be empty");
        }else if(location.isEmpty){
          isempty =true;
          showdia("Location can't be empty");
        }else if(city.isEmpty){
          isempty =true;
          showdia("Nearest Town can't be empty");
        }else if(district.isEmpty){
          isempty =true;
          showdia("District can't be empty");
        }else if(state.isEmpty){
          isempty =true;
          showdia("State can't be empty");
        }else if(pincode.isEmpty){
          isempty =true;
          showdia("Pincode can't be empty");
        }else if(!(pincode.isEmpty)){
          Pattern pattern = r'^[0-9]{6}$';
          RegExp regex = new RegExp(pattern);
          if(!regex.hasMatch(mobile)){
            isempty =true;
            showdia("Pincode is not valid");
          }
        }


        print(csrf);

        dynamic mybody = {'id': '$id','name': '$customername','mobile': '$mobile','email': '$email','house': '$house','postoffice': '$postoffice','location': '$location','city': '$city','district': '$district','state': '$state', 'pincode': '$pincode', '_csrf': '$csrf'};

        print(heaaders);

        if(isempty == false){

          sharedPreferences = await SharedPreferences.getInstance();
          http.Response respons = await client.post("https://www.a2zonlineshoppy.com/api/customer/edit/$changeitem",headers:heaaders,body:mybody);

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
  void showdia(String message){
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
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
}
