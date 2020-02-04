import 'dart:io';

import 'package:flutter/material.dart';
import 'PreHome.dart';
import 'package:flutter/services.dart';

Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Visibility(child: new CircularProgressIndicator(),);
}

void main() async{

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.grey.shade50,// status bar color
  ));
  ErrorWidget.builder = (errorDetails) {
    return Container( child:
        Center(
          child: CircularProgressIndicator(),
        )
    );
  };
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) async{



    runApp(
        MaterialApp(
          title: "A2ZOnlineShoppy",

            theme: ThemeData(
                primaryColor: Colors.red,
                scaffoldBackgroundColor: Colors.grey.shade50,
            ),
            debugShowCheckedModeBanner: false,
            home:  PreHomePage()
        ));
  });

}
