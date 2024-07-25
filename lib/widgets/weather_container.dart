import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherContainer extends StatelessWidget {
  final Weather weather;

  const WeatherContainer({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    String weatherIcon;
          switch (weather.weatherConditionCode) {
            case 200:
            case 201:
            case 202:
            case 210:
            case 211:
            case 212:
            case 221:
            case 230:
            case 231:
            case 232:
              weatherIcon = 'lib/icons/11d.png';
              break;
            case 300:
            case 301:
            case 302:
            case 310:
            case 311:
            case 312:
            case 313:
            case 314:
            case 321:
              weatherIcon = 'lib/icons/09d.png';
              break;
            case 500:
            case 501:
            case 502:
            case 503:
            case 504:
              weatherIcon = 'lib/icons/10d.png';
              break;
            case 511:
              weatherIcon = 'lib/icons/13d.png';
              break;
            case 520:
            case 521:
            case 522:
            case 531:
              weatherIcon = 'lib/icons/09d.png';
              break;
            case 600:
            case 601:
            case 602:
            case 611:
            case 612:
            case 613:
            case 615:
            case 616:
            case 620:
            case 621:
            case 622:
              weatherIcon = 'lib/icons/13d.png';
              break;
            case 701:
            case 711:
            case 721:
            case 731:
            case 741:
            case 751:
            case 761:
            case 762:
            case 771:
            case 781:
              weatherIcon = 'lib/icons/50d.png';
              break;
            case 800:
              weatherIcon = 'lib/icons/01d.png';
              break;
            case 801:
              weatherIcon = 'lib/icons/02d.png';
              break;
            case 802:
              weatherIcon = 'lib/icons/03d.png';
              break;
            case 803:
            case 804:
              weatherIcon = 'lib/icons/04d.png';
              break;
            default:
              weatherIcon = 'lib/icons/01d.png'; // Fallback icon for unknown descriptions
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
            Image.asset(
              weatherIcon,
              // width: 150,
              // height: 150,
              scale: 0.75,
            ),
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
