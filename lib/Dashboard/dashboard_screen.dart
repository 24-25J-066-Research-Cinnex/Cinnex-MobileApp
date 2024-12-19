import 'package:cinnex_mobile/Shared/Widget/curved_appbar.dart';
import 'package:cinnex_mobile/Shared/Widget/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // Navigation handler
  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Add navigation logic here if needed.
  }

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
                const SizedBox(height: 100), // Space for the curved AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('assets/images/user_avatar.png'),
                      ),
                      title: Text(
                        'Gayashan Deshapriya',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: const Text('Galle District'),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Grid View for Features
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      children: [
                        _buildFeatureCard(
                          title: 'Price Forecast',
                          icon: Icons.bar_chart,
                          color: Colors.green,
                        ),
                        _buildFeatureCard(
                          title: 'Cinnamon Grades',
                          icon: Icons.layers,
                          color: Colors.orange,
                        ),
                        _buildFeatureCard(
                          title: 'Leaves',
                          icon: Icons.eco,
                          color: Colors.green,
                        ),
                        _buildFeatureCard(
                          title: 'Diseases',
                          icon: Icons.bug_report,
                          color: Colors.green,
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

      // Custom Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }

  // Feature Card Widget
  Widget _buildFeatureCard({
    required String title,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}


