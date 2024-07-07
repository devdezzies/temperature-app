part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class FetchSuccess extends WeatherState {
  final WeatherModel weatherModel;

  FetchSuccess({required this.weatherModel}); 
}

final class FetchFail extends WeatherState{
  final String message;

  FetchFail(this.message); 
}

final class FetchLoading extends WeatherState {}
