import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:temperature/constants/colors.dart';

import '../components/hourly_forecast_item.dart';
import '../components/info_card.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      final result = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=bogor&APPID=0709f265f4a711780fc3d02683917c2a"));

      final data = jsonDecode(result.body);

      if (data['cod'] != "200") {
        throw 'An unexpected error occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  void _refreshScreen() {
    setState(() {
      getCurrentWeather();
    });
  }

  IconData chooseWeatherIcon(String current) {
    switch (current) {
      case 'Rain':
        return Icons.umbrella_outlined;
      case 'Clear':
        return Icons.sunny;
      case 'Clouds':
        return Icons.cloud;
      default:
        return Icons.replay_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: WeatherColor.sunny,
        title: const Text(
          "Bogor",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Container(
              margin: const EdgeInsets.only(right: 10),
              child: TextButton(
                onPressed: _refreshScreen,
                style: const ButtonStyle(
                    //overlayColor: WidgetStateColor.transparent,
                    shape: WidgetStatePropertyAll(CircleBorder()),
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.transparent)),
                child: const Icon(
                  Icons.refresh_rounded,
                  color: Colors.black,
                  size: 30,
                ),
              ))
        ],
      ),
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ColoredBox(
              color: WeatherColor.sunny,
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: WeatherColor.sunny,
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data!;
          final double temp = data['list'][0]['main']['temp'] - 273.1;
          final String currentSkyDesc =
              data['list'][0]['weather'][0]['description'];

          final currentWindSpeed = data['list'][0]['wind']['speed'];
          final currentHumidity = data['list'][0]['main']['humidity'];
          final currentVisibility = data['list'][0]['visibility'];

          return ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                decoration: const BoxDecoration(color: WeatherColor.sunny),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      padding: const EdgeInsets.only(
                          top: 2, bottom: 2, left: 15, right: 15),
                      child: Text(
                        data['list'][0]['dt_txt'].toString().split(" ").first,
                        style: const TextStyle(
                            color: WeatherColor.sunny,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          currentSkyDesc,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        )),
                    Container(
                        alignment: Alignment.topCenter,
                        decoration: const BoxDecoration(),
                        child: Text(
                          temp.toStringAsPrecision(2),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 200,
                              height: 1),
                        )),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Daily Summary",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              )),
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                "Now it feels like +31. It feels hot because of the direct sun. Today, the temperature is felt in range from +31 to 27.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              )),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 0),
                            child: Card(
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  AdditionalInfo(
                                    typeCard: "Wind",
                                    value: "$currentWindSpeed",
                                    iconSymbol: Icons.wind_power,
                                  ),
                                  AdditionalInfo(
                                    typeCard: "Humidity",
                                    value: "$currentHumidity%",
                                    iconSymbol: Icons.water_drop_outlined,
                                  ),
                                  AdditionalInfo(
                                    typeCard: "Visibility",
                                    value: "$currentVisibility",
                                    iconSymbol: Icons.visibility,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: SizedBox(
                              height: 120,
                              child: ListView.builder(
                                  itemCount: 1, // number of container that will get fetched on demand
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, idx) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                            children: List.generate(
                                                data['cnt'] - 1, (int idx) {
                                          return HourlyForecastItem(
                                              hour: data['list'][idx]['dt_txt']
                                                  .toString()
                                                  .split(" ")
                                                  .last,
                                              temperature: data['list'][idx]
                                                      ['main']['temp']
                                                  .toString(),
                                              icon: chooseWeatherIcon(
                                                  data['list'][idx]['weather']
                                                          [0]['main']
                                                      .toString()));
                                        })),
                                      )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
