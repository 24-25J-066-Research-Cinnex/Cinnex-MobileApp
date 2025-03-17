import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_charts/charts.dart'; // Correct import
import 'package:intl/intl.dart'; // For DateFormat
import '../../Shared/Widget/curved_appbar.dart';

class ChartData {
  final DateTime date;
  final double price;

  ChartData(this.date, this.price);
}

class PriceForecastResponseScreen extends StatefulWidget {

  final Map<String, dynamic> forecast;
  final Map<String, dynamic> forecastLstm;
  final String selectedDate;

  const PriceForecastResponseScreen({
    super.key,
    required this.forecast,
    required this.forecastLstm,
    required this.selectedDate,
  });
  @override
  _PriceForecastResponseScreenState createState() => _PriceForecastResponseScreenState();
}

class _PriceForecastResponseScreenState extends State<PriceForecastResponseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'Advice',
        desc: widget.forecastLstm['advice'] ?? 'No advice available.',
        btnOkOnPress: () {},
        btnOkColor: Color(0xFF018241),
      ).show();
    });
  }

  final _logger = Logger();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final forecast = widget.forecast;
    final forecastLstm = widget.forecastLstm;
    final selectedDate = widget.selectedDate;


    _logger.d('LKR ${forecast['predicted_price']}');
    _logger.d('predictions ${forecastLstm['predictions']}');
    _logger.d('advice ${forecastLstm['advice']}');

    // Prepare chart data
    final List<ChartData> chartData = [];
    final predictions = forecastLstm['predictions'] as List<dynamic>;
    final DateTime now = DateFormat('yyyy-MM-dd').parse(selectedDate);

    for (int i = 0; i < predictions.length; i++) {
      chartData.add(ChartData(
        now.subtract(Duration(days: predictions.length - i - 1)), // Assign dates for the last 7 days
        predictions[i].toDouble(), // Convert prediction to double
      ));
    }

    return Scaffold(
      body: Stack(
        children: [
          // Curved AppBar Background
          CurvedAppBar(
            title: AppLocalizations.of(context)!.price_forecast,
            trailingIcon: Icons.notifications,
            onTrailingIconPressed: null, // Add action if needed
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 50), // Space below the AppBar

                // Main Content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Currency Switch Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Currency Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
                                        .predicted_price,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Price Display
                            Text(
                              'LKR ${forecast['predicted_price']}', // Display price
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),

                            Text(
                              AppLocalizations.of(context)!.predicted_price2,
                              style: textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Line Chart
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: SfCartesianChart(
                          primaryXAxis: DateTimeAxis(
                            title: AxisTitle(text: 'Date'),
                            dateFormat: DateFormat('MMM dd'), // Format dates
                          ),
                          primaryYAxis: NumericAxis(
                            title: AxisTitle(text: 'Price (LKR)'),
                          ),
                          series: <CartesianSeries<dynamic, dynamic>>[
                            LineSeries<ChartData, DateTime>(
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.date,
                              yValueMapper: (ChartData data, _) => data.price,
                              color: colorScheme.primary,
                              markerSettings: const MarkerSettings(isVisible: true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacer to push elements to the bottom
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}