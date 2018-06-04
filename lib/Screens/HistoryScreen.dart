import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riot_application/Util/RiotApi.dart';
import 'package:decimal/decimal.dart';

class SummaryScreen extends StatefulWidget {
  SummaryScreen({this.summonerName, this.riotApi});

  final RiotApi riotApi;
  final String summonerName;

  @override
  SummaryScreenState createState() {
    return new SummaryScreenState(summonerName: summonerName, riotApi: riotApi);
  }
}

class SummaryScreenState extends State<SummaryScreen> {
  SummaryScreenState({this.summonerName, this.riotApi});

  String summonerName;
  RiotApi riotApi;
  List testMatchData;

  onLoad() async {
    setState(() {
      testMatchData = riotApi.matchDataListForUi;
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
      //TODO IF I WANT TO WRAP THE MATCHLIST IT GIVES AN ERROR.
      child: new MatchList(
        testMatchData: testMatchData,
      ),
    );
  }
}

class Match extends StatelessWidget {
  Match({this.matchData});

  final Map matchData;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(20.0),
      child: new Container(
        color: Colors.white,
        child: new Center(
          child: new Row(
            children: <Widget>[
              new Image(
                  width: 120.0,
                  height: 120.0,
                  image: new NetworkImage(
                      "https://ddragon.leagueoflegends.com/cdn/8.11.1/img/champion/"+matchData["championName"]+".png")),
              new Container(
                  child: new Center(
                      child: new Column(
                children: <Widget>[
                  new Text(
                    matchData["championName"],
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    matchData["gameResult"]? "Win" : "Lose",
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    matchData["kills"] + "/" + matchData["deaths"] + "/" + matchData["assists"],
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  new Text(
                    "KDA : " + matchData["kda"],
                    style: new TextStyle(fontSize: 20.0),
                  )
                ],
              )))
            ],
          ),
        ),
      ),
    );
  }
}

//List for the last match.
class MatchList extends StatelessWidget {
  MatchList({ this.testMatchData});


  final List testMatchData;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: 10,
        itemBuilder: (context, int index) {
          return new Match(
            matchData:  testMatchData[index],
          );
        });
  }
}

class HistoryScreen extends StatelessWidget {
  HistoryScreen({this.summonerName, this.riotApi});

  final String summonerName;
  final RiotApi riotApi;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            'Summary',
            style: new TextStyle(fontSize: 25.0),
          ),
        ),
        body: new SummaryScreen(
          summonerName: this.summonerName,
          riotApi: riotApi,
        ) //TODO Need to implement two different containers for the valid and invalid id. (Erkin)
        );
  }
}
