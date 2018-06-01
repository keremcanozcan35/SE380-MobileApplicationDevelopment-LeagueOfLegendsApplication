import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RiotApi {
  Map summonerData;
  Map matchData;
  List summonerLeagueData;


//Stores id of the champions from matches.
  List championIDList;
  List urlList;
  Map championInformation;

  String apiKey = "RGAPI-9abd9724-0444-4ece-aaba-ea35e4e8855f";

  //Constructor (Template)
  RiotApi() {
    print("RiotAPI object is instantiating...");
    getStaticChampionData();
  }

  //List data;
//todo image caching

  Future<void> setSummonerData(String summonerName)async{
    print("Summoner nammmeee " + summonerName);
    var response = await http.get(
        Uri.encodeFull(
            "https://tr1.api.riotgames.com/lol/summoner/v3/summoners/by-name/$summonerName?api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    summonerData = JSON.decode(response.body);
    print("Summoner datatata " + summonerData["profileIconId"].toString());
  }

  String getSummonerIconLink(){
    int profileIconId = summonerData["profileIconId"];
    print(profileIconId);
    String newUrl = "http://ddragon.leagueoflegends.com/cdn/8.9.1/img/profileicon/$profileIconId.png";
    return newUrl;
  }

  Future<void> getSummonerLeagueInfo() async {
    var summonerID = summonerData['id'];
    var response = await http.get(
        Uri.encodeFull(
            "https://tr1.api.riotgames.com/lol/league/v3/positions/by-summoner/$summonerID?api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    summonerLeagueData = JSON.decode(response.body);
  }


  Future<void> getMatchListByAccountId() async {
    int accountID = summonerData["accountId"];
    var response = await http.get(
        Uri.encodeFull(
            'https://tr1.api.riotgames.com/lol/match/v3/matchlists/by-account/$accountID?endIndex=5&api_key=$apiKey'),
        headers: {"Accept": "application/json"});
    matchData = JSON.decode(response.body);
    var matches = matchData['matches'];
    championIDList = new List();

    for (int i = 0; i < 5; i++) {
      print(matches[i]["champion"]);
      championIDList.add(matches[i]["champion"]);
    }
  }

  Future<void> getStaticChampionData() async {
    var response = await http.get(
        Uri.encodeFull(
            "https://tr1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&champListData=image&dataById=true&api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    Map temp = JSON.decode(response.body);
    //To set the champion informations.
    championInformation = temp["data"];
    int i = 1;
    print(championInformation["$i"]["name"]);
  }

  List getTheImageUrlFromLastMatches() {
    urlList = new List();
    print(championInformation["1"]["name"]);
    championInformation.forEach((k, v) {
      for (int i = 0; i < 5; i++) {
        if (championInformation[k]["id"] == championIDList[i]) {
          Map temp = championInformation[k]["image"];
          String champImage = temp["full"];
              "https://ddragon.leagueoflegends.com/cdn/8.9.1/img/champion/$champImage");
          champImage = champImage.substring(0,champImage.length - 4);
//          urlList.add(
//              "https://ddragon.leagueoflegends.com/cdn/8.9.1/img/champion/$champImage");
        urlList.add(champImage);
        }
      }
    });
    return urlList;
  }

}
