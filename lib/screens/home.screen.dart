import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather/widgets/search.field.dart';
import 'package:weather/widgets/temperature.widget.dart';

import '../controllers/weather.controller.dart';

class HomeScreen extends StatefulWidget {
  Position position;
  HomeScreen({super.key, required this.position});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  static const String searchItem = '';

  searchHandling() {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchController.text.isEmpty) {
      context.read<WeatherProvider>().getCurrentWeather(
          lat: widget.position.latitude, log: widget.position.longitude);
    } else {
      context
          .read<WeatherProvider>()
          .getLocationWeather(location: _searchController.text);
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
    log(widget.position.latitude.toString());
    final searchPvr = Provider.of<WeatherProvider>(context, listen: false);
    // context.read<WeatherProvider>().getCurrentWeather(
    //     lat: widget.position.latitude, log: widget.position.longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(context, )
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
              onPressed: () {
                setState(() {
                  searchHandling();
                  _searchController.clear();
                });
                // log(searchItem);
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
