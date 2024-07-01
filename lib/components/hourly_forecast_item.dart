import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String hour, temperature;
  final IconData icon;

  const HourlyForecastItem({super.key, required this.hour, required this.temperature, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border(
              top: BorderSide(width: 2),
              left: BorderSide(width: 2),
              right: BorderSide(width: 2),
              bottom: BorderSide(width: 2))),
      padding: const EdgeInsets.only(right: 20, left: 20, top: 15, bottom: 15),
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            hour,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
          Icon(
            icon,
            size: 20,
          ),
          Text(
            temperature,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          )
        ],
      ),
    );
  }
}