import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherContainer extends StatelessWidget {
  final Weather weather;

  const WeatherContainer({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    Image weatherDesc;
    switch (weather.weatherDescription) {
      case 'clear sky':
        weatherDesc = Image(image: AssetImage('assets/01d.png'));
      case 'few clouds':
        Image(image: AssetImage('assets/02d.png'));
      case 'scattered clouds':
        Image(image: AssetImage('assets/03d.png'));
      case 'broken clouds':
        Image(image: AssetImage('assets/04d.png'));
      case 'shower rain':
        Image(image: AssetImage('assets/09d.png'));
      case 'rain':
        Image(image: AssetImage('assets/10d.png'));
      case 'thunderstorm':
        Image(image: AssetImage('assets/11d.png'));
      case 'snow':
        Image(image: AssetImage('assets/13d.png'));
      case 'mist':
        Image(image: AssetImage('assets/50d.png'));
    }
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          '/',
        );
      },
      child: Container(
        height: 200,
        width: 350,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.5,
          ),
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(colors: [
            Color.fromARGB(144, 8, 86, 175),
            Color.fromARGB(255, 0, 150, 243),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 255, 242, 1).withOpacity(0.5),
              spreadRadius: 7.5,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wb_sunny,
              color: Colors.orange,
              size: 100,
            ),
            const SizedBox(
              width: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  weather.areaName ?? 'Unknown Location',
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${weather.temperature?.celsius?.toStringAsFixed(0) ?? '--'} °C',
                  style: const TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  weather.weatherDescription ?? '',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
