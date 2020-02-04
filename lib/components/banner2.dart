import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Banner2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget banner2 =  new Container(
        decoration: new BoxDecoration(

          color: Colors.grey.shade50,        ),
        child: CarouselSlider(
          viewportFraction: 1.0,
          height:MediaQuery.of(context).size.height *.22,
          autoPlay: true,
          items: <Widget>[
            new CachedNetworkImage(
                imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner2image1.jpg",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
             new CachedNetworkImage(
                imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner2image2.jpg",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              ),

            new CachedNetworkImage(
              imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner2image3.jpg",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),

            new CachedNetworkImage(
              imageUrl: "https://a2zonlineshoppy.com/public2/banners/banner2image4.jpg",
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            )
          ],
        )
    );
    return banner2;
  }
}
