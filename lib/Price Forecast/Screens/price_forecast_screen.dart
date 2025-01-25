import 'package:cinnex_mobile/Price%20Forecast/screens/price_forecast_response.dart';
import 'package:cinnex_mobile/Shared/Widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:logger/logger.dart';
import '../../Shared/Widget/curved_appbar.dart';
import '../Services/forecast_service.dart';

class PriceForecastScreen extends StatefulWidget {
  const PriceForecastScreen({super.key});

  @override
  State<PriceForecastScreen> createState() => _PriceForecastScreenState();
}

class _PriceForecastScreenState extends State<PriceForecastScreen> {
  final logger = Logger();
  final List<String> grades = [
    'Alba',
    'C-5 Sp',
    'C-5',
    'C-4',
    'H-2',
  ];
  final List<String> regions = [
    'Galle',
    'Matara',
    'Kalutara',
  ];

  String? selectedGrade;
  String? selectedLocation;
  String? selectedDate; // Holds the selected date.
  double fontSize = 16.0;

  ///function to call forecast service
  Future<Map<String, dynamic>> getForecast() async {
    final location = selectedLocation;
    final grade = selectedGrade;
    final forecastDate = selectedDate;

    if (location != null && grade != null && forecastDate != null) {
      try {
        final forecast = await ForecastService.getForecast(location, grade, forecastDate);
        logger.d('Forecast: $forecast');
        return forecast; // Return the forecast data
      } catch (e) {
        logger.e('Error getting forecast: $e');
        rethrow;
      }
    } else {
      logger.e('Please select all required fields');
      throw Exception('Please select all required fields');
    }
  }

  /// Function to open the date picker and update the selected date.
  void _showDatePicker() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: SfDateRangePicker(
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is DateTime) {
                setState(() {
                  selectedDate = DateFormat('yyyy-MM-dd').format(args.value);
                  fontSize = 16.0;
                  Navigator.pop(
                      context); // Close the date picker after selection
                });
              }
            },
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedDate: DateTime.now(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //final colorScheme = theme.colorScheme; // Access colors
    final textTheme = theme.textTheme; // Access text styles

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
                    AppLocalizations.of(context)!.price_forecast_content,
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
                        // Prediction Date Field with Calendar
                        GestureDetector(
                          onTap: _showDatePicker,
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!
                                  .price_forecast_date,
                              labelStyle: textTheme.bodySmall,
                              suffixIcon: const Icon(Icons.calendar_today),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onTap: _showDatePicker,
                            controller:
                                TextEditingController(text: selectedDate ?? ''),
                            // Open the date picker
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Cinnamon Grade Dropdown
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              AppLocalizations.of(context)!
                                  .price_forecast_grade,
                              style: textTheme.bodySmall,
                            ),
                            items: grades
                                .map((grade) => DropdownMenuItem<String>(
                                      value: grade,
                                      child: Text(
                                        grade,
                                        style: textTheme.bodySmall,
                                      ),
                                    ))
                                .toList(),
                            value: selectedGrade,
                            onChanged: (value) {
                              setState(() {
                                selectedGrade = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black26),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Region Dropdown
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              AppLocalizations.of(context)!
                                  .price_forecast_region,
                              style: textTheme.bodySmall,
                            ),
                            items: regions
                                .map((region) => DropdownMenuItem<String>(
                                      value: region,
                                      child: Text(
                                        region,
                                        style: textTheme.bodySmall,
                                      ),
                                    ))
                                .toList(),
                            value: selectedLocation,
                            onChanged: (value) {
                              setState(() {
                                selectedLocation = value;
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black26),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Predict Market Price Button
                        CustomButton(
                          text: AppLocalizations.of(context)!.price_forecast_button,
                          onPressed: () async {
                            try {
                              final forecastData = await getForecast();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PriceForecastResponseScreen(
                                    forecast: forecastData, // Pass the required forecastData
                                  ),
                                ),
                              );
                            } catch (e) {
                              logger.e('Error getting forecast: $e');
                            }
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
