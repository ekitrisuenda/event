import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '7 Macam Event Seru',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            '7 Macam Event Seru',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: _PageList(),
      ),
    );
  }
}

class _PageList extends StatefulWidget {
  @override
  _PageListState createState() => _PageListState();
}

class _PageListState extends State<_PageList> {

  List languages = [
    "Pameran seni",
    "Bazar pernak-pernik kamera analog",
    "Festival Kuliner",
    "Pasar local brand",
    "Pameran otomotif",
    "Pertunjukan musik",
    "Pameran otomotif",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (BuildContext context, int index) {
          final number = index+1;
          final language = languages[index].toString();
          return Card(
            child: ListTile(
              leading: Text(number.toString()),
              title: Text(language),
              trailing: Icon(Icons.check),
            ),
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  ListItem({this.nama, this.npm});

  final String nama;
  final String npm;

  @override
  Widget build(BuildContext context){
    return new Container(
      padding: new EdgeInsets.all(16.0),
      child: new Center(
        child: new Row(
          children: <Widget>[
            new Icon(Icons.person, size: 50,),
            new Container(
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              child: new Center(
                child: new Column(
                  children: <Widget>[
                    Text(nama, style: new TextStyle(fontSize: 18.0)),
                    Text(npm, style: new TextStyle(fontSize: 12.0)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

    );
  }
}



