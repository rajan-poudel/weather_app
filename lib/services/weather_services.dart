import 'package:http/http.dart' as http;

import '../config/.env.dart';

const baseurl = "http://api.weatherapi.com/v1";
const apiKey = APIKEY;

class WeatherService {
  static getCurrentWeather({required int lat, required int log}) async {
    try {
      const currentweather = "/current.json?key=$apiKey& q=48.8567,2.350";
      final finalUrl = baseurl + currentweather;
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      rethrow;
    }
  }
}
