import 'package:flutter/material.dart';
import 'package:cinnex_mobile/Shared/Widget/custom_button.dart';
import '../Shared/Widget/curved_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});
  @override
  DiseaseDetectionScreenState createState() => DiseaseDetectionScreenState();
}

class DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Access colors
    //final textTheme = theme.textTheme; // Access text styles

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

                const SizedBox(height: 50), // Space below AppBar

                // Instruction Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppLocalizations.of(context)!.cinnamon_diseases_content,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Space before input fields

                // Input Fields
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            // Add file picker logic here
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: colorScheme.primary, width: 2),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[100],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image, size: 50, color: colorScheme.primary),
                                const SizedBox(height: 8),
                                Text(
                                  "Select file",
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "or",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Add camera functionality here
                          },
                          icon: const Icon(Icons.camera_alt_outlined),
                          label: const Text("Open Camera and take photo"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[100],
                            foregroundColor: colorScheme.primary,
                            side: BorderSide(color: colorScheme.primary, width: 2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                          ),
                        ),
                        // Cinnamon Grade Dropdown

                        const SizedBox(height: 30),

                        // Region Dropdown

                        const SizedBox(height: 30),

                        // Predict Market Price Button
                        CustomButton(
                          text: AppLocalizations.of(context)!
                              .cinnamon_diseases_button,
                          onPressed: () {

                          },
                        ),
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