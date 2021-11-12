
import 'package:flutter_clean_architecture/domain/models/weather_model.dart';

abstract class WeatherRepo {
  Future<WeatherModel> getWeather(String city);
}
