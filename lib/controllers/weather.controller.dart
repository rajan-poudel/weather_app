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
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  WeatherResultModel _weatherResultModel = WeatherResultModel();
  WeatherResultModel get weatherResultModel => _weatherResultModel;

  Future getCurrentWeather({required double lat, required double log}) async {
    _isLoading = true;
    WeatherResultModel currentWeatherResult = WeatherResultModel();
    final responseBody =
        await WeatherService.getRawCurrentWeather(lat: lat, log: log);
    currentWeatherResult = WeatherResultModel.fromJson(responseBody);

    _isLoading = false;
    notifyListeners();

    _weatherResultModel = currentWeatherResult;
    notifyListeners();
  }
}
