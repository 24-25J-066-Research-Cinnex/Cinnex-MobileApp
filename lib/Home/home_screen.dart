import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Shared/Widget/curved_appbar.dart';

class HomeScreen extends StatelessWidget {
  //final Function(Locale) onLanguageChange;
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Curved AppBar
           CurvedAppBar(
            title: AppLocalizations.of(context)!.home,
            trailingIcon: Icons.notifications,
            onTrailingIconPressed: null, // Add action if needed
          ),
          // Body
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.message,
                //style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
