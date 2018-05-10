import 'package:flutter/material.dart';
import 'package:riot_application/Util/RiotApi.dart';
import 'dart:core';

class SummonerScreen extends StatelessWidget {
  SummonerScreen({this.summonerName});

  final String summonerName;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Summoner Screen',
            style: new TextStyle(fontSize: 25.0),
          ),
        ),
        body: new Summoner(
          summonerName: summonerName,
        ));
  }
}

class Summoner extends StatefulWidget {
  Summoner({this.summonerName});

  final String summonerName;

  @override
  SummonerState createState() {
    return new SummonerState(summonerName: summonerName);
  }
}

class SummonerState extends State<Summoner> {
  SummonerState({this.summonerName});

  RiotApi riotApi = new RiotApi();
  String summonerName;
  String imageUrl;
  String rankText;
  String divisionImageKey;
  String winNumberText;
  String loseNumberText;
  String leaguePoints;

  void initState() {
    super.initState();
    this.onLoad();
  }

  onLoad() async {
    await riotApi.setSummonerData(summonerName);
    await riotApi.getSummonerLeagueInfo();
    setState(() {
      imageUrl = riotApi.getSummonerIconLink();
      rankText = riotApi.summonerLeagueData[0]['tier'] +
          " " +
          riotApi.summonerLeagueData[0]['rank']; //TODO Need to find a way for the unranked people (ERKIN KEREM)
      divisionImageKey = riotApi.summonerLeagueData[0]['tier'].toLowerCase();
      winNumberText = riotApi.summonerLeagueData[0]['wins'].toString();
      loseNumberText = riotApi.summonerLeagueData[0]['losses'].toString();
      leaguePoints = riotApi.summonerLeagueData[0]['leaguePoints'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.blue[800],
      child: new Center(
          child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Image(
                    height: 120.0,
                    width: 120.0,
                    image: new NetworkImage(imageUrl)),
                new Text(
                  summonerName.toUpperCase(),
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
              ],
            ),
            new Column(
              children: <Widget>[
                new Image(
                  image: new AssetImage('Assets/$divisionImageKey.png'),
                  width: 120.0,
                  height: 120.0,
                ),
                new Text(
                  rankText,
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                new Text(
                  "League Points: $leaguePoints",
                    style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
                )
              ],
            ),
            new Column(
              children: <Widget>[
                new Text(
                    'Wins: $winNumberText',
                  style: new TextStyle(color: Colors.green[400], fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                new Text(
                  'Loose: $loseNumberText',
                  style: new TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
