import 'package:meta/meta.dart';
import 'package:weather_now/home/models/weather_model.dart';

@immutable
sealed class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final String greeting;
  final String weatherImage;
  WeatherLoaded(this.weather, this.greeting, this.weatherImage);
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}
