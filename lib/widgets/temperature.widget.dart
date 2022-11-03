import 'package:flutter/material.dart';
import 'package:weather/controllers/weather.controller.dart';
import 'package:weather/widgets/app.large.text.dart';

class TemperatureWidget extends StatelessWidget {
  Size size;
  WeatherProvider weatherProvider;

  TemperatureWidget({
    required this.size,
    required this.weatherProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.40,
      width: size.width * 0.80,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppLargeText(
              text: weatherProvider.weatherResultModel.location?.name
                      .toString() ??
                  "",
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: size.width * 0.2,
            height: size.height * 0.18,
            child: weatherProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Image.network(
                    "https:${weatherProvider.weatherResultModel.current!.condition!.icon}",
                    // fit: BoxFit.,
                  ),
          ),
          AppLargeText(
            text:
                "${weatherProvider.weatherResultModel.current?.tempC.toString() ?? ""}°C",
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
          AppLargeText(
            text: weatherProvider.weatherResultModel.current?.condition?.text
                    .toString() ??
                "",
            color: Colors.white,
            size: 12,
          ),
        ],
      ),
    );
  }
}
