import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart'; // Import the intl package for date formatting

class ForecastList extends StatelessWidget {
  final List<Weather> forecast;

  const ForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 162,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        itemBuilder: (context, index) {
          // Convert the date to a weekday name
          String dayName = '';
          if (forecast[index].date != null) {
            dayName = DateFormat('h:mm a').format(forecast[index].date!);
          }

          // Determine the appropriate icon asset based on the weather condition code
          String weatherIcon;
          switch (forecast[index].weatherConditionCode) {
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
                  // width: 35,
                  // height: 35,
                  scale: 0.75,
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
