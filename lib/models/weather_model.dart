class WeatherModel {
  // final double temp = data['list'][0]['main']['temp'] - 273.1;
  // final String currentSkyDesc = data['list'][0]['weather'][0]['description'];

  // final currentWindSpeed = data['list'][0]['wind']['speed'];
  // final currentHumidity = data['list'][0]['main']['humidity'];
  // final currentVisibility = data['list'][0]['visibility'];
  final double currentTemperature;
  final String currentSkyDesc;
  final double currentWindSpeed;
  final int currentHumidity;
  final int currentVisibility;

  WeatherModel(
      {required this.currentTemperature,
      required this.currentSkyDesc,
      required this.currentWindSpeed,
      required this.currentHumidity,
      required this.currentVisibility});

  

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currWeather = map['list'][0];

    return WeatherModel(
        currentTemperature: currWeather['main']['temp'],
        currentSkyDesc: currWeather['weather'][0]['description'],
        currentWindSpeed: currWeather['wind']['speed'],
        currentHumidity: currWeather['main']['humidity'],
        currentVisibility: currWeather['visibility']);
  }

}
