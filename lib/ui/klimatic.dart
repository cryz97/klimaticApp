import 'package:flutter/material.dart';
import 'dart:async';
import 'package:klimatic_app/util/utils.dart' as util;
import 'package:http/http.dart' as http;
import 'dart:convert';


class Klimatic extends StatefulWidget {
  @override
  _KlimaticState createState() => _KlimaticState();
}

class _KlimaticState extends State<Klimatic> {

  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context).push(
      new MaterialPageRoute<Map>(builder: (BuildContext context) {
           return ChangeCity();
      })
    );
  }


  void showStuff() async {
    Map data = await getWeather(util.appId, util.defaultCity);
  }


    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Klimatic", textAlign: TextAlign.center,),
          backgroundColor: Colors.deepPurple,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.menu),
                onPressed: () {_goToNextScreen(context);})

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
              child: new Text('Aguascalientes',
                style: cityStyle(),),
            ),

            new Container(
              alignment: Alignment.center,
              child: new Image.asset("images/light_rain.png"),
            ),

            new Container(
              margin: const EdgeInsets.fromLTRB(30, 290, 0, 0),
              alignment: Alignment.center,
              child: updateTempWidget('Aguascalientes'),
            )
          ],
        ),
      );
    }

    Future<Map> getWeather(String appId, String city) async {
      String apiURL = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.appId}&units=metric';

      http.Response response = await http.get(apiURL);

      return json.decode(response.body);

    }


    Widget updateTempWidget(String city) {
        return new FutureBuilder(
            future: getWeather(util.appId, city),
            builder: (BuildContext context, AsyncSnapshot<Map> snapshot){

              if(snapshot.hasData){
                Map content = snapshot.data;
                  return new Container(
                    child: new Column(
                      children: <Widget>[
                        new ListTile(
                          title: new Text(content['main']['temp'].toString(),
                          style: tempStyle(),),
                        )
                      ],
                    )
                  );
              }else{
                return new Container();
              }

        });
    }

  }


  class ChangeCity extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.redAccent,
          title: new Text("Change City"),
          centerTitle: true,
        ),
        body: new Stack(
          children: <Widget>[

            new Center(
              child:
                new Image.asset("images/white_snow.png",
                width: 500,
                height: 1200,
                fit: BoxFit.fill ,),
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

TextStyle tempStyle(){
  return new TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 50
  );
}