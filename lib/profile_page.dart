import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        backgroundColor: Color.fromRGBO(41, 203, 236, 1),
      ),
      body: new Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            new Container(
              margin: EdgeInsets.only(bottom: 8.0),
            ),
            Image.asset(
              "assets/images/eki.jpeg",
              width: 300.0,
              height: 500.0,
              fit: BoxFit.cover,
            ),
            Text("Eki Tri Suenda",
              style: new TextStyle(fontSize: 20.0)),
            Text("1757051003",
              style: new TextStyle(fontSize: 16.0)),
          ],
        ),
      )
    );
  }
}

