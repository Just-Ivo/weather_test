import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherContainer extends StatelessWidget {
  final Weather weather;

  const WeatherContainer({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    // switch (weather.weatherDescription) {
    //   case 'clear sky':
    //     Image.asset('lib/icons/01d.png');
    //   case 'few clouds':
    //     Image.asset('lib/icons/02d.png');
    //   case 'scattered clouds':
    //     Image.asset('lib/icons/03d.png');
    //   case 'broken clouds':
    //     Image.asset('lib/icons/04d.png');
    //   case 'shower rain':
    //     Image.asset('lib/icons/09d.png');
    //   case 'rain':
    //     Image.asset('lib/icons/10d.png');
    //   case 'thunderstorm':
    //     Image.asset('lib/icons/11d.png');
    //   case 'snow':
    //     Image.asset('lib/icons/13d.png');
    //   case 'mist':
    //     Image.asset('lib/icons/50d.png');
    // }
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
            if (weather.weatherDescription == 'clear sky') Image.asset('lib/icons/01d.png', scale: 0.75,),
            if (weather.weatherDescription == 'few clouds') Image.asset('lib/icons/02d.png', scale: 0.75),
            if (weather.weatherDescription == 'scattered clouds') Image.asset('lib/icons/03d.png', scale: 0.75),
            if (weather.weatherDescription == 'broken clouds') Image.asset('lib/icons/04d.png', scale: 0.75),
            if (weather.weatherDescription == 'shattered rain') Image.asset('lib/icons/09d.png', scale: 0.75),
            if (weather.weatherDescription == 'rain') Image.asset('lib/icons/10d.png', scale: 0.75),
            if (weather.weatherDescription == 'thunderstorm') Image.asset('lib/icons/11d.png', scale: 0.75),
            if (weather.weatherDescription == 'snow') Image.asset('lib/icons/13d.png', scale: 0.75),
            if (weather.weatherDescription == 'mist') Image.asset('lib/icons/50d.png', scale: 0.75),


            // const Icon(
            //   Icons.wb_sunny,
            //   color: Colors.orange,
            //   size: 100,
            // ),
            const SizedBox(
              width: 15,
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
