import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_now/core/services/error_handler.dart';

class ApiService {
  // Instantiate Dio to be used within the ApiService class to make HTTP requests
  final Dio _dio = Dio();

  // Fetch weather using city name
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      // Use dotenv for API key and base URL if available
      //final String apiKey = dotenv.env['API_KEY']!;
      final String apiKey = "b773f63d8f1a3991af27b56808a37e4e"; // Hardcoded API key for now
      //final String baseUrl = dotenv.env['BASE_URL']!;
      final String baseUrl = "https://api.openweathermap.org/data/2.5";

      // Construct the URL
      final String url = "$baseUrl/weather?q=$city&appid=$apiKey&units=metric";

      // Log the URL being called
      print("Calling API: $url");

      // Make the GET request
      final response = await _dio.get(url);

      // Log the response data
      print("API Response: ${response.data}");

      // Return the response data
      return response.data;
    } catch (error) {
      // Log the error
      print("API Error: $error");

      // Handle errors using error_handler.dart
      throw ApiErrorHandler.handle(error);
    }
  }
}