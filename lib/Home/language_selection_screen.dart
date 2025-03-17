import 'package:cinnex_mobile/Shared/Widget/custom_button.dart';
import 'package:flutter/material.dart';

import '../Onboarding/onboarding_view.dart';


class LanguageSelectionScreen extends StatelessWidget {
  final Function(Locale) onLanguageChange;

  const LanguageSelectionScreen({super.key, required this.onLanguageChange});

  void _onLanguageChange(BuildContext context, Locale locale) {
    onLanguageChange(locale); // Pass the selected locale to MyApp
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingView(locale: locale),
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
              Image.asset(
                'assets/images/cinneX.png',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 40),
              Text(
                "Select Your Preferred Language",
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              Text(
                'ඔබ කැමති භාෂාව තෝරන්න',
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 30),
              LanguageButton(
                text: "English",
                locale: const Locale('en'),
                onPressed: (locale) => _onLanguageChange(context, locale),
              ),
              const SizedBox(height: 20),
              const OrDivider(),
              const SizedBox(height: 20),
              LanguageButton(
                text: "සිංහල",
                locale: const Locale('si'),
                onPressed: (locale) => _onLanguageChange(context, locale),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageButton extends StatelessWidget {
  final String text;
  final Locale locale;
  final void Function(Locale) onPressed;

  const LanguageButton({
    super.key,
    required this.text,
    required this.locale,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: text,
      onPressed: () => onPressed(locale),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
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
    );
  }
}
