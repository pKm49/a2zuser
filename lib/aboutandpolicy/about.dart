/// ListTile

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatefulWidget {
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  SharedPreferences sharedPreferences;
  String name;
  String mobile;

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
      mobile = sharedPreferences.getString('mobile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Version 6.0"),
      ),
      //Body
      body: new ListView(
        children: <Widget>[
          Visibility(
            visible: true,
            child: Container(
              height: MediaQuery.of(context).size.height * .90,
              padding: const EdgeInsets.all(2.0),
              color: Colors.grey.shade50,
              child: ListView(
                children: <Widget>[
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                    child: new Text(
                      "About Us ",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                    child: new Text(
                      "     A2Z Online Shoppy is an e-commerce company headquartered in Perinthalmanna, Kerala, India. Our parent company is A2Z@Home, a business promoting company headquartered at Palakkad, Kerala, India. ",
                      style: TextStyle(color: Colors.grey.shade800),
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                    child: new Text(
                      "About A2Z@Home ",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                    child: new Text(
                      "*A2z@home opens a door in the field of business activities to both the customers and sellers in a mutual way. \n * A2z@home is a business promoting company headquartered at palakkad, kerala, india. \n * The company issues privilege cards to its members, on production of which, the members can avail a discount of 1% to 30% on each purchase from the tie up shops or institutions. \n * A2z@home provides service aiming at maximization of sales for shop keepers & minimization of costs for the customers through the privilege card. \n * Continuously getting customers to the partner shops.",
                      style: TextStyle(color: Colors.grey.shade800),
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                    child: new Text(
                      "Our Speciality ",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                    child: new Text(
                      "* No additional bargains from the side of customers.  \n * Getting advertisement and promotions to the partner shops from the side of A2z@home \n * Getting advertisement space in our brochure & apps \n * Get a chance to promote business to the genuine customers through SMS and social media. \n * Partner shop can save money for further advertisements \n * Partner shops get a chance to participate in all events conducted by a2z@home.",
                      style: TextStyle(color: Colors.grey.shade800),
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                    child: new Text(
                      "Our Vision ",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                    child: new Text(
                      "    We mainly focus on 2025 our members are have strong in financially and develop our organization and also care about our members",
                      style: TextStyle(color: Colors.grey.shade800),
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                    child: new Text(
                      "Our Mission ",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                    child: new Text(
                      "    Our mission is to provide authentic and comprehensive business support hereby we will be creating a bridge between customer and shops, and in turn, providing ample business opportunities in todays comprehensive market.",
                      style: TextStyle(color: Colors.grey.shade800),
                      textAlign: TextAlign.justify,
                      textScaleFactor: 1.3,
                    ),
                  )),
                  ExpansionTile(
                    title: new Text(
                      "Bank Account Details",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                    ),
                    children: <Widget>[
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "Name : A2ZONLINESHOPPY",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "Bank : BANK OF BARODA",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "AC NO : 42350200000092",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "IFSC : BARB0PERINT",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                    ],
                  ),
                  ExpansionTile(
                    title: new Text(
                      "Contact Information",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                    ),
                    children: <Widget>[
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                        child: new Text(
                          "Office Address",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "N.S Tower, Kalmandapam Jn, Palakkad, Kerala, pin - 678001, India",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                        child: new Text(
                          "Mobile",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "+91 7594855000",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.left,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                        child: new Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "a2zshoppy.india@gmail.com",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.left,
                          textScaleFactor: 1.3,
                        ),
                      )),
                    ],
                  ),
                  ExpansionTile(
                    title: new Text(
                      "Terms and Conditions",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                    ),
                    children: <Widget>[
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "1.You may access and use the Website and the Services either as a registered user or as a guest user. However, not all sections of the Website and Services will be accessible to guest users. \n\n2.You can create Your Account on the Website through logging in by Your third party website user ID and password including that of www.facebook.com, websites owned by Yahoo Inc. or its subsidiaries, Google Inc. or its subsidiaries, twitter or any other social media website or any other Internet service as permitted on the Website. \n\n3.In the event You register as a User by creating an Account in order to avail of the Services provided by the Website, You will be responsible for maintaining the confidentiality and security of the Account Information, and are fully responsible for all activities that occur under Your Account. \n \tYou agree to \n\t(a) immediately notify A2Z online shoppy of any unauthorized use of Your Account Information or any other breach of security, and \n(b) ensure that You exit from Your Account at the end of each session. \n\nA2Z online shoppy cannot and will not be liable for any loss or damage arising from Your failure to comply with this section. You may be held liable for losses in curred by A2Z online shoppy or any other user of or visitor to the Website due to authorized or unauthorized use of Your Account as a result of Your failure in keeping Your Account Information secure and confidential. \n\n4.You shall ensure that the Account Information provided by You in the Website\'s registration form is complete, accurate and up-to-date. Use of another user\'s Account Information for availing the Services is expressly prohibited. \n\n5.If You provide any information that is untrue, inaccurate, not current or incomplete (or becomes untrue, inaccurate, not current or incomplete), or A2Zonline shoppy has reasonable grounds to suspect that such information is untrue, inaccurate, not current or incomplete, A2Zonline shoppy has the right to suspend or terminate Your Acco unt and refuse any and all current or future use of the Website / Services. \n\n6.Guest users: The Website also allows limited access to the Services for unregistered Users (also called as \'guest users\'). Such users will be able to browse the Website and use the S ervices for the purpose of purchasing goods, and placing orders. However, You will not be provided with access to certain benefits reserved only for the purpose of registered users. These benefits may change from time to time. \n\n7.Depending upon whether You are a seller or a buyer or another user who otherwise wish to use the Website, and the nature of Services You wish to avail from the Website, You may be required to provide certain personal information and a2z online shoppy may collect certain personal information. \n\n8.A2ZOnlineShoppy participates in Amazon Affiliate program.",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                    ],
                  ),
                  ExpansionTile(
                    title: new Text(
                      "Payment & Shipping Policies",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                    ),
                    children: <Widget>[
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                        child: new Text(
                          "Payment",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "    We take your security very seriously, therefore your details are safe with us You can use any of the payment options listed below to pay for your order:\n\n• Cash on Delivery  \n• Paytm  \n• Google pay  \n• PhonePe  \n• BHIM  \n• Debit Card  \n• Credit Card \n• NetBanking ",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
                        child: new Text(
                          "Shipping",
                          style: TextStyle(
                              color: Colors.grey.shade800,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.3,
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "  We deliver to all pin codes in India through reputed delivery partners. Most orders are delivered within 5- 7 working days from the time the order is placed. After placing your order, you will receive a link where you can track your order.",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                    ],
                  ),
                  ExpansionTile(
                    title: new Text(
                      "Return & Refund Policies",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                    ),
                    children: <Widget>[
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "We offer a no-questions-asked return/exchange policy. Customers can return/exchange products in most categories within 3 days from the date of delivery of your order. Please ensure that the product is in original condition and unused with all the tags intact to enable your request to be processed.\n\nCancellation by the Buyer: In case of requests for order cancellations, Seller reserves the right to accept or reject requests for order cancellations for any reason whatsoever. As part of usual business practice, if Seller receives a cancellation notice and the order has not been processed, Seller may cancel the order and refund the entire amount to Buyer within a reasonable period of time. Seller will not be able to cancel orders that have already been processed by the Seller. Buyer agrees not to dispute the decision made by Seller and accept Seller\'s decision regarding the cancellation.",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                    ],
                  ),
                  ExpansionTile(
                    title: new Text(
                      "Privacy Policies",
                      style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.3,
                    ),
                    children: <Widget>[
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25.0, left: 10.0, right: 10.0, bottom: 25.0),
                        child: new Text(
                          "By providing us your Information or by making use of the facilities provided by the Website, You hereby consent to the collection, storage, processing and transfer of any or all of Your Personal Information and Non - Personal Information by A2Z ONLINE SHOPPY as s pecified under this Privacy Policy. You further agree that such collection, use, storage and transfer of Your Information shall not cause any loss or wrongful gain to you or any other person. \n\nA2Z ONLINE SHOPPY has provided this Privacy Policy to familiarise You with \n\n1. The type of data or information that You share with or provided to and that A2Z ONLINE SHOPPY collects from You. \n\n2. The purpose for c ollection of such data or information from You; Information collected and storage of such Information: \n\n3. The \"Information\" (which shall also include data) provided by You to a2z online shoppy or collected from You by A2ZOnlineshoppy may consist of \"Personal Inform ation\" and \"Non - Personal Information\". \n\n4 Personal Information: Personal Information is Information collected that can be used to uniquely identify or contact You. \n\nPersonal Information for the purposes of this Privacy Policy shall include, but not be limited to: \n* Your username along with Your password, \n* Your name, \n* Your address, \n* Your telephone number, \n* Your e-mail address or other contact information, \n* Your date of birth, \n* Your gender, \n* Information regarding your transactions on the Website, (including sales or purch ase history), \n* Your financial information such as bank account information or credit card or debit card or other payment instrument details, \n* Internet Protocol address, \nThe security of your Personal Information is important to us. A2ZOnlineShoppy strives to ensure the security of Your Personal Information and to protect Your Personal Information against unauthorized access or unauthorized alteration, disclosure or destruction. F or this purpose, a2z online shoppy adopts internal reviews of the data collection, storage and processing practices and security measures, including appropriate encryption and physical security measures to guard against unauthorized access to systems wher e a2z online shoppy stores Your Personal Information. Each of the a2z online shoppy entity shall adopt reasonable security practices and procedures as mandated under applicable laws for the protection of Your Information. Provided that Your right to claim damages shall be limited to the right to claim only statutory damages under Information Technology Act, 2000 and You hereby waive and release all a2z online shoppy entities from any claim of damages under contract or under tort. ",
                          style: TextStyle(color: Colors.grey.shade800),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.3,
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var whatsappUrl = "whatsapp://send?phone=+917594855000";
          await canLaunch(whatsappUrl)
              ? launch(whatsappUrl)
              : print(
                  "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
        },
        child: Image.asset('images/whatsapp.png'),
      ),
    );
  }
}
