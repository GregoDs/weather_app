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
      final weather = await weatherRepository.getWeather(city);
      emit(WeatherLoaded(weather));
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
}
