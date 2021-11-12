import 'package:flutter_clean_architecture/data/models/weather_dto.dart';
import 'package:flutter_clean_architecture/data/repository/weather_repo_impl.dart';
import 'package:flutter_clean_architecture/domain/models/weather_model.dart';

class GetWeatherUseCase {
  Future<WeatherModel> getWeather(String city) async {
    return await WeatherRepoImpl().getWeather(city);
  }
}
