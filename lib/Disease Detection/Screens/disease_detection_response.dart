import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import '../../Shared/Widget/curved_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiseaseDetectionResponseScreen extends StatefulWidget {
  final Map<String, dynamic> detect;
  final File? image;

   const DiseaseDetectionResponseScreen({
    super.key,
    required this.detect,
    required this.image,
  });

  @override
  DiseaseDetectionResponseScreenState createState() =>
      DiseaseDetectionResponseScreenState();
}

class DiseaseDetectionResponseScreenState
    extends State<DiseaseDetectionResponseScreen> {

  static Image base64ToImage(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Access colors
    final textTheme = theme.textTheme; // Access text styles

    Image? explanationImage = widget.detect['explanation_image'] != null
        ? base64ToImage(widget.detect['explanation_image'])
        : null;

    return Scaffold(
      body: Stack(
        children: [
          // Curved AppBar Background
          CurvedAppBar(
            title: AppLocalizations.of(context)!.cinnamon_diseases,
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
                        // Disease Detection Response original image
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
                                  ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Disease Detection Response explanation image
                        widget.detect['prediction'] == 'Cinnamon_Leaf Spot Disease' && explanationImage != null
                            ? GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 175,
                            width: 350,
                            decoration: BoxDecoration(
                              border: Border.all(color: colorScheme.primary, width: 2),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[100],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: explanationImage,
                            ),
                          ),
                        )
                            : Container(),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Switch to LKR
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!
                                .predicted_disease,
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${widget.detect['prediction']}', // Disease Name
                            style: textTheme.bodyLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        Text(
                          'Spread percentage: ${widget.detect['disease_spread_percentage'] } %',
                          style: textTheme.bodySmall,
                        ),
                        const SizedBox(height: 16),
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
