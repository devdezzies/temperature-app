import 'package:flutter/material.dart';
import 'package:temperature/constants/colors.dart';

class AdditionalInfo extends StatelessWidget {
  final String typeCard, value; 
  final IconData iconSymbol;

  const AdditionalInfo({
    super.key,
    required this.typeCard,
    required this.value,
    required this.iconSymbol
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 10, right: 10, top: 10, bottom: 10),
      padding:
          const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding:
                  const EdgeInsets.only(bottom: 5),
              child: Icon(
                iconSymbol,
                size: 40,
                color: WeatherColor.sunny,
              )),
          Text(
            value,
            style: const TextStyle(
                color: WeatherColor.sunny,
                fontWeight: FontWeight.w700,
                fontSize: 20),
          ),
          Text(
            typeCard,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: WeatherColor.sunny),
          )
        ],
      ),
    );
  }
}

