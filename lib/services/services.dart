import 'package:weather/weather.dart';

class WeatherService {
  final WeatherFactory _weatherFactory =
      WeatherFactory('96e28e4758e3cba6c16c49609a8acf0a');

  Future<Weather> getCurrentWeather(String cityName) async {
    return await _weatherFactory.currentWeatherByCityName(cityName);
  }

  Future<List<Weather>> getWeatherForecast(String cityName) async {
    return await _weatherFactory.fiveDayForecastByCityName(cityName);
  }
}
