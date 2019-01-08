import 'package:flutter/material.dart';


class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Klimatic"),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: null)

        ],
      ),

      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset("images/umbrella.png",
            width: 500,
             height: 1200,
             fit: BoxFit.fill,
             ),
            ),

          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0, 11, 21, 0),
            child: new Text('Spokane',
              style: cityStyle(),),
          )
        ],
      ),
    );
  }
}

TextStyle cityStyle(){
  return new TextStyle(
    color: Colors.white,
    fontSize: 23,
    fontStyle: FontStyle.italic
  );
}