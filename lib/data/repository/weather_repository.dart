import 'dart:convert';

import 'package:temperature/data/data_provider/weather_data_provider.dart';
import 'package:temperature/models/weather_model.dart';

class WeatherRepository {
  final WeatherDataProvider _weatherDataProvider;
  WeatherRepository({required WeatherDataProvider weatherDataProvider})
      : _weatherDataProvider = weatherDataProvider;

  Future<WeatherModel> getCurrentWeather() async {
    try {
      String cityName = 'Bogor';
      final weatherData =
          await _weatherDataProvider.getCurrentWeather(cityName);

      final data = jsonDecode(weatherData);

      if (data['cod'] == 200) {
        throw 'an unexpected error';
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
