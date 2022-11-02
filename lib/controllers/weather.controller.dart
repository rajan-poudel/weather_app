import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/models/weather.result.model.dart';
import 'package:weather/services/weather_services.dart';

enum WeatherLoadingSate {
  initial,
  loading,
  sucess,
  error,
}

class WeatherProvider with ChangeNotifier {
  final bool _isLoading = false;
  bool get isLoading => _isLoading;

  WeatherResultModel _weatherResultModel = WeatherResultModel();
  WeatherResultModel get weatherResultModel => _weatherResultModel;

  Future getCurrentWeather({required int lat, required int log}) async {
    WeatherResultModel currentWeatherResult = WeatherResultModel();
    final responseBody = WeatherService.getCurrentWeather(lat: lat, log: log);
    final weather = WeatherResultModel.fromJson(json.decode(responseBody));
    notifyListeners();
    currentWeatherResult = weather;
    notifyListeners();
    _weatherResultModel = currentWeatherResult;
    notifyListeners();
  }
}
