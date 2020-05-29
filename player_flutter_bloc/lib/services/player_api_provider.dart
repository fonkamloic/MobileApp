import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:player_flutter_bloc/models/api_models.dart';

class PlayerApiProvider {
  final String baseUrl =
      "https://www.easports.com/fifa/ultimate-team/api/fut/item?";
  final int successCode = 200;

  Future<List<Player>> fetchPlayersByCountry(String countryId) async {
    final response = await http.get("$baseUrl+countryId=$countryId");

    final responseString = json.decode(response.body);
    // print(responseString['items']);
    if (response.statusCode == successCode) {
      List<Player> players = ApiResult.fromJson(responseString).players;
      print("Players are :${players??'No player'}");
      return players;
    } else {
      print(false);
      throw Exception('failde to load players');
    }
  }
}
