import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class ForecastList extends StatelessWidget {
  final List<Weather> forecast;

  const ForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          // Convert the date to a weekday name
          String dayName = '';
          if (forecast[index].date != null) {
            dayName = DateFormat('h:mm a').format(forecast[index].date!);
          }

          return Container(
            width: 100,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 3.5,
              ),
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(colors: [
                Color.fromARGB(255, 2, 76, 67),
                Color.fromARGB(255, 26, 149, 7),
                Color.fromARGB(255, 4, 69, 61),
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${forecast[index].temperature?.celsius?.toStringAsFixed(0)} °C',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const Icon(
                  Icons.wb_sunny,
                  size: 35,
                  color: Colors.orange,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
