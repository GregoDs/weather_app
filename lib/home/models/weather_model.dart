import 'package:meta/meta.dart';

@immutable
class Weather {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final String sunrise; // New property
  final String sunset; // New property
  final double tempMax; // New property
  final double tempMin; // New property

  const Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.tempMax,
    required this.tempMin,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    // Parse sunrise and sunset timestamps from the 'sys' object
    final sunriseTimestamp = json['sys']['sunrise'] as int;
    final sunsetTimestamp = json['sys']['sunset'] as int;

    // Convert timestamps to human-readable time
    final sunrise = DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000)
        .toLocal()
        .toString()
        .split(' ')[1]
        .substring(0, 5); // Extract time in HH:mm format
    final sunset = DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000)
        .toLocal()
        .toString()
        .split(' ')[1]
        .substring(0, 5); // Extract time in HH:mm format

    return Weather(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      sunrise: sunrise,
      sunset: sunset,
      tempMax: json['main']['temp_max'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
    );
  }
}