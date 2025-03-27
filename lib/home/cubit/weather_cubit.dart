//Handle state Mnagement logic

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_now/home/cubit/weather_state.dart';
import 'package:weather_now/home/repository/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherRepository weatherRepository = WeatherRepository();
  WeatherCubit() : super(WeatherInitial());

  Future<void> fetchWeather(String city) async {
    try {
      emit(WeatherLoading());
      final weather = await weatherRepository.getWeather(city);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }
}
