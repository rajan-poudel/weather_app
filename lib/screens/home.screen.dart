import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/screens/help.screen.dart';
import 'package:weather/widgets/search.field.dart';
import 'package:weather/widgets/temperature.widget.dart';

import '../controllers/weather.controller.dart';

class HomeScreen extends StatefulWidget {
  String? location;
  Position position;
  HomeScreen({super.key, required this.position, this.location});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  // static const String searchItem = '';

  searchHandling() {
    log(" SEARCH ${_searchController.text}");
    if (_searchController.text.isEmpty && widget.location == null) {
      context.read<WeatherProvider>().getCurrentWeather(
          lat: widget.position.latitude, log: widget.position.longitude);
    } else if (widget.location == null || _searchController.text.isNotEmpty) {
      context
          .read<WeatherProvider>()
          .getLocationWeather(location: _searchController.text);
    } else {
      context
          .read<WeatherProvider>()
          .getLocationWeather(location: widget.location.toString());
    }
  }

  @override
  void initState() {
    searchHandling();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()));
            },
            icon: const Icon(Icons.help),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SearchField(_searchController),
          ),
          TextButton(
              onPressed: () async {
                searchHandling();
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString("location", _searchController.text);

                _searchController.clear();
              },
              child: const Text("Save")),
          Consumer<WeatherProvider>(builder: (_, weather, __) {
            return TemperatureWidget(size: size, weatherProvider: weather);
          }),
        ],
      ),
    );
  }
}
