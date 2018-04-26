import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.blue,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new SummonerInput(),
         /* new Image(
              image: new NetworkImage("https://vignette.wikia.nocookie.net/leagueoflegends/images/1/12/League_of_Legends_Icon.png/revision/latest?cb=20150402234343"),
          ),
         */ new LiveGameButton(),
        ],
      ),
    );
  }
}

class SummonerInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      width: 300.0,
      padding: new EdgeInsets.all(3.0),
      child: new TextField(
        style: new TextStyle(fontSize: 20.0, color: Colors.black),
      ),
    );
  }
}

class LiveGameButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(5.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new RawMaterialButton(
            onPressed: null,
            padding: new EdgeInsets.all(5.0),
            fillColor: Colors.white,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.all(new Radius.circular(15.0))),
            child: new Text(
              'LIVE GAME!!!',
              style: new TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          new RawMaterialButton(
              onPressed: null,
              fillColor: Colors.white,
              padding: new EdgeInsets.all(5.0),
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.all(new Radius.circular(15.0))),
              child: new Text(
                'HISTORY',
                style: new TextStyle(color: Colors.black, fontSize: 20.0),
              ))
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Leauge Of Legends',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainScreen(),
    );
  }
}
