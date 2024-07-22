// import 'package:weather/weather.dart';

// class WeatherService {
//   final WeatherFactory _weatherFactory =
//       WeatherFactory('96e28e4758e3cba6c16c49609a8acf0a');

//   Future<Weather> getCurrentWeather(String cityName) async {
//     return await _weatherFactory.currentWeatherByCityName(cityName);
//   }

//   Future<List<Weather>> getWeatherForecast(String cityName) async {
//     return await _weatherFactory.fiveDayForecastByCityName(cityName);
//   }
// }

import 'package:weather/weather.dart';

class WeatherService {
  final WeatherFactory _weatherFactory =
      WeatherFactory('96e28e4758e3cba6c16c49609a8acf0a');

  Future<Weather> getCurrentWeather(String cityName) async {
    print('Fetching current weather for $cityName');
    Weather weather = await _weatherFactory.currentWeatherByCityName(cityName);
    print('Fetched current weather: ${weather.temperature}');
    return weather;
  }

  Future<List<Weather>> getWeatherForecast(String cityName) async {
    print('Fetching weather forecast for $cityName');
    List<Weather> forecast = await _weatherFactory.fiveDayForecastByCityName(cityName);
    print('Fetched forecast: ${forecast.length} items');
    return forecast;
  }
}

