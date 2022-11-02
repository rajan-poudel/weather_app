import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/screens/home.screen.dart';
import 'package:weather/utils/location.helper.dart';
import 'package:weather/widgets/app_large_text.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  late Timer timer;
  Position? position;

  route() async {
    position = await getGeoLocationPosition().whenComplete(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            position: position!,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    timer = Timer(const Duration(seconds: 6), route);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Image.network(
              "https://www.vhv.rs/dpng/d/427-4270068_gold-retro-decorative-frame-png-free-download-transparent.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            right: 30,
            child: TextButton(
              onPressed: () async {
                Position position = await getGeoLocationPosition();

                final SharedPreferences pref =
                    await SharedPreferences.getInstance();
                pref.setBool("isSkip", true).then((_) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeScreen(
                        position: position,
                      ),
                    ),
                  );
                });
              },
              child: Container(
                height: 50,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue.withOpacity(0.2)),
                child: const Center(
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(child: AppLargeText(text: "We show weather for you"))
        ],
      )),
    );
  }
}
