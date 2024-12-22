import 'package:flutter/material.dart';

class DiseaseDitectionScreen extends StatefulWidget {
  const DiseaseDitectionScreen({super.key});
  @override
  _DiseaseDitectionScreenState createState() => _DiseaseDitectionScreenState();
}

class _DiseaseDitectionScreenState extends State<DiseaseDitectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disease Detection'),
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