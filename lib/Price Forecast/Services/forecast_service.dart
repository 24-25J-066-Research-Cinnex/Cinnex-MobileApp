import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForecastService {
  var baseUrl = 'http://127.0.0.1:8000/predict';
  static final Logger _logger = Logger();

  static Future<Map<String, dynamic>> getForecast(String location, String grade,
      String forecastDate) async {
    try {
      Uri url = Uri.parse('http://10.0.2.2:8000/predict');
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