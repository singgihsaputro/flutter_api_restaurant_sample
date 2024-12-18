import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class NetworkLogger {
  final Logger _logger = Logger('NetworkLogger');

  Future<http.Response> get(String url) async {
    _logger.info('GET $url');
    final response = await http.get(Uri.parse(url));
    _logResponse(response);
    return response;
  }

  Future<http.Response> post(String url, {Map<String, String>? headers, body, Encoding? encoding}) async {
    _logger.info('POST $url');
    final response = await http.post(Uri.parse(url), headers: headers, body: body, encoding: encoding);
    _logResponse(response);
    return response;
  }

  void _logResponse(http.Response response) {
    _logger.info('Response status: ${response.statusCode}');
    _logger.info('Response body: ${response.body}');
  }
}