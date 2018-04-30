import 'package:flutter/material.dart';
import 'package:riot_application/Screens/HistoryScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  double width, height;
  String _summonerName;

   onTextInputChanged(String value){
    setState((){
      _summonerName = value;
      print(_summonerName);
    });
  }

  onPressed(){
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new HistoryScreen(summonerName: _summonerName,)));
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return new Container(
      //color: Colors.blue[900],
      decoration: new BoxDecoration(color: Colors.blue[900],border: new Border.all(color: Colors.green, width: 10.0)),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new SummonerInput(
            onChanged: this.onTextInputChanged,
            width: this.width,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Buttons(
                onPressed: this.onPressed,
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
  Buttons({this.width, this.height, this.text, this.summonerName, this.onPressed});

  final double width;
  final double height;
  final String text;
  final String summonerName;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return new RawMaterialButton(
      onPressed: onPressed,
      padding: new EdgeInsets.all(5.0),
      fillColor: Colors.pink,
      shape: new CircleBorder(
          side: new BorderSide(color: Colors.green, width: 5.0)),
      constraints: new BoxConstraints(
          minWidth: this.width * 0.31, minHeight: this.height * 0.20),
      child: new Text(
        text,
        style: new TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold , fontStyle: FontStyle.italic, letterSpacing: 2.0 ),
      ),
    );
  }
}

class SummonerInput extends StatelessWidget {
  SummonerInput({this.width, this.onChanged});

  final double width;
  final onChanged;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          border: new Border.all(color: Colors.green, width: 5.0)),
      width: this.width * 0.75,
      padding: new EdgeInsets.all(3.0),
      child: new TextField(
        onChanged: onChanged,
        decoration: new InputDecoration(contentPadding: new EdgeInsets.all(5.0),hintText: "Enter your Summoner Name..."),
        style: new TextStyle(fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
