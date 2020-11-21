import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
void main()
{
  runApp(new MaterialApp(
    home: new homepage(),
  ));
}
class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final String url ="https://swapi.dev/api/people";
  List data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getjasondata();
  }
  Future<String> getjasondata() async
  {
    var response = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept":"application/json"}
    );
    print(response.body);
    setState(() {
      var covertdatatojason = jsonDecode(response.body);
      data=covertdatatojason["results"];
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("jason data"),
        centerTitle: true,
      ),
      body: new ListView.builder(
        itemCount: data==null ? 0 :data.length,
        itemBuilder: (BuildContext context,int index){
        return  new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['name']),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  )
                ],
              ),

            ),
          );
        },
      ),
    );
  }
}
