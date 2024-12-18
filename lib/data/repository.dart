import 'dart:convert';
import 'package:http/http.dart' as http;

import '../util/network_logger.dart';

class Repository {

  final base_url = "https://private-0327f-restaurant38.apiary-mock.com";

  final NetworkLogger _networkLogger = NetworkLogger();

  Future<List> loadRestaurantList() async {
    final response = await _networkLogger.get('$base_url/restaurant');
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['restaurants'];
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }
}