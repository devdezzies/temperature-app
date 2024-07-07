import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temperature/data/repository/weather_repository.dart';

import 'package:temperature/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<WeatherFetched>(_weatherFetched);
  }

  void _weatherFetched(WeatherFetched event, Emitter<WeatherState> emit) async {
    emit(FetchLoading());
    try {
      final data = await weatherRepository.getCurrentWeather();
      emit(FetchSuccess(weatherModel: data));
    } catch (e) {
      emit(FetchFail('an error occurred'));
      throw e.toString();
    }
  }
}
