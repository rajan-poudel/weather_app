import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather/widgets/search_field.dart';

import '../controllers/weather.controller.dart';

class HomeScreen extends StatefulWidget {
  Position position;
  HomeScreen({super.key, required this.position});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    log(widget.position.latitude.toString());
    final searchPvr = Provider.of<WeatherProvider>(context, listen: false);
    context.read<WeatherProvider>().getCurrentWeather(
        lat: widget.position.latitude, log: widget.position.longitude);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Home Screen"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SearchField(),
          ),
          TextButton(onPressed: () {}, child: const Text("Save")),
          Consumer<WeatherProvider>(builder: (_, weather, __) {
            return Text(
                weather.weatherResultModel.current?.tempC.toString() ?? "1");
          }),
        ],
      ),
    );
  }
}
