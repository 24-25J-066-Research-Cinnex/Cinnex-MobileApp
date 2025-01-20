import 'package:cinnex_mobile/Cinnamon%20Grades/Screens/cinnamon_grades_screen.dart';
import 'package:cinnex_mobile/Cinnamon%20Species/Screens/cinnamon_species_screen.dart';
import 'package:cinnex_mobile/Shared/Widget/curved_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Disease Detection/Screens/disease_detection_landing_screen.dart';
import '../Price Forecast/screens/price_forecast_landing.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          // Curved AppBar
          CurvedAppBar(
            title: appLocalizations.dashboard,
            trailingIcon: Icons.notifications,
            onTrailingIconPressed: null, // Add action if needed
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 150), // Space for the curved AppBar

                // Grid View for Features
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio:
                          3 / 4, // Adjust aspect ratio for card size
                      children: [
                        FeatureCard(
                          title: appLocalizations.price_forecast,
                          imagePath: 'assets/images/Price Forecast Icon.png',
                          color: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const PriceForecastLandingScreen(),
                              ),
                            );
                          },
                        ),
                        FeatureCard(
                          title: appLocalizations.cinnamon_grades,
                          imagePath: 'assets/images/Cinnamon Grade Icon.png',
                          color: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CinnomonGradesScreen(),
                              ),
                            );
                          },
                        ),
                        FeatureCard(
                          title: appLocalizations.cinnamon_species,
                          imagePath: 'assets/images/Cinnamon Species Icon.png',
                          color: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CinnamonSpeciesScreen(),
                              ),
                            );
                          },
                        ),
                        FeatureCard(
                          title: appLocalizations.cinnamon_diseases,
                          imagePath: 'assets/images/Disease Detection Icon.png',
                          color: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DiseaseDetectionLandingScreen(),
                              ),
                            );
                          },
                        ),
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

class FeatureCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color color;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Displaying the image
            Image.asset(
              imagePath,
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
