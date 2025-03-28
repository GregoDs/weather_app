//Handle state Mnagement logic

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_now/core/local/cache_helper.dart';
import 'package:weather_now/home/cubit/weather_state.dart';
import 'package:weather_now/home/repository/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherRepository weatherRepository = WeatherRepository();
  WeatherCubit() : super(WeatherInitial());

  Future<void> fetchWeather(String city) async {
    try {
      emit(WeatherLoading());
      print("Emitting state: WeatherLoading");

      // Fetch weather data from the repository
      final weather = await weatherRepository.getWeather(city);

      // Extract the description from the weather object
      final description = weather.description;

      // Get the greeting and weather image
      final greeting = _getGreeting();
      final weatherImage = getWeatherImage(description);

      // Emit the WeatherLoaded state with all the required data
      emit(WeatherLoaded(weather, greeting, weatherImage));

      // Save the city to shared preferences
      await CacheHelper.saveLastCity(city);
      print("City saved in WeatherCubit: $city");
      print("Emitting state: WeatherLoaded with weather: $weather");
    } catch (e) {
      emit(WeatherError(e.toString()));
      print("Emitting state: WeatherError with error: $e");
    }
  }

  Future<void> loadLastCity() async {
    final lastCity = await CacheHelper.getLastCity();
    if (lastCity != null && lastCity.isNotEmpty) {
      fetchWeather(lastCity);
    }
  }

  Future<void> saveLastCity(String city) async {
    await CacheHelper.saveLastCity(city);
  }

  //Determine greetings
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  // Getting weather
  String getWeatherImage(String description) {
    description =
        description.toLowerCase(); // Normalize the description to lowercase
    if (description.contains('clear sky')) {
      return 'assets/images/6.png';
    } else if (description.contains('cloud')) {
      return 'assets/images/8.png';
    } else if (description.contains('light rain')) {
      return 'assets/images/2.png';
    } else if (description.contains('drizzle')) {
      return 'assets/images/2.png';
    }
    else if (description.contains('rain')) {
      return 'assets/images/3.png';
    } else if (description.contains('thunderstorm')) {
      return 'assets/images/1.png';
    } else if (description.contains('snow')) {
      return 'assets/images/4.png';
    } else if (description.contains('mist') || description.contains('fog')) {
      return 'assets/images/5.png';
    } else {
      return 'assets/images/5.png'; // Default image for unknown weather
    }
  }
}
