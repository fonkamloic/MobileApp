import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_xcode/data/model/weather_respository.dart';
import 'package:flutter_xcode/data/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository);
  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is GetWeather) {
      try {
        final weather =
            await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield WeatherError('Couldn\'t fetch weather. Is the device online?');
      }
    } else if (event is GetDetailedWeather){
      try{
        final weather = await weatherRepository.fetchDetailedWeather(event.cityName);
        yield WeatherLoaded(weather);

      } on NetworkError {
        yield WeatherError('Couldn\'t fetch detailed weather. Is the device online?');
      }
    }
  }
}
