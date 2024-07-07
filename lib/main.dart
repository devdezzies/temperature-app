import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temperature/bloc/weather_bloc.dart';
import 'package:temperature/data/data_provider/weather_data_provider.dart';
import 'package:temperature/data/repository/weather_repository.dart';
import 'package:temperature/presentation/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(weatherDataProvider: WeatherDataProvider()),
      child: BlocProvider(
        create: (context) => WeatherBloc(context.read<WeatherRepository>()),
        child: MaterialApp(
            theme: ThemeData(fontFamily: 'Quicksand', useMaterial3: true),
            debugShowCheckedModeBanner: false,
            home: const Home()),
      ),
    );
  }
}
