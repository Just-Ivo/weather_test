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
    return 
    // Container(
    //   padding: const EdgeInsets.all(16),
    //   margin: const EdgeInsets.all(16),
    //   decoration: BoxDecoration(
    //     color: Colors.blueAccent,
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         'Min Temp: ${weather.tempMin?.celsius?.toStringAsFixed(1)} °C',
    //         style: const TextStyle(color: Colors.white),
    //       ),
    //       Text(
    //         'Humidity: ${weather.humidity}%',
    //         style: const TextStyle(color: Colors.white),
    //       ),
    //       Text(
    //         'Wind Speed: ${weather.windSpeed} m/s',
    //         style: const TextStyle(color: Colors.white),
    //       ),
    //     ],
    //   ),
    // );
Container(
          height: 225,
          width: 450,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 125,
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
                              value: '$weather.windSpeed'),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 125,
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
                              value:
                                  "${weather.tempMax}°C"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 125,
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
                              value:
                                  "${weather.tempMin}°C"),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 125,
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
                              value: "${weather.humidity}%"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 125,
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
                              value: "${weather.pressure}hPa"),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 125,
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
                              value: "${weather.latitude}m"),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          );

  }
}
