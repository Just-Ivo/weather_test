import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class ForecastList extends StatelessWidget {
  final List<Weather> forecast;

  const ForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          // Convert the date to a weekday name
          String dayName = '';
          if (forecast[index].date != null) {
            dayName = DateFormat('h:mm a').format(forecast[index].date!);
          }

          // Determine the appropriate icon asset based on the weather description
          String weatherIcon;
          switch (forecast[index].weatherDescription) {
            case 'clear sky':
              weatherIcon = 'lib/icons/01d.png';
              break;
            case 'few clouds':
              weatherIcon = 'lib/icons/02d.png';
              break;
            case 'scattered clouds':
              weatherIcon = 'lib/icons/03d.png';
              break;
            case 'broken clouds':
              weatherIcon = 'lib/icons/04d.png';
              break;
            case 'shattered rain':
              weatherIcon = 'lib/icons/09d.png';
              break;
            case 'rain':
              weatherIcon = 'lib/icons/10d.png';
              break;
            case 'thunderstorm':
              weatherIcon = 'lib/icons/11d.png';
              break;
            case 'snow':
              weatherIcon = 'lib/icons/13d.png';
              break;
            case 'mist':
              weatherIcon = 'lib/icons/50d.png';
              break;
            default:
              weatherIcon = 'lib/icons/unknown.png'; // Fallback icon for unknown descriptions
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
                Image.asset(
                  weatherIcon,
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
