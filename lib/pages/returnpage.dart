import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//appspecific imports

import  'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'dart:async';
import 'package:async/async.dart';
import 'package:a2zonlinshoppy/pages/bill.dart';
import 'package:a2zonlinshoppy/pages/orders.dart';
import 'package:image_picker/image_picker.dart';

class ReturnPage extends StatefulWidget {
  @override
  _ReturnPageState createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {

  SharedPreferences sharedPreferences;
  String name,mobile,cook,csrf,tock,orderid,index;
  Map<String, String> heaaders = {};
  bool codenable,cod,sameasshipping = true;
  var products,bod;
  File picture1;
  File picture2;
  File picture3;
  File picture4;

  TextEditingController reasoncontroller = TextEditingController();
  TextEditingController bankcontroller = TextEditingController();
  TextEditingController acnocontroller = TextEditingController();
  TextEditingController ifsccontroller = TextEditingController();

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
          title: Text("Return Order"),
        ),

      //Body
      body:  Container(
        height:MediaQuery.of(context).size.height *1.0 ,
        child: ListView(
            children: <Widget>[
              Visibility(
                visible: true,
                child: Column(
                  children: <Widget>[

                    new Padding(padding: const EdgeInsets.only(top: 20.0,left:5.0,right:5.0,bottom: 20.0),child:
                    Text("Please upload photos of the item you recieved.",textAlign: TextAlign.center,textScaleFactor: 1.30,style: TextStyle(fontWeight: FontWeight.bold),)),

                    Row(
                      children: <Widget>[

                       Expanded(
                         flex: 1,
                         child:  new Padding(padding: const EdgeInsets.all(15.0),child:

                         new Container(
                           width: MediaQuery.of(context).size.width * .45,
                           height: MediaQuery.of(context).size.width * .45,

                           decoration: new BoxDecoration(
                             boxShadow: [BoxShadow(
                               color: Colors.grey,
                               blurRadius: 4.0,
                             ),],
                             color: Colors.white,
                             borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
                           ),
                           child: Column(
                             children: <Widget>[

                               Expanded(
                                 flex:5,
                                 child:  Padding(
                                   padding: const EdgeInsets.only(
                                       top:5.0,bottom: 5.0 ),
                                   child:
                                   new Container(
                                       decoration: new BoxDecoration(

                                           shape: BoxShape.rectangle,
                                           image: new DecorationImage(
                                             fit: BoxFit.cover,
                                             image: picture1 == null
                                                 ?  AssetImage(
                                               'images/product.png',
                                             )
                                                 : FileImage(picture1),
                                           )
                                       )),



                                 ),
                               ),

                               Expanded(
                                 flex:2,
                                 child: new Padding(padding: const EdgeInsets.only(top:0.0),child:


                                 ButtonTheme(

                                   minWidth: 200.0,
                                   height: 60.0,
                                   child: RaisedButton(

                                     color: Colors.grey.shade50,
                                     onPressed: (){
                                       _optionsDialogBox(1);

                                     },
                                     child: new Text("Choose File",textScaleFactor: 1.2,),
                                   ),
                                 )
                                 ),
                               )



                             ],
                           ),
                         ),

                         ),
                       ),

                        Expanded(
                          flex: 1,
                          child: new Padding(padding: const EdgeInsets.all(15.0),child:

                          new Container(
                            width: MediaQuery.of(context).size.width * .45,
                            height: MediaQuery.of(context).size.width * .45,

                            decoration: new BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4.0,
                              ),],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
                            ),
                            child: Column(
                              children: <Widget>[

                                Expanded(
                                  flex:5,
                                  child:  Padding(
                                    padding: const EdgeInsets.only(
                                       top:5.0,bottom: 5.0 ),
                                    child:
                                    new Container(
                                        decoration: new BoxDecoration(

                                            shape: BoxShape.rectangle,
                                            image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: picture2 == null
                                                  ?  NetworkImage(
                                                'https://a2zonlineshoppy.com/images/product.png',
                                                scale: .5
                                              )
                                                  : FileImage(picture2),
                                            )
                                        )),



                                  ),
                                ),

                                Expanded(
                                  flex:2,
                                  child: new Padding(padding: const EdgeInsets.only(top:0.0),child:


                                  ButtonTheme(

                                    minWidth: 200.0,
                                    height: 60.0,
                                    child: RaisedButton(

                                      color: Colors.grey.shade50,
                                      onPressed: (){
                                        _optionsDialogBox(2);

                                      },
                                      child: new Text("Choose File",textScaleFactor: 1.2,),
                                    ),
                                  )
                                  ),
                                )



                              ],
                            ),
                          ),

                          ),

                        )


                      ],
                    ),

                    Row(
                      children: <Widget>[

                        Expanded(
                          flex: 1,
                          child:  new Padding(padding: const EdgeInsets.all(15.0),child:

                          new Container(
                            width: MediaQuery.of(context).size.width * .45,
                            height: MediaQuery.of(context).size.width * .45,

                            decoration: new BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4.0,
                              ),],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
                            ),
                            child: Column(
                              children: <Widget>[

                                Expanded(
                                  flex:5,
                                  child:  Padding(
                                    padding: const EdgeInsets.only(
                                        top:5.0,bottom: 5.0 ),
                                    child:
                                    new Container(
                                        decoration: new BoxDecoration(

                                            shape: BoxShape.rectangle,
                                            image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: picture3 == null
                                                  ?  NetworkImage(
                                                'https://a2zonlineshoppy.com/images/product.png',
                                                scale: .50,
                                              )
                                                  : FileImage(picture3),
                                            )
                                        )),



                                  ),
                                ),

                                Expanded(
                                  flex:2,
                                  child: new Padding(padding: const EdgeInsets.only(top:0.0),child:


                                  ButtonTheme(

                                    minWidth: 200.0,
                                    height: 60.0,
                                    child: RaisedButton(

                                      color: Colors.grey.shade50,
                                      onPressed: (){
                                        _optionsDialogBox(3);

                                      },
                                      child: new Text("Choose File",textScaleFactor: 1.2,),
                                    ),
                                  )
                                  ),
                                )



                              ],
                            ),
                          ),

                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: new Padding(padding: const EdgeInsets.all(15.0),child:

                          new Container(
                            width: MediaQuery.of(context).size.width * .45,
                            height: MediaQuery.of(context).size.width * .45,

                            decoration: new BoxDecoration(
                              boxShadow: [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 4.0,
                              ),],
                              color: Colors.white,
                              borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
                            ),
                            child: Column(
                              children: <Widget>[

                                Expanded(
                                  flex:5,
                                  child:  Padding(
                                    padding: const EdgeInsets.only(
                                        top:5.0,bottom: 5.0 ),
                                    child:
                                    new Container(
                                        decoration: new BoxDecoration(

                                            shape: BoxShape.rectangle,
                                            image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: picture4 == null
                                                  ?  NetworkImage(
                                                  'https://a2zonlineshoppy.com/images/product.png',
                                                  scale: .5
                                              )
                                                  : FileImage(picture4),
                                            )
                                        )),



                                  ),
                                ),

                                Expanded(
                                  flex:2,
                                  child: new Padding(padding: const EdgeInsets.only(top:0.0),child:


                                  ButtonTheme(

                                    minWidth: 200.0,
                                    height: 60.0,
                                    child: RaisedButton(

                                      color: Colors.grey.shade50,
                                      onPressed: (){
                                        _optionsDialogBox(4);

                                      },
                                      child: new Text("Choose File",textScaleFactor: 1.2,),
                                    ),
                                  )
                                  ),
                                )



                              ],
                            ),
                          ),

                          ),

                        )


                      ],
                    ),


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
                            hintText: 'Reason for returning this order',
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

                    new Padding(padding: const EdgeInsets.only(top:25.0,left:15.0,right:15.0),child:


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
                            hintText: 'Bank Name',
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
                          controller: bankcontroller,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        )
                    ),

                    ),

                    new Padding(padding: const EdgeInsets.only(top:25.0,left:15.0,right:15.0),child:


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
                            hintText: 'Account Number',
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
                          controller: acnocontroller,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        )
                    ),

                    ),

                    new Padding(padding: const EdgeInsets.only(top:25.0,left:15.0,right:15.0),child:


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
                            hintText: 'IFSC',
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
                          controller: ifsccontroller,
                          keyboardType: TextInputType.text,
                          style: new TextStyle(
                            fontFamily: "Poppins",
                          ),
                        )
                    ),

                    ),




                    new Padding(padding: const EdgeInsets.only(top:40.0,left:15.0,right:15.0,bottom: 30.0),child:


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
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm'),
                                  content: Text("Are you sure?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('Yes'),
                                      onPressed: () async{
                                        Navigator.of(context).pop();
                                        validateForm();

                                      },
                                    ),
                                    FlatButton(
                                      child: Text('No'),
                                      onPressed: () async{
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );

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

          var returnreason = reasoncontroller.text;
          var returnbank = bankcontroller.text;
          var returnacno = acnocontroller.text;
          var returnifsc = ifsccontroller.text;

          if(picture1 == null){
            isempty =true;
            showdia("Please Upload photo");
          }else if(picture2 == null){
            isempty =true;
            showdia("Please Upload photo");
          }else if(picture3 == null){
            isempty =true;
            showdia("Please Upload photo");
          }else if(picture4 == null){
            isempty =true;
            showdia("Please Upload photo");
          }else if(returnreason.isEmpty){
            isempty =true;
            showdia("Reason can't be empty");
          }else if(returnbank.isEmpty){
            isempty =true;
            showdia("Bank name can't be empty");
          }else if(returnacno.isEmpty){
            isempty =true;
            showdia("Account Number can't be empty");
          }else if(returnifsc.isEmpty){
            isempty =true;
            showdia("IFSC can't be empty");
          }



          print(heaaders);

          if(isempty == false){

            dynamic mybody = {'orderid': '$orderid','returnifsc': '$returnifsc','returnacno': '$returnacno','returnbank': '$returnbank', 'returnreason': '$returnreason', 'index': '$index', '_csrf': '$csrf'};

            sharedPreferences = await SharedPreferences.getInstance();

            var stream1 = new http.ByteStream(DelegatingStream.typed(picture1.openRead()));
            var length1 = await picture1.length();
            int intex1 = picture1.path.lastIndexOf("/");
            String yourCuttedString1 = picture1.path.substring( intex1+1,picture1.path.length);
            print(yourCuttedString1);
            var multipartFile1 = new http.MultipartFile('returnphoto', stream1, length1,
                filename: yourCuttedString1,contentType: new MediaType('image', 'png'));

            var stream2 = new http.ByteStream(DelegatingStream.typed(picture2.openRead()));
            var length2 = await picture2.length();
            int intex2 = picture2.path.lastIndexOf("/");
            String yourCuttedString2 = picture2.path.substring( intex2+1,picture2.path.length);
            print(yourCuttedString2);
            var multipartFile2 = new http.MultipartFile('returnphoto', stream2, length2,
                filename: yourCuttedString2,contentType: new MediaType('image', 'png'));

            var stream3 = new http.ByteStream(DelegatingStream.typed(picture3.openRead()));
            var length3 = await picture3.length();
            int intex3 = picture3.path.lastIndexOf("/");
            String yourCuttedString3 = picture3.path.substring( intex3+1,picture3.path.length);
            print(yourCuttedString3);
            var multipartFile3 = new http.MultipartFile('returnphoto', stream3, length3,
                filename: yourCuttedString3,contentType: new MediaType('image', 'png'));

            var stream4 = new http.ByteStream(DelegatingStream.typed(picture4.openRead()));
            var length4 = await picture4.length();
            int intex4 = picture4.path.lastIndexOf("/");
            String yourCuttedString4 = picture4.path.substring( intex4+1,picture4.path.length);
            print(yourCuttedString4);
            var multipartFile4 = new http.MultipartFile('returnphoto', stream4, length4,
                filename: yourCuttedString4,contentType: new MediaType('image', 'png'));


            var url = Uri.parse("https://www.a2zonlineshoppy.com/api/returnorder");
            var request = new http.MultipartRequest("POST", url);
            print("path");
            request.files.add(multipartFile1);
            request.files.add(multipartFile2);
            request.files.add(multipartFile3);
            request.files.add(multipartFile4);
            request.headers.addAll(heaaders);
            request.fields.addAll(mybody);
            var respons = await request.send();



            print(respons.statusCode);
            respons.stream.transform(utf8.decoder).listen((value) {
              print("message was");
              print(value);
              bod = json.decode(value);
              String error = bod["error"];
              String message = bod["message"];

              if(message == "success"){
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Orders()) );

              }else{
                Navigator.of(context).pop();

                showdia("Try again");
              }
            });




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


  Future<void> _optionsDialogBox(num) {

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
                    onTap: (){
                      openCamera(num);
                    },
                  ),
                  GestureDetector(
                    child:Padding(
                      padding: EdgeInsets.all(15.0),
                      child: new Text('Select from gallery',textScaleFactor: 1.1),
                    ),

                    onTap:(){
                      openGallery(num);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }



  void openCamera(num) async{

    var  image = await ImagePicker.pickImage(
      source: ImageSource.
      camera,
    );
    Navigator.of(context).pop();


    switch(num){
      case 1 :{
        setState(() {

          picture1 = image;
        });
        break;
      }
      case 2 :{
        setState(() {

          picture2 = image;
        });
        break;
      }
      case 3 :{
        setState(() {

          picture3 = image;
        });
        break;
      }
      case 4 :{
        setState(() {

          picture4 = image;
        });
        break;
      }


    }

  }

  void openGallery(num) async{
    var  image = await ImagePicker.pickImage(
      source: ImageSource.
      gallery,
    );
    Navigator.of(context).pop();
    switch(num){
      case 1 :{
        setState(() {

          picture1 = image;
        });
        break;
      }
      case 2 :{
        setState(() {

          picture2 = image;
        });
        break;
      }
      case 3 :{
        setState(() {

          picture3 = image;
        });
        break;
      }
      case 4 :{
        setState(() {

          picture4 = image;
        });
        break;
      }


    }
  }


}


