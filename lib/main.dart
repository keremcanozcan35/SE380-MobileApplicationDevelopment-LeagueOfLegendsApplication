import 'package:flutter/material.dart';
import 'Screens/MainScreen.dart';


void main() => runApp(new MyApp());



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Leauge Of Legends',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.pink,
            title: new Text("League of Legends", style: new TextStyle(fontSize: 25.0,color: Colors.white), ),
            actions: <Widget>[
              //TODO Implement an PopupMenuButton... (Erkin)
            ],
          ),
          body: new MainScreen()
      ),
    );
  }
}
