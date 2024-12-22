import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  final Function(Locale) onLanguageChange;
  const HomeScreen({super.key, required this.onLanguageChange});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                onLanguageChange(Locale('en')); // Change to English
              },
              child: Text('English'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onLanguageChange(Locale('si')); // Change to Sinhala
              },
              child: Text('සිංහල'),
            ),
          ],
        ),
      ),
    );
  }
}
