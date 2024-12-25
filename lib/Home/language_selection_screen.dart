import 'package:cinnex_mobile/Shared/Widget/custom_button.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final Function(Locale) onLanguageChange;

  const LanguageSelectionScreen({super.key, required this.onLanguageChange});

  void _onLanguageChange(BuildContext context, Locale locale) {
    onLanguageChange(locale); // Pass the selected locale to MyApp
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainLayout(locale: locale),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Select Your Preferred Language",
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'ඔබ කැමති භාෂාව තෝරන්න',
                style: textTheme.bodyMedium,
              ),
              const SizedBox(height: 30),
              CustomButton(
                text: "English",
                onPressed: () {
                  _onLanguageChange(context, const Locale('en')); // Change to English
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      style: textTheme.bodySmall,
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "සිංහල",
                onPressed: () {
                  _onLanguageChange(context, const Locale('si')); // Change to Sinhala
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
