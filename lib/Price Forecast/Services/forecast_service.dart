import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../Shared/Services/config.dart';


class ForecastService {
  //var baseUrl = 'http://192.168.8.100:8000/price_predict';
  static final Logger _logger = Logger();

  static Future<Map<String, dynamic>> getForecast(String location, String grade,
      String forecastDate) async {
    try {
      Uri url = Uri.parse('${Config.baseUrl}/price_predict'); // Use the base URL from config
      _logger.i('Getting forecast');
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'location': location,
            'grade': grade,
            'forecast_date': forecastDate // Use snake_case
          }));
      _logger.d('API Response: ${response.statusCode} ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get forecast: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error getting forecast: $e');
      rethrow;
    }
  }
}