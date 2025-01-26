import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cinnex_mobile/Shared/Widget/curved_appbar.dart';
import 'package:provider/provider.dart';
import './locale_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    //final textTheme = theme.textTheme;

    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          CurvedAppBar(
            title: appLocalizations.settings,
            trailingIcon: Icons.notifications,
            onTrailingIconPressed: null, // Add action if needed
          ),
          SafeArea(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              children: [
                const SizedBox(height: 150),
                ListTile(
                  title: Text(appLocalizations.language),
                  subtitle: Text(appLocalizations.settings),
                  trailing: const Icon(Icons.language),
                  onTap: () {
                    _showLanguageSelectionDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.settings),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('English'),
                onTap: () {
                  _changeLanguage(context, const Locale('en'));
                },
              ),
              ListTile(
                title: const Text('සිංහල'),
                onTap: () {
                  _changeLanguage(context, const Locale('si'));
                },
              )
            ],
          ),
        );
      },
    );
  }

  void _changeLanguage(BuildContext context, Locale locale) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    localeProvider.setLocale(locale);
    Navigator.pop(context); // Close the dialog
  }
}
