import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/.env.dart';

const baseurl = "http://api.weatherapi.com/v1";
const apiKey = APIKEY;

class WeatherService {
  static getRawCurrentWeather(
      {required double lat, required double log}) async {
    try {
      const currentweather = "/current.json?key=$apiKey&q=48.8567,2.350";
      const finalUrl = baseurl + currentweather;
      final response = await http.get(Uri.parse(finalUrl));
      print("DATA$lat");
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        // return WeatherResultModel.fromJson(jsonData);
        return jsonData;
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
