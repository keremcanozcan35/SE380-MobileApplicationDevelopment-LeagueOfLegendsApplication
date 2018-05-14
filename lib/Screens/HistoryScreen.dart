import 'package:flutter/material.dart';

class SummaryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(

      ),
    );
  }
}

class HistoryScreen extends StatelessWidget{
  HistoryScreen({this.summonerName});
  final String summonerName;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Summarry',style: new TextStyle(fontSize: 25.0),),
      ),
      body: new SummaryScreen()  //TODO Need to implement two different containers for the valid and invalid id. (Erkin)
    );
  }
}