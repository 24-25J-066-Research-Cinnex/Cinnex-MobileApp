import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import '../../Shared/Services/config.dart';

class SpeciesService {
  //var baseUrl = 'http://192.168.8.102:8000/leaf_classify';
  static final Logger _logger = Logger();

  static Future<Map<String, dynamic>> getSpecies(File image) async {
    try {
      Uri url = Uri.parse('${Config.baseUrl}/leaf_classify');
      _logger.i('Detecting Species');

      var request = http.MultipartRequest('POST', url)
        ..files.add(await http.MultipartFile.fromPath('file', image.path));

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      _logger.d('API Response: ${response.statusCode} $responseBody');

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        throw Exception('Failed to detect Species: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Error detecting Species: $e');
      rethrow;
    }
  }
}