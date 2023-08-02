import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon.model.dart';
import 'package:toonflix/models/webtoon_detail_model.dart';

import '../../models/webtoon_episode_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    final uri = Uri.parse('$baseUrl/today');
    var response =
        await http.get(uri, headers: {'Authorization': 'awerawfawfwaefwefwaf'});
    List<WebtoonModel> webtoons = [];

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);

      webtoons = json.map((data) => WebtoonModel.fromJson(data)).toList();
    }

    return webtoons;
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final uri = Uri.parse('$baseUrl/$id');
    var response =
        await http.get(uri, headers: {'Authorization': 'awerawfawfwaefwefwaf'});

    if (response.statusCode == 200) {
      final dynamic json = jsonDecode(response.body);

      final webtoons = WebtoonDetailModel.fromJson(json);
      return webtoons;
    }

    throw Exception('api error');
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodeById(
      String id) async {
    final uri = Uri.parse('$baseUrl/$id/episodes');
    var response =
        await http.get(uri, headers: {'Authorization': 'awerawfawfwaefwefwaf'});

    if (response.statusCode == 200) {
      final List<dynamic> json =
          jsonDecode(response.body); //final만 설정하면 map toList 사용못함

      List<WebtoonEpisodeModel> episodes =
          json.map((e) => WebtoonEpisodeModel.fromMap(e)).toList();

      return episodes;
    }

    throw Exception('api error');
  }
}
