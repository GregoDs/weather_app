// Here we will handle the business logic

import 'package:weather_now/core/services/api_service.dart';
import 'package:weather_now/home/models/weather_model.dart';

class WeatherRepository {
  final ApiService _apiService = ApiService();

  //make the star player
  Future<Weather> getWeather(String city) async {
    final data = await _apiService.fetchWeather(city);
    return Weather.fromJson(data);
  }
}
