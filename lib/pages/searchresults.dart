/// ListTile

import 'package:flutter/material.dart';
import 'package:a2zonlinshoppy/pages/cart.dart';
import 'package:a2zonlinshoppy/components/drawer.dart';
import 'package:a2zonlinshoppy/components/productsearchresults.dart';
import 'package:a2zonlinshoppy/components/productsearchresultsltoh.dart';
import 'package:a2zonlinshoppy/components/productsearchresultshtol.dart';
import  'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SearchResults extends StatefulWidget {


  @override
  SearchResultsState createState() => SearchResultsState();
}

class SearchResultsState extends State<SearchResults> {
  bool prodres=true, prodresltoh = false, prodreshtol=false;

  SharedPreferences sharedPreferences;
  Icon _searchIcon = new Icon(Icons.search,color: Colors.white);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: Colors.red,
        iconTheme: IconThemeData(color: Colors.white),        title: Text("Results"),
        actions: <Widget>[
          new IconButton(icon:_searchIcon, onPressed: (){
            showSearch(context: context, delegate: DataSearch());

          }),
          new IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white), onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart()) );

          })
        ],
      ),
      //Body

      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child:
                ButtonTheme(
                  minWidth: 200.0,
                  height: MediaQuery.of(context).size.height * .08,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: (){
                      setState(() {
                        prodres = false;
                        prodreshtol = false;
                        prodresltoh=true;
                      });
                    },
                    child: new Text("Price:Low to High"),
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: 200.0,
                  height: MediaQuery.of(context).size.height * .08,
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: (){
                      setState(() {
                        prodres = false;
                        prodresltoh = false;
                        prodreshtol=true;
                      });
                    },
                    child: new Text("Price:High to Low"),
                  ),
                ),
              )
            ],
          ),
          Visibility(
            visible: prodres==true?true:false,
              child:ProductSearchResults()
          ),
          Visibility(
              visible: prodresltoh==true?true:false,
              child:ProductSearchResultsLtoH()
          ),
          Visibility(
              visible: prodreshtol==true?true:false,
              child:ProductSearchResultsHtoL()
          )
        ],
      ),


    );
  }
}



/*
Row(
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 50.0,
                    child: RaisedButton(
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: (){},
                      child: new Text("Load More"),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 100.0,
                    height: 50.0,
                    child: RaisedButton(
                      textColor: Colors.black,
                      color: Colors.white,
                      onPressed: (){},
                      child: new Text("Load More"),
                    ),
                  ),
                ],
              ),
 */




class DataSearch extends SearchDelegate<String>{



  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.close), onPressed: (){
      query = "";
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
        icon: AnimatedIcon(
            icon:AnimatedIcons.menu_arrow,
            progress: transitionAnimation),
        onPressed: (){
          close(context, null);
        });  }

  @override
  Widget buildResults(BuildContext context) {
    searchresults (query,context);
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty){
      return FutureBuilder(
        future: getrecentitems(),
        builder: (context,snapshot){

          print("data is ");
          print(snapshot.data);
          return  ListView.builder(
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                onTap: (){
                  showResults(context);
                },
                leading: Icon(Icons.bubble_chart),
                title: snapshot.data[index],
              );
            },
            itemCount: snapshot.data == null?0:snapshot.data.length,
          );
        },
      );
    }else{
      return FutureBuilder(
        future: getsuggestions(query),
        builder: (context,snapshot){
          print("daaata is ");
          print(snapshot.data);
          List recent = [];
          List finallist = [];
          print("recent queriesfsdf");
          print(snapshot.data);
          if(snapshot.data == null){
            recent =[];
          }else{
            recent = json.decode(snapshot.data);

            finallist = recent.where((p)=> p.startsWith(query.toLowerCase())).toList();

          }
          return  ListView.builder(
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                onTap: (){
                  query = finallist[index];
                  showResults(context);
                },
                leading: Icon(Icons.bubble_chart),
                title: Text(finallist[index]),
              );
            },
            itemCount: snapshot.data == null?0:finallist.length,
          );
        },
      );
    }
  }



  Future<List> getrecentitems() async{
    List recent =[];
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String recentqueries = sharedPreferences.getString('recentqueries');
    if(recentqueries == null){
      recent =[];
    }else{
      recent = json.decode(recentqueries);
    }
    return recent;
  }

  Future<String> getsuggestions(qry)async{
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();
    String recentqueries = sharedPreferences.getString('searchtags');


    return sharedPreferences.getString('searchtags');
  }

  void searchresults(String key,context) async {
    SharedPreferences sharedPreferences;
    sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString('searchkey',key);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SearchResults()) );

  }


}

