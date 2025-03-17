import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../Shared/Widget/curved_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Shared/Widget/custom_button.dart';

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
  static final Logger _logger = Logger();
  static Image base64ToImage(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }

  // Function to open the modal bottom sheet
  void _openModalBottomSheet(BuildContext context, String predictedDisease) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.cinnamon_diseases_button3,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (predictedDisease == 'Leaf_Gall_Forming')
                Text(
                  AppLocalizations.of(context)!.disease_ditect_gall_treatment,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              if (predictedDisease == 'Cinnamon_Leaf Spot Disease')
                Text(
                  AppLocalizations.of(context)!.disease_ditect_spot_treatment,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the modal
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Access colors
    final textTheme = theme.textTheme; // Access text styles
    final String predictedDisease = widget.detect['prediction'];
    _logger.d('Grade Detected: ${widget.detect['prediction']}');

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
                            AppLocalizations.of(context)!.predicted_disease,
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          switch (predictedDisease) {
                            'Cinnamon_Healthy Leaf' =>
                              'This is a Healthy one', // Replace with your desired text for DiseaseA
                            'Cinnamon_Leaf Spot Disease' =>
                              'Cinnamon Leaf Spot', // Replace with your desired text for DiseaseB
                            'Leaf_Gall_Forming' =>
                              'Cinnamon Leaf Gall', // Replace with your desired text for DiseaseC
                            _ =>
                              'Unknown Disease', // Default text if the disease is not recognized
                          },
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (predictedDisease == 'Cinnamon_Healthy Leaf')
                          Text(
                            AppLocalizations.of(context)!
                                .disease_ditect_healthy,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),
                        if (predictedDisease == 'Cinnamon_Leaf Spot Disease')
                          Text(
                            AppLocalizations.of(context)!.disease_ditect_spot,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),
                        if (predictedDisease == 'Leaf_Gall_Forming')
                          Text(
                            AppLocalizations.of(context)!.disease_ditect_gall,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),

                        const SizedBox(height: 30),
                        AbsorbPointer(
                          absorbing: predictedDisease ==
                              'Cinnamon_Healthy Leaf', // Disable interactions only for healthy leaves
                          child: Opacity(
                            opacity: predictedDisease == 'Cinnamon_Healthy Leaf'
                                ? 0.5
                                : 1.0, // Gray out the button only for healthy leaves
                            child: CustomButton(
                              text: AppLocalizations.of(context)!
                                  .cinnamon_diseases_button3,
                              onPressed: () async {
                                _openModalBottomSheet(
                                    context, predictedDisease);
                              },
                            ),
                          ),
                        ),
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
