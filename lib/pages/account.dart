/// ListTile

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:a2zonlinshoppy/profileedit/changeavatar.dart';
import 'package:a2zonlinshoppy/profileedit/changename.dart';
import 'package:a2zonlinshoppy/profileedit/changeusername.dart';
import 'package:a2zonlinshoppy/profileedit/changeaddress.dart';
import 'dart:convert';
import 'package:a2zonlinshoppy/authentication/login.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  @override
  AccountState createState() => AccountState();
}

class AccountState extends State<Account> {
  SharedPreferences sharedPreferences;
  String name,
      mobile,
      email,
      userdata,
      address,
      cardholder,execid,policycode,validfrom,validto,
      profileurl,cardtype;
  Map<String, String> heaaders = {};
  String cook;
  int points;
var deladdress1,
    deladdress2,
    deladdress3;
  String tock;

  String csrf;

  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  void isSignedIN() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString('name');
      email = sharedPreferences.getString('email');
      mobile = sharedPreferences.getString('mobile');
      userdata = sharedPreferences.getString('userdata');
      print(userdata);
      data = json.decode(userdata);
      var imageurl = data["avatarurl"];
      int index = imageurl.lastIndexOf("/");
      String yourCuttedString = imageurl.substring(index + 1, imageurl.length);
      profileurl =
          "https://www.a2zonlineshoppy.com/public2/avatars/" + yourCuttedString;
      print(profileurl);
      email = data["email"];
      points = data["points"];
      execid = data["executiveid"];
      policycode = data["policycode"];

      cardtype = data["cardtype"];
      deladdress1 = data["deladdress0"];
      cardholder = data["cardholder"];
      deladdress2 = data["deladdress1"];
      deladdress3 = data["deladdress2"];

      if(cardholder == "true"){
        String valfrom = data["validfrom"];
        String valto = data["validto"];
        var dat = DateTime.parse(valfrom);
        var format = new DateFormat("dd-MM-yyyy");

        validfrom = format.format(dat);

        var dat1 = DateTime.parse(valto);
        var format1 = new DateFormat("dd-MM-yyyy");

        validto = format1.format(dat1);
      }


      cook = sharedPreferences.getString('Cookie');
      tock = sharedPreferences.getString('tocken');
      csrf = sharedPreferences.getString('csrf');
      print(name);
      print(mobile);
      print(email);

      if (tock != null) {
        heaaders['authorization'] = "tocken " + tock;
      }

      heaaders['Accept'] = "application/JSON";
      heaaders['Cookie'] = cook;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0.0,
        title: Text("Account"),
      ),

      //Body
      body: new ListView(
        children: <Widget>[
          Visibility(
            visible: name == null ? true : false,
            child: Container(
              height: MediaQuery.of(context).size.height * .87,
              color: Colors.grey.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                         left: 50.0, right: 50.0),
                    child: new CircleAvatar(
                      radius: 60.0,
                      backgroundColor: Colors.white,
                      child: Image.network(
                       'https://www.a2zonlineshoppy.com/public2/avatars/default.png',
                        scale: 1.0,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          'Hello there, you are not logged in',
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.5,
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          'login here',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.3,
                        )),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: name == null ? false : true,
            child: Container(
              height: MediaQuery.of(context).size.height * .90,
              padding: const EdgeInsets.all(2.0),
              color:  Colors.grey.shade50,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0,left: 150.0,right: 150.0),
                    child:
                      new Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: new BoxDecoration(

                              color: Colors.blue,
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.scaleDown,
                                image: NetworkImage(
                                  profileurl != null
                                      ? profileurl
                                      : 'https://www.a2zonlineshoppy.com/public2/avatars/default.png',
                                  scale: 1.0,

                                )
                              )
                          ))

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangeAvatar()));
                            },
                            child: Text(
                              'Change Photo',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800),
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.3,
                            )),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        color: Colors.grey.shade50,
                        border: new Border(
                            bottom: BorderSide(color: Colors.grey.shade200))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 45.0, left: 15.0, right: 15.0, bottom: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Name',
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.3,
                              ),
                              Text(
                                '$name',
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.3,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade800),
                              )
                            ],
                          ),
                          InkWell(
                              onTap: () async {

                                sharedPreferences = await SharedPreferences.getInstance();
                                sharedPreferences.setString("changeitem", 'name');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeName()));
                              },
                              child: Icon(Icons.edit, color: Colors.blue))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        color: Colors.grey.shade50,
                        border: new Border(
                            bottom: BorderSide(color: Colors.grey.shade200))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Mobile',
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.3,
                              ),
                              Text(
                                '$mobile',
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.3,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeUserName()));
                              },
                              child: Icon(Icons.edit, color: Colors.blue))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        color: Colors.grey.shade50,
                        border: new Border(
                            bottom: BorderSide(color: Colors.grey.shade200))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Password',
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.3,
                              ),
                              Text(
                                '************',
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.3,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          InkWell(
                              onTap: () async{
                                sharedPreferences = await SharedPreferences.getInstance();
                                sharedPreferences.setString("changeitem", 'password');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeName()));
                              },
                              child: Icon(Icons.edit, color: Colors.blue))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                        color: Colors.grey.shade50,
                        border: new Border(
                            bottom: BorderSide(color: Colors.grey.shade200))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Email',
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.3,
                              ),
                              Text(
                                '$email',
                                textAlign: TextAlign.start,
                                textScaleFactor: 1.3,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          InkWell(
                              onTap: () async{
                                sharedPreferences = await SharedPreferences.getInstance();
                                sharedPreferences.setString("changeitem", 'email');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeName()));
                              },
                              child: Icon(Icons.edit, color: Colors.blue))
                        ],
                      ),
                    ),
                  ),
                  ExpansionTile(
          key: new PageStorageKey<int>(3),
      title: new Text("Shipping Addresses", style: TextStyle(color: Colors.grey.shade800),textAlign: TextAlign.start,textScaleFactor: 1.3,),
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
              color: Colors.grey.shade50,
              border: new Border(
                  bottom: BorderSide(color: Colors.grey.shade200))),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Shipping Address #1',
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                    ),
                    deladdress1 == null
                        ? Text(
                      'Not Updated',
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          deladdress1['name'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          deladdress1['house'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          deladdress1['postoffice'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress1['location'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        )
                        ,Text(
                          deladdress1['city'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress1['district'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress1['state'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress1['pincode'].toString(),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress1['mobile'].toString(),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress1['email'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                InkWell(
                    onTap: () async{
                      sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setString("changeitem", 'shippingaddressone');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeAddress()));
                    },
                    child: Icon(Icons.edit, color: Colors.blue))
              ],
            ),
          ),
        ),
        Container(
          decoration: new BoxDecoration(
              color: Colors.grey.shade50,
              border: new Border(
                  bottom: BorderSide(color: Colors.grey.shade200))),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Shipping Address #2',
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                    ),
                    deladdress2 == null
                        ? Text(
                      'Not Updated',
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          deladdress2['name'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          deladdress2['house'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          deladdress2['postoffice'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress2['location'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        )
                        ,Text(
                          deladdress2['city'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress2['district'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress2['state'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress2['pincode'].toString(),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress2['mobile'].toString(),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress2['email'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                InkWell(
                    onTap: () async{
                      sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setString("changeitem", 'shippingaddresstwo');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeAddress()));
                    },
                    child: Icon(Icons.edit, color: Colors.blue))
              ],
            ),
          ),
        ),


        Container(
          decoration: new BoxDecoration(
              color: Colors.grey.shade50,
              border: new Border(
                  bottom: BorderSide(color: Colors.grey.shade200))),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Shipping Address #3',
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                    ),
                    deladdress3 == null
                        ? Text(
                      'Not Updated',
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          deladdress3['name'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          deladdress3['house'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          deladdress3['postoffice'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress3['location'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        )
                        ,Text(
                          deladdress3['city'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress3['district'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress3['state'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress3['pincode'].toString(),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress3['mobile'].toString(),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),Text(
                          deladdress3['email'],
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
                InkWell(
                    onTap: () async{
                      sharedPreferences = await SharedPreferences.getInstance();
                      sharedPreferences.setString("changeitem", 'shippingaddressthree');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeAddress()));
                    },
                    child: Icon(Icons.edit, color: Colors.blue))
              ],
            ),
          ),
        ),


      ],
    ),


                  ExpansionTile(
                    key: new PageStorageKey<int>(3),
                    title: new Text("Privilege Card Details", style: TextStyle(color: Colors.grey.shade800),textAlign: TextAlign.start,textScaleFactor: 1.3,),
                    children: <Widget>[
                      Visibility(
                        visible: cardholder == true?true:false,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Visibility(
                                    visible: cardtype == null?true:false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            decoration: new BoxDecoration(
                                                color: Colors.grey.shade50,
                                                border: new Border(
                                                    bottom: BorderSide(color: Colors.grey.shade200))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        'Executive ID',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                      ),
                                                      Text(
                                                        '$execid',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: new BoxDecoration(
                                                color: Colors.grey.shade50,
                                                border: new Border(
                                                    bottom: BorderSide(color: Colors.grey.shade200))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        'Points',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                      ),
                                                      Text(
                                                        '$points',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: cardtype == null?false:true,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            decoration: new BoxDecoration(
                                                color: Colors.grey.shade50,
                                                border: new Border(
                                                    bottom: BorderSide(color: Colors.grey.shade200))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        'Card Type',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                      ),
                                                      Text(
                                                        '$cardtype',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: new BoxDecoration(
                                                color: Colors.grey.shade50,
                                                border: new Border(
                                                    bottom: BorderSide(color: Colors.grey.shade200))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        'Policy Code',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                      ),
                                                      Text(
                                                        '$policycode',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: new BoxDecoration(
                                                color: Colors.grey.shade50,
                                                border: new Border(
                                                    bottom: BorderSide(color: Colors.grey.shade200))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        'Validity',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                      ),
                                                      Text(
                                                        '$validfrom - $validto',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          Container(
                                            decoration: new BoxDecoration(
                                                color: Colors.grey.shade50,
                                                border: new Border(
                                                    bottom: BorderSide(color: Colors.grey.shade200))),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        'Points',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                      ),
                                                      Text(
                                                        '$points',
                                                        textAlign: TextAlign.start,
                                                        textScaleFactor: 1.3,
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  },
                                  child: Icon(Icons.edit, color: Colors.blue))
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: cardholder == true?false:true,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 25.0, left: 15.0, right: 15.0, bottom: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[


                              new Padding(padding: const EdgeInsets.all(10.0),child:


                              new Container(
                                width: MediaQuery.of(context).size.width * .80,

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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()));                                    },
                                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                    child: new Text("Purchase Privilege Card",textScaleFactor: 1.2,),
                                  ),
                                ),
                              ),

                              ),

                            ],
                          ),
                        ),
                      ),

                      Visibility(
                        visible: cardholder == true?false:true,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 15.0, right: 15.0, bottom: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              new Padding(padding: const EdgeInsets.all(10.0),child:


                              new Container(
                                width: MediaQuery.of(context).size.width * .80,

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
                                    onPressed: ()async{
                                      sharedPreferences = await SharedPreferences.getInstance();
                                      sharedPreferences.setString("changeitem", 'executive ID');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChangeName()));
                                                                         },
                                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                    child: new Text("Submit Executive ID",textScaleFactor: 1.2,),
                                  ),
                                ),
                              ),

                              ),


                            ],
                          ),
                        ),
                      ),




                    ],
                  ),


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
