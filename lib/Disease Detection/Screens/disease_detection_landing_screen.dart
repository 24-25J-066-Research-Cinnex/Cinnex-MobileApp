import 'package:cinnex_mobile/Shared/Widget/custom_button.dart';
import 'package:flutter/material.dart';
import '../../Shared/Widget/curved_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cinnex_mobile/Disease Detection/screens/disease_detection_screen.dart';

class DiseaseDetectionLandingScreen extends StatefulWidget {
  const DiseaseDetectionLandingScreen({super.key});

  @override
  State<DiseaseDetectionLandingScreen> createState() =>
      _DiseaseDetectionLandingScreenState();
}

class _DiseaseDetectionLandingScreenState
    extends State<DiseaseDetectionLandingScreen> {
  @override
  Widget build(BuildContext context) {
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
                      horizontal: 15.0, vertical: 7.0),
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
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    AppLocalizations.of(context)!
                        .cinnamon_diseases_content,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10), // Space before input fields

                // Instruction Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppLocalizations.of(context)!
                        .cinnamon_diseases_landing_content2,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),

                // Input Fields
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        // Prediction Date Field with Calendar
                        const SizedBox(height: 5),

                        CustomButton(
                          text: AppLocalizations.of(context)!
                              .price_forecast_continue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DiseaseDetectionScreen()),
                            );
                          },
                        ),
                        // Predict Market Price Button
                        // Push the button to the bottom
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
