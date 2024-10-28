// lib/services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'c7df5eaf639fba562eb5e77c7f24a285'; 
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>?> getWeatherByCoordinates(double latitude, double longitude) async {
    final url = Uri.parse('$baseUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
