import 'package:cinnex_mobile/Dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinnex Mobile App',
      theme: ThemeData(
        useMaterial3: false,
        // Define the default brightness and colors.
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF018241),
          primary: Color(0xFF018241),
          secondary: Color(0xFF018241),
          surface: Color(0xFF018241),
          brightness: Brightness.light,
        ),


      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleLarge: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        titleMedium: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        titleSmall: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        bodySmall: const TextStyle(
          fontSize: 12.0,
          color: Colors.black,
        ),
      )
      ),
      home: DashboardScreen(
        key: const ValueKey('dashboard_screen'),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}