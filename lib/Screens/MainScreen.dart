import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  double width, height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return new Container(
      color: Colors.pink[900],
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new SummonerInput(
            width: this.width,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Buttons(
                width: this.width,
                height: this.height,
                text: "SUMMARY",
              ),
              new Buttons(
                width: this.width,
                height: this.height,
                text: 'LIVE!',
              )
            ],
          )
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  Buttons({this.width, this.height, this.text});

  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return new RawMaterialButton(
      onPressed: null,
      padding: new EdgeInsets.all(5.0),
      fillColor: Colors.blueGrey[100],
      shape: new CircleBorder(
          side: new BorderSide(color: Colors.black, width: 2.0)),
      constraints: new BoxConstraints(
          minWidth: this.width * 0.30, minHeight: this.height * 0.20),
      child: new Text(
        text,
        style: new TextStyle(
            color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold , fontStyle: FontStyle.normal, letterSpacing: 2.0 ),
      ),
    );
  }
}

class SummonerInput extends StatelessWidget {
  SummonerInput({this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          border: new Border.all(color: Colors.black, width: 0.90)),
      width: this.width * 0.75,
      padding: new EdgeInsets.all(3.0),
      child: new TextField(
        style: new TextStyle(fontSize: 20.0, color: Colors.black),
      ),
    );
  }
}
