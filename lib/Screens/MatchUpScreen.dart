import 'package:flutter/material.dart';
import 'package:riot_application/Util/RiotApi.dart';
import 'dart:core';

class MatchUpScreen extends StatelessWidget {
  MatchUpScreen({this.summonerName, this.riotApi});

  final RiotApi riotApi;
  final String summonerName;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Match Up!',
            style: new TextStyle(fontSize: 25.0),
          ),
        ),
        body: new MatchUpContainer(
          summonerName: summonerName,
          riotApi: riotApi,
        ));
  }
}

class MatchUpContainer extends StatefulWidget {
  MatchUpContainer({this.summonerName, this.riotApi});

  final String summonerName;
  final RiotApi riotApi;

  @override
  MatchUpContainerState createState() {
    return new MatchUpContainerState(
        summonerName: summonerName, riotApi: riotApi);
  }
}

class MatchUpContainerState extends State<MatchUpContainer> {
  MatchUpContainerState({this.summonerName, this.riotApi});

  RiotApi riotApi;
  String summonerName;
  List matchUpData;

  onLoad() async {
    setState(() {
      matchUpData = riotApi.matchUpDataListForUi;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.onLoad();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.pink,
      child: new Center(
          child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new MatchUpBox(matchUpData: matchUpData[0]),
            new MatchUpBox(matchUpData: matchUpData[1]),
            new MatchUpBox(matchUpData: matchUpData[2])
          ],
        ),
      )),
    );
  }
}

class MatchUpBox extends StatelessWidget {
  MatchUpBox({this.matchUpData});
  final Map matchUpData;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Image(
                  width: 120.0,
                  height: 120.0,
                  image: new NetworkImage(
                      "https://ddragon.leagueoflegends.com/cdn/8.11.1/img/champion/" + matchUpData["firstChampName"] +".png")), //TODO Implement backend for the champ name
              new Container(
                child: new Column(
                  children: <Widget>[
                    new Text(
                      "Highest Possible",
                      style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      "Champion Match",
                      style: new TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              new Image(
                  width: 120.0,
                  height: 120.0,
                  image: new NetworkImage(
                      "https://ddragon.leagueoflegends.com/cdn/8.11.1/img/champion/" + matchUpData["secondChampName"] +".png")), //TODO Implement backend for the champ name
            ],
          ),
          new Text(
            "This matchup analyzed by 1000 games!!!",
            style: new TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
