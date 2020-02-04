import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Banner1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget banner1 = new Container(
        decoration: new BoxDecoration(

          color: Colors.grey.shade50,
        ),
      child: CarouselSlider(
        viewportFraction: 1.0,
        height:MediaQuery.of(context).size.height *.21,
        autoPlay: true,
        items: <Widget>[
          CachedNetworkImage(
            imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner1image1.jpg",
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          new CachedNetworkImage(
            imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner1image2.jpg",
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          CachedNetworkImage(
            imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner1image3.jpg",
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          ),
          CachedNetworkImage(
            imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner1image4.jpg",
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(Icons.error),
          )
        ],
      )
    );
    return banner1;
  }
}
