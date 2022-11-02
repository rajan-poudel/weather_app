import 'package:flutter/material.dart';
import 'package:weather/widgets/search_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          TextButton(onPressed: () {}, child: const Text("Save"))
        ],
      ),
    );
  }
}
