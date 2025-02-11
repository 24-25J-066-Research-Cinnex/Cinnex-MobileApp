import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../Shared/Widget/curved_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class  CinnomonSpeciesResponseScreen extends StatefulWidget {
  final Map<String, dynamic> detect;
  final File? image;
  const CinnomonSpeciesResponseScreen({
    super.key,
    required this.detect,
    required this.image,
  });
  @override
  CinnomonSpeciesResponseScreenState createState() =>
      CinnomonSpeciesResponseScreenState();
}

class CinnomonSpeciesResponseScreenState
    extends State<CinnomonSpeciesResponseScreen> {
  static final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Access colors
    final textTheme = theme.textTheme; // Access text styles

    _logger.d('Disease Detected: ${widget.detect['prediction']}');

    return Scaffold(
      body: Stack(
        children: [
          // Curved AppBar Background
          CurvedAppBar(
            title: AppLocalizations.of(context)!.cinnamon_grades,
            trailingIcon: Icons.notifications,
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
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40), // Space below AppBar
                // Input Fields
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: colorScheme.primary, width: 2),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[100],
                            ),
                            child: widget.image != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                widget.image!,
                                fit: BoxFit.cover,
                              ),
                            )
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${widget.detect['prediction']}', // Disease Name
                          style: textTheme.bodyMedium,
                        ),
                        Text(
                          'Spread percentage: ${widget.detect['disease_spread_percentage'] } %',
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 16),
                        //Text(
                        // AppLocalizations.of(context)!
                        //.cinnamon_diseases_landing_content2,
                        //style: textTheme.bodyMedium,
                        //),
                        const SizedBox(height: 30),
                        // Predict Market Price Button
                        const Spacer(), // Push the button to the bottom
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
