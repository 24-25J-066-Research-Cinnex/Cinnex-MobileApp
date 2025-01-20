import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForecastService {
  var baseUrl = 'http://127.0.0.1:8000/predict';
  static final Logger _logger = Logger();

  static Future getForecast(String location, String grade, String forecastDate) async {
    try{
      Uri url =
      Uri.parse('http://127.0.0.1:8000/predict');
      _logger.i('Getting forecast');
      // Call the API
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'location': location, 'grade': grade, 'forecastDate': forecastDate}));
      _logger.d('API Response: ${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get forecast');
      }
    }
    catch (e) {
      _logger.e('Error getting forecast: $e');
    }


  }
}

void getPrice() async {
  final url = Uri.parse('http://127.0.0.1:8000/predict');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'location': 'Galle',
      'grade': 'Alba',
      'forecastDate': '2023-10-10',
    }),
  );

  if (response.statusCode == 200) {
    print('Response data: ${response.body}');
  } else {
    print('Failed to get forecast: ${response.statusCode}');
  }
}