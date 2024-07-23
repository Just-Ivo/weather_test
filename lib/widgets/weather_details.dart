import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_test/widgets/weather_info_card.dart';

class WeatherDetails extends StatelessWidget {
  final Weather weather;

  const WeatherDetails({
    super.key, 
    required this.weather
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
        maxHeight: 225,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 99, 6, 6).withOpacity(1),
            const Color.fromARGB(255, 52, 3, 0).withOpacity(1),
            const Color.fromARGB(255, 99, 6, 6).withOpacity(1),
          ],
        ),
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.wind_power,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        WeatherInfoCard(
                          title: "Wind",
                          value: weather.windSpeed?.toString() ?? '--',
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sunny,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        WeatherInfoCard(
                          title: "Max",
                          value: "${weather.tempMax?.celsius?.toStringAsFixed(1) ?? '--'}°C",
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.wind_power,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 5),
                        WeatherInfoCard(
                          title: "Min",
                          value: "${weather.tempMin?.celsius?.toStringAsFixed(1) ?? '--'}°C",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.water_drop,
                          color: Colors.amber,
                        ),
                        const SizedBox(height: 5),
                        WeatherInfoCard(
                          title: "Humidity",
                          value: "${weather.humidity ?? '--'}%",
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.air,
                          color: Colors.amber,
                        ),
                        const SizedBox(height: 5),
                        WeatherInfoCard(
                          title: "Pressure",
                          value: "${weather.pressure ?? '--'} hPa",
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.leaderboard,
                          color: Colors.amber,
                        ),
                        const SizedBox(height: 5),
                        WeatherInfoCard(
                          title: "Sea-Level",
                          value: "${weather.latitude ?? '--'} m",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
