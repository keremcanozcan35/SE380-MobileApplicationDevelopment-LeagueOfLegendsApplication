import 'package:flutter/material.dart';
import 'package:riot_application/Screens/HistoryScreen.dart';
import 'package:riot_application/Screens/SummonerScreen.dart';
import 'package:riot_application/Util/RiotApi.dart';
import 'package:riot_application/Screens/MatchUpScreen.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  double width, height;
  String _summonerName;
  RiotApi riotApi = new RiotApi();

  onTextInputChanged(String value) {
    setState(() {
      _summonerName = value;
      print(_summonerName);
    });
  }

  onPressed() async {
    await riotApi.setSummonerData(_summonerName);
    await riotApi.getMatchListByAccountId();
    await riotApi.getDetailedMatchData();
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      ),
    );
    new Future.delayed(new Duration(seconds: 1), () {
      Navigator.pop(context); //pop dialog
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new HistoryScreen(
                  summonerName: _summonerName, riotApi: riotApi)));
    });
  }

  onPressedSummoner() async {
    await riotApi.setSummonerData(_summonerName);
    await riotApi.getSummonerLeagueInfo();
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      ),
    );
    new Future.delayed(new Duration(seconds: 1), () {
      Navigator.pop(context); //pop dialog
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new SummonerScreen(
                  summonerName: _summonerName, riotApi: riotApi)));
    });
  }

  onPressedMatchUp() async{
    await riotApi.setSummonerData(_summonerName);
    await riotApi.getMatchListByAccountId();
    await riotApi.getDetailedMatchData();
    await riotApi.getDataFromGG();
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading"),
          ],
        ),
      ),
    );
    new Future.delayed(new Duration(seconds: 1), () {
      Navigator.pop(context); //pop dialog
      Navigator.push(
          context,
          new MaterialPageRoute(
              builder: (context) => new MatchUpScreen(
                  summonerName: _summonerName, riotApi: riotApi)));
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return new Container(
      //color: Colors.blue[900],
      decoration: new BoxDecoration(
          color: Colors.blue[900],
          border: new Border.all(color: Colors.green, width: 10.0)),
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
                text: 'SUMMONER',
                onPressed: this.onPressedSummoner,
              ),
              new Buttons(
                width: this.width,
                height: this.height,
                text: 'MATCH UP',
                onPressed: this.onPressedMatchUp,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  Buttons(
      {this.width, this.height, this.text, this.summonerName, this.onPressed});

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
          minWidth: this.width * 0.31, minHeight: this.height * 0.23),
      child: new Text(
        text,
        style: new TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            letterSpacing: 2.0),
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
        decoration: new InputDecoration(
            contentPadding: new EdgeInsets.all(5.0),
            hintText: "Enter your Summoner Name..."),
        style: new TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
