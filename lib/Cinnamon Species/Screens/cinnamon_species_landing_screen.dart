import 'package:cinnex_mobile/Cinnamon%20Species/Screens/cinnamon_species_screen.dart';
import 'package:cinnex_mobile/Shared/Widget/custom_button.dart';
import 'package:flutter/material.dart';
import '../../Shared/Widget/curved_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CinnamonSpeciesLandingScreen extends StatefulWidget {
  const CinnamonSpeciesLandingScreen({super.key});

  @override
  State<CinnamonSpeciesLandingScreen> createState() =>
      _CinnamonSpeciesLandingScreenState();
}

class _CinnamonSpeciesLandingScreenState
    extends State<CinnamonSpeciesLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Curved AppBar Background
          CurvedAppBar(
            title: AppLocalizations.of(context)!.cinnamon_species,
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

                const SizedBox(height: 60), // Space below AppBar

                // Instruction Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    AppLocalizations.of(context)!
                        .cinnamon_species_landing_content1,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 40), // Space before input fields

                // Instruction Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppLocalizations.of(context)!
                        .cinnamon_species_landing_content2,
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
                        const SizedBox(height: 90),

                        CustomButton(
                          text: AppLocalizations.of(context)!
                              .price_forecast_continue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const CinnomonSpeciesScreen(),
                              ),
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
