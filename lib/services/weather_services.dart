import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/.env.dart';

const baseurl = "http://api.weatherapi.com/v1";
const apiKey = APIKEY;

class WeatherService {
  static getRawCurrentWeather(
      {required double lat, required double log}) async {
    try {
      String currentweather = "/current.json?key=$apiKey&q=$lat,$log";
      String finalUrl = baseurl + currentweather;
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        return jsonData;
      }
    } catch (e) {
      rethrow;
    }
  }
}
