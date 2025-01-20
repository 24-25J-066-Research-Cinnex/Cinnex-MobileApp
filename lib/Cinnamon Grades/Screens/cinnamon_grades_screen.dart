import 'package:flutter/material.dart';

class CinnomonGradesScreen extends StatefulWidget {
  const CinnomonGradesScreen({super.key});
  @override
  _CinnomonGradesScreenState createState() => _CinnomonGradesScreenState();
}

class _CinnomonGradesScreenState extends State<CinnomonGradesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinnomon Grades'),
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