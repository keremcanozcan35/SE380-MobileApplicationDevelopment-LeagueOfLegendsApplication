import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RiotApi {
  Map data;
  Map matchData;
  Map championMap;
  String accountID;

//Stores id of the champions from matches.
  List championIDList;
  List urlList;
  Map championInformation;

  String inputName = "Satanachia";
  String apiKey = "RGAPI-58696793-0fc1-4704-b5d2-d878046136f9";

  //Constructor (Template)
  RiotApi() {}

  //List data;
//todo image caching
  Future<String> getAccountBySummonerName(String input) async {
    var response = await http.get(
        Uri.encodeFull(
            "https://tr1.api.riotgames.com/lol/summoner/v3/summoners/by-name/$input?api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    data = JSON.decode(response.body);
    var data2 = data['accountId'];
    print(data2);
    accountID = "$data2";

    return "Success!";
  }

  Future<void> getMatchListByAccountId() async {
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
            "https://tr1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&dataById=true&api_key=$apiKey"),
        headers: {"Accept": "application/json"});
    Map temp = JSON.decode(response.body);
    //To set the champion informations.
    championInformation = temp["data"];
    int i = 1;
    print(championInformation["$i"]["name"]);
  }

  void getTheImageUrlFromLastMatches() {
    urlList = new List();
    championInformation.forEach((k, v) {
      for (int i = 0; i < 5; i++) {
        if (championInformation[k]["id"] == championIDList[i]) {
          String champName = championInformation[k]["name"];
          urlList.add(
              "https://ddragon.leagueoflegends.com/cdn/8.9.1/img/champion/$champName.png");
        }
      }
    });

        return;
    }
}

//TODO I could figure out with await and async however i couldn't impalement future api. .then() ?? (Erkin KURT)

//void main() {
//  championInformationList = new List();
//  getAccountBySummonerName(inputName).then((s) {
//    getMatchListByAccountId(accountID);
//  });
//}

void main() async {
  RiotApi r = new RiotApi();
  await r.getAccountBySummonerName(r.inputName);
  await r.getMatchListByAccountId();
  await r.getStaticChampionData();
  r.getTheImageUrlFromLastMatches();
  for (int i = 0; i < r.urlList.length; i++) {
    print(r.urlList[i]);
  }
}
