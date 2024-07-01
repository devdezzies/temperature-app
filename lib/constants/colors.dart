import 'package:flutter/material.dart';

class WeatherColor {
  static const sunny = Color.fromARGB(255, 255, 225, 66);
  static const cloudy = Color.fromARGB(255, 66, 198, 255);
  static const rain = Color.fromARGB(255, 255, 100, 212);


  static Color getColors(String curr) {
    switch (curr) {
      case "Sunny":
        return sunny;
      case "Clouds":
        return cloudy; 
      case "Rain":
        return rain; 
      default: 
        return Colors.white;
    }
  }
}