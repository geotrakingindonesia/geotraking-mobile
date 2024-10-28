// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geotraking/core/services/weather_service.dart';

class WeatherDataModal extends StatefulWidget {
  final Map<String, dynamic>? vesselData;

  const WeatherDataModal({Key? key, required this.vesselData})
      : super(key: key);

  @override
  _WeatherDataModalState createState() => _WeatherDataModalState();
}

class _WeatherDataModalState extends State<WeatherDataModal> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    final latitude = widget.vesselData?['lat'];
    final longitude = widget.vesselData?['lon'];

    final parsedLatitude =
        latitude != null ? double.tryParse(latitude.toString()) : null;
    final parsedLongitude =
        longitude != null ? double.tryParse(longitude.toString()) : null;

    if (parsedLatitude != null && parsedLongitude != null) {
      final data = await _weatherService.getWeatherByCoordinates(
          parsedLatitude, parsedLongitude);
      setState(() {
        _weatherData = data;
      });
    } else {
      print(
          'Latitude atau longitude tidak ditemukan atau tidak valid di vesselData.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 27, 38, 44),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            _weatherData != null
                ? Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '${_weatherData!['name'] ?? 'Unknown'}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            if (_weatherData!['weather'] != null &&
                                _weatherData!['weather'][0]['icon'] != null)
                              Image.network(
                                'https://openweathermap.org/img/wn/${_weatherData!['weather'][0]['icon']}@2x.png',
                                width: 75,
                                height: 75,
                              ),
                            Text(
                              '${_weatherData!['weather'][0]['description']}',
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_weatherData!['main']['temp']}°C',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.water_drop,
                                  size: 15,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Humidity: ${_weatherData!['main']['humidity']}%',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white70),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.wind,
                                  size: 15,
                                  color: Colors.white70,
                                ),
                                SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    'Wind Speed: ${(double.parse(_weatherData!['wind']['speed'].toString()) * 3.6).toStringAsFixed(1)} km/h',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white70),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(child: Text('No data available')),
          ],
        ),
      ),
    );
  }
}
