// lib/services/weather_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart'; 

class WeatherService {
  final String _baseUrl = 'http://api.openweathermap.org/data/2.5/weather';
  final String _apiKey = 'deb5a7a034471bd5899568fff2584348';

  Future<Weather> fetchWeather(double lat, double lon) async {
    final response = await http.get(Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey'));
    print(response.body) ;

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
