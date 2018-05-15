import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riot_application/Util/RiotApi.dart';

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
  List urlList;

  onLoad() async {
//    await riotApi.getStaticChampionData();
//    await riotApi.setSummonerData(summonerName);
//    await riotApi.getMatchListByAccountId();

    setState(() {
      urlList = riotApi.getTheImageUrlFromLastMatches();
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
        imageUrlList: urlList,
      ),
    );
  }
}

class Match extends StatelessWidget {
  Match({this.championName, this.gameResult, this.imageUrl});

  final String imageUrl;
  final String championName;
  final bool gameResult;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Image(
              width: 120.0,
              height: 120.0,
              image: new NetworkImage(imageUrl)),
          new Container(
            color: Colors.black,
            padding: new EdgeInsets.only(right: 25.0),
            child: new Row(
              //TODO Find a way to add space between these two containers. Because the ancestor Container doesn't fill the rest it doesn't do spaceBetween. (Erkin)
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  padding: new EdgeInsets.all(10.0),
                  color: Colors.yellow,
                  child: new Text(
                    championName,
                    style: new TextStyle(
                        color: Colors.black,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                new Container(
                  decoration: new BoxDecoration(
                      color: Colors.lightBlueAccent[700],
                      border:
                          new Border.all(color: Colors.lime[900], width: 1.0)),
                  child: new Text(
                    gameResult ? "VICTORY" : "DEFEAT",
                    style: new TextStyle(color: Colors.white, fontSize: 40.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


//List for the last match.
class MatchList extends StatelessWidget {
  MatchList({this.imageUrlList});

  final List imageUrlList;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return new Card(
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(color: Colors.black, width: 5.0)),
              //padding: new EdgeInsets.all(60.0),
              child: new Column(
                children: <Widget>[
                  new Match(
                    championName: "Ashe",
                    gameResult: true,
                    imageUrl: imageUrlList[index],
                  ),
                ],
              ),
            ),
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
