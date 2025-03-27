import 'package:meta/meta.dart';

@immutable
class Weather {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final String sunrise;
  final String sunset;
  final double tempMax;
  final double tempMin;
  final String dateTime; // New property

  const Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.sunrise,
    required this.sunset,
    required this.tempMax,
    required this.tempMin,
    required this.dateTime, // Initialize the new property
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['name'] ?? 'Unknown City',
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunrise'] * 1000,
      ).toLocal().toString().split(' ')[1].substring(0, 5),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunset'] * 1000,
      ).toLocal().toString().split(' ')[1].substring(0, 5),
      tempMax: json['main']['temp_max'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      dateTime: DateTime.now().toLocal().toString().split('.')[0],
    );
  }
}
