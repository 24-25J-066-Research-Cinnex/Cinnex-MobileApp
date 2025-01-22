import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cinnex_mobile/Shared/Widget/curved_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
        body: Stack(children: [
      CurvedAppBar(
        title: appLocalizations.settings,
        trailingIcon: Icons.notifications,
        onTrailingIconPressed: null, // Add action if needed
      ),
      SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          children: [
            ListTile(
              title: Text(appLocalizations.profile),
              subtitle: Text(appLocalizations.cinnamon_diseases),
              onTap: () {
                Navigator.pushNamed(context, '/language-selection');
              },
            ),
          ],
        ),
      ),
    ]));
  }
}
