import 'package:cinnex_mobile/Shared/Widget/custom_button.dart';
import 'package:flutter/material.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final Function(Locale) onLanguageChange;

  const LanguageSelectionScreen({super.key, required this.onLanguageChange});

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
                "Select Your prefer Language ",
                style: textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'ඔබ කැමති භාෂාව තෝරන්න',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: 30),
              CustomButton(
                  text: "English",
                  onPressed: () {
                    onLanguageChange(Locale('en')); // Change to English
                  }),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('OR',
                      style: textTheme.headlineSmall,),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                  text: "සිංහල",
                  onPressed: () {
                    onLanguageChange(Locale('si')); // Change to English
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
