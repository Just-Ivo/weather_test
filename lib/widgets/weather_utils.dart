import 'package:weather/weather.dart';
import 'package:weather_test/services/services.dart';

void validateInput(String value) {
  if (value.trim().isEmpty) {
    throw Exception('Please enter a location');
  }
}

Future<void> fetchWeatherData(WeatherService weatherService, String cityName) async {
  try {
    await weatherService.getCurrentWeather(cityName);
    await weatherService.getWeatherForecast(cityName);
  } catch (e) {
    throw Exception('City not found');
  }
}

Future<List<Weather>> fetchMultipleCitiesWeather(WeatherService weatherService, List<String> cities) async {
  List<Future<Weather>> weatherFutures = cities.map((city) => weatherService.getCurrentWeather(city)).toList();
  return await Future.wait(weatherFutures);
}
