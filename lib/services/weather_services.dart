import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  static getRawLocationWeather({required String location}) async {
    try {
      String currentweather = "/current.json?key=$apiKey&q=$location";
      String finalUrl = baseurl + currentweather;
      final response = await http.get(Uri.parse(finalUrl));
      log(response.reasonPhrase.toString());
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        Fluttertoast.showToast(
            msg: "Please Search Correct Location",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
