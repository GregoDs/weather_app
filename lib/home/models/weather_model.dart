import 'package:meta/meta.dart';

@immutable
sealed class Weather {
  // Define and initialize the players
  final String city;
  final double temperature;
  final String description;
  final String icon;

  // Make constructor showing what is required
  const Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  // Star Player...create an object from the JSON response
  factory Weather.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}

// Make the Weather subclass
class WeatherData extends Weather {
  const WeatherData({
    required String city,
    required double temperature,
    required String description,
    required String icon,
  }) : super(
          city: city,
          temperature: temperature,
          description: description,
          icon: icon,
        );
}