import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/pages/searchresults.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageView extends StatefulWidget {
  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  Icon _searchIcon = new Icon(Icons.search, color: Colors.white);
  Widget _appBarTitle = new Text('A2ZOnlineShoppy');
  final TextEditingController _filter = new TextEditingController();

  SharedPreferences sharedPreferences;
  String imageone;
  String imagetwo;
  String imagethree;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIN();
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          onSubmitted: searchresults,
          style: new TextStyle(color: Colors.white),
          controller: _filter,
          decoration: new InputDecoration(
              hintStyle: TextStyle(color: Colors.grey.shade50),
              prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search, color: Colors.white);
        this._appBarTitle = new Text('A2ZOnlineShoppy');
      }
    });
  }

  void searchresults(String key) async {
    sharedPreferences.setString('searchkey', key);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchResults()));
  }

  void isSignedIN() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      imageone = sharedPreferences.getString('imageone');
      imagetwo = sharedPreferences.getString('imagetwo');
      imagethree = sharedPreferences.getString('imagethree');
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
        title: Text("Images"),
        actions: <Widget>[
          new IconButton(icon: _searchIcon, onPressed: () {}),
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.black),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              })
        ],
      ),
      //Body
      body: new Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 1.0,
            child: Scrollbar(
              child: ListView(
                physics: PageScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Visibility(
                    visible: imageone == null ? false : true,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Image.network(imageone == null
                            ? 'https://a2zonlineshoppy.com/images/product.png'
                            : imageone)),
                  ),
                  Visibility(
                      visible: imagetwo == null ? false : true,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Image.network(imagetwo == null
                              ? 'https://a2zonlineshoppy.com/images/product.png'
                              : imagetwo))),
                  Visibility(
                      visible: imagethree == null ? false : true,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Image.network(imagethree == null
                              ? 'https://a2zonlineshoppy.com/images/product.png'
                              : imagethree)))
                ],
              ),
            ),
          )),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
