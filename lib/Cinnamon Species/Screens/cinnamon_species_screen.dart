import 'package:flutter/material.dart';

class CinnamonSpeciesScreen extends StatefulWidget {
  const CinnamonSpeciesScreen({super.key});
  @override
  _CinnamonSpeciesScreenState createState() => _CinnamonSpeciesScreenState();
}

class _CinnamonSpeciesScreenState extends State<CinnamonSpeciesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinnamon Species'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
          child: const Text('Launch screen'),
        ),
      ),
    );
  }
}