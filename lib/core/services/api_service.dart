import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_now/core/services/error_handler.dart';

class ApiService {
  //instantiate Dio to be used within the api_service class to make http requests
  final Dio _dio = Dio();

  // fetch Weather using City Name
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      final String apiKey = dotenv.env['API_KEY']!;
      final String baseUrl = dotenv.env['BASE_URL']!;
      final String url = "$baseUrl/weather?q=$city&appid=$apiKey&units=metric";
      final response = await _dio.get(url);
      print("Response Data: $response");
      return response.data;
    } catch (error) {
      //handle errors using error_handler.dart
      throw ApiErrorHandler.handle(error);
    }
  }
}
