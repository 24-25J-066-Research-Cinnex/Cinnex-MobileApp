import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../Shared/Services/config.dart';

class DiseaseService {
  //var baseUrl = 'http://192.168.8.102:8000/disease_predict';
  static final Logger _logger = Logger();

  static Future<Map<String, dynamic>> getDisease(File image) async {
    try {
      Uri url = Uri.parse('${Config.baseUrl}/disease_predict');
      _logger.i('Detecting disease');

      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      _logger.d('API Response: ${response.statusCode} $responseBody');

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to detect disease: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error detecting disease: $e');
      rethrow;
    }
  }
}