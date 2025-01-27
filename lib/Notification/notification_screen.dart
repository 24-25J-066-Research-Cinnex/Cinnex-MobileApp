import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Shared/Widget/curved_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //get the message from the arguments
    RemoteMessage? message =
        ModalRoute.of(context)?.settings.arguments as RemoteMessage?;

    if (message == null) {
      return Scaffold(
        body: Stack(
          children: [
            CurvedAppBar(
              title: AppLocalizations.of(context)!.notification,
              trailingIcon: Icons.refresh,
            ),
            SafeArea(
              child: Column(
                children: [
                  // AppBar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50), // Space below AppBar
                  Text(
                    AppLocalizations.of(context)!.notification,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        body: Stack(
      children: [
        CurvedAppBar(
          title: AppLocalizations.of(context)!.notification,
          trailingIcon: Icons.refresh,
          onTrailingIconPressed: null, // Add action if needed
        ),
        SafeArea(
          child: Column(
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon:
                      const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50), // Space below AppBar
              Text(
                AppLocalizations.of(context)!.notification,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Text(
            "Title: ${message.notification?.title}",
            style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
            "Body: ${message.notification?.body}",
            style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ));
  }
}
