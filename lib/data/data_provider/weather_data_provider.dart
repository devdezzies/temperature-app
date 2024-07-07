import 'package:http/http.dart' as http;

class WeatherDataProvider {
  Future<String> getCurrentWeather(String cityName) async {
    try {
      final result = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=bogor&APPID=0709f265f4a711780fc3d02683917c2a"));
      return result.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
