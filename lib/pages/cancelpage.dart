import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//appspecific imports

import  'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:a2zonlinshoppy/pages/bill.dart';
import 'package:a2zonlinshoppy/pages/orders.dart';

class CancelPage extends StatefulWidget {
  @override
  _CancelPageState createState() => _CancelPageState();
}

class _CancelPageState extends State<CancelPage> {

  SharedPreferences sharedPreferences;
  String name,mobile,cook,csrf,tock,orderid,index;
  Map<String, String> heaaders = {};
  bool codenable,cod,sameasshipping = true;
  var products;

  TextEditingController reasoncontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }


  void isSignedIN() async{

    sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      name = sharedPreferences.getString('name');
      mobile = sharedPreferences.getString('mobile');
      orderid = sharedPreferences.getString('orderid');
      index = sharedPreferences.getString('productindex');
    });

    cook = sharedPreferences.getString('Cookie');
    tock = sharedPreferences.getString('tocken');
    csrf = sharedPreferences.getString('csrf');

    print("cookiesaddress");
    print(cook);


    if(tock!=null){
      heaaders['authorization'] = "tocken "+tock;
    }

    heaaders['Accept'] = "application/JSON";
    heaaders['Cookie'] = cook;

  }
  void oncodchanged(bool tile) async {

    setState(() {
      codenable = tile;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('codenabled',tile.toString());
    print('codenabled');
    print(sharedPreferences.getString('codenabled'));
  }

  void onsameasshippingchanged(bool tile) async {

    setState(() {
      sameasshipping = tile;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('sameasshipping',tile.toString());
    print('sameasshipping');
    print(sharedPreferences.getString('sameasshipping'));
  }




  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          backgroundColor: Colors.red,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Cancel Order"),
        ),

      //Body
      body:  Container(
        height:MediaQuery.of(context).size.height *1.0 ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Visibility(
                visible: true,
                child: Column(
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.only(top: 20.0),child:
                    Text("Please let us know why you are cancelling this order.",textAlign: TextAlign.center,textScaleFactor: 1.30,style: TextStyle(fontWeight: FontWeight.bold),)),


                    new Padding(padding: const EdgeInsets.only(top:15.0,left:15.0,right:15.0),child:


                    new Container(
                        decoration: new BoxDecoration(
                          boxShadow: [BoxShadow(
                            color: Colors.grey,
                            blurRadius: 4.0,
                          ),],
                          color: Colors.white,
                          borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
                        ),
                        child: TextFormField(
                          decoration: new InputDecoration(
                            hintText: 'Reason',
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
                          maxLines: 20,
                          minLines: 10,
                          controller: reasoncontroller,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        )
                    ),

                    ),




                    new Padding(padding: const EdgeInsets.only(top:30.0,left:15.0,right:15.0),child:


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
                            validateForm();
                          },
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                          child: new Text("Submit",textScaleFactor: 1.2,),
                        ),
                      ),
                    ),

                    ),

            ]
        ),
      )
]
    ))   );


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
          String codproducts,pgproducts;
          bool isempty =false;

          var cancelreason = reasoncontroller.text;


          if(cancelreason.isEmpty){
            isempty =true;
            showdia("Reason can't be empty");
          }



          print(heaaders);

          if(isempty == false){

            dynamic mybody = {'orderid': '$orderid', 'cancelreason': '$cancelreason', 'index': '$index', '_csrf': '$csrf'};

            sharedPreferences = await SharedPreferences.getInstance();
            http.Response respons = await http.post("https://www.a2zonlineshoppy.com/api/cancelorder",headers:heaaders,body:mybody);

            print("ressssssss");
            print(respons.body);
            print(respons.headers);

            var bod = json.decode(respons.body);
            String message = bod["message"];

            if(message=="success"){

              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Orders()) );

            }else{
              Navigator.of(context).pop();

              showdia("Try again");
            }


          }else{
            Navigator.of(context).pop();

            showdia("Try again with valid input");

          }



      }else{
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


  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
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


