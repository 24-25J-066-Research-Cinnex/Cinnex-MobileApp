import 'package:cinnex_mobile/Price%20Forecast/price_forecast_screen.dart';
import 'package:cinnex_mobile/Shared/Widget/curved_appbar.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Curved AppBar
          const CurvedAppBar(
            title: 'Dashboard',
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
                      childAspectRatio: 3 / 4, // Adjust aspect ratio for card size
                      children: [
                        _buildFeatureCard(
                          title: 'Price Forecast',
                          imagePath: 'assets/images/Price Forecast Icon.png',
                          color: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const PriceForecastScreen(),
                              ),
                            );
                          },
                        ),
                        _buildFeatureCard(
                          title: 'Cinnamon Grades',
                          imagePath: 'assets/images/Disease Detection Icon.png',
                          color: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            // Add navigation to Cinnamon Grades screen
                          },
                        ),
                        _buildFeatureCard(
                          title: 'Leaves',
                          imagePath: 'assets/images/Disease Detection Icon.png',
                          color: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            // Add navigation to Leaves screen
                          },
                        ),
                        _buildFeatureCard(
                          title: 'Diseases',
                          imagePath: 'assets/images/Disease Detection Icon.png',
                          color: Theme.of(context).colorScheme.primary,
                          onTap: () {
                            // Add navigation to Diseases screen
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

  Widget _buildFeatureCard({
    required String title,
    required String imagePath,
    required Color color,
    required VoidCallback onTap,
  }) {
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
              imagePath, // The path to your image
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
