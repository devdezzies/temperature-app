import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temperature/bloc/weather_bloc.dart';
import 'package:temperature/constants/colors.dart';
import '../widgets/info_card.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherFetched());
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
                onPressed: () {
                  context.read<WeatherBloc>().add(WeatherFetched());
                },
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
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is FetchFail) {
            return const SizedBox.shrink();
          }

          if (state is! FetchSuccess) {
            return const Center(child: CircularProgressIndicator(),);
          }

          final data = state.weatherModel;

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
                        data.currentHumidity.toString(),
                        style: const TextStyle(
                            color: WeatherColor.sunny,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          data.currentSkyDesc,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        )),
                    Container(
                        alignment: Alignment.topCenter,
                        decoration: const BoxDecoration(),
                        child: Text(
                          data.currentTemperature.toStringAsPrecision(2),
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
                                    value: data.currentWindSpeed.toString(),
                                    iconSymbol: Icons.wind_power,
                                  ),
                                  AdditionalInfo(
                                    typeCard: "Humidity",
                                    value: data.currentHumidity.toString(),
                                    iconSymbol: Icons.water_drop_outlined,
                                  ),
                                  AdditionalInfo(
                                    typeCard: "Visibility",
                                    value: data.currentVisibility.toString(),
                                    iconSymbol: Icons.visibility,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(vertical: 15),
                          //   child: SizedBox(
                          //     height: 120,
                          //     child: ListView.builder(
                          //         itemCount: 1, // number of container that will get fetched on demand
                          //         scrollDirection: Axis.horizontal,
                          //         itemBuilder: (context, idx) => Container(
                          //               margin: const EdgeInsets.symmetric(
                          //                   horizontal: 20),
                          //               child: Row(
                          //                   children: List.generate(
                          //                       data['cnt'] - 1, (int idx) {
                          //                 return HourlyForecastItem(
                          //                     hour: data['list'][idx]['dt_txt']
                          //                         .toString()
                          //                         .split(" ")
                          //                         .last,
                          //                     temperature: data['list'][idx]
                          //                             ['main']['temp']
                          //                         .toString(),
                          //                     icon: chooseWeatherIcon(
                          //                         data['list'][idx]['weather']
                          //                                 [0]['main']
                          //                             .toString()));
                          //               })),
                          //             )),
                          //   ),
                          // ),
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
