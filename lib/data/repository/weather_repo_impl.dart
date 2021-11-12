import 'package:flutter_clean_architecture/common/constants.dart';
import 'package:flutter_clean_architecture/data/models/weather_dto.dart';
import 'package:flutter_clean_architecture/domain/models/weather_model.dart';
import 'package:flutter_clean_architecture/domain/repository/weather_repo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherRepoImpl implements WeatherRepo {
  Future<WeatherModel> getWeather(String city) async {
    final result = await http.Client().get(Uri.parse(
        "${BASE_URL}weather?q=$city&APPID=43ea6baaad7663dc17637e22ee6f78f2"));

    if (result.statusCode != 200) throw Exception();

    return parsedJson(result.body);
  }

  WeatherModel parsedJson(final response) {
    final jsonDecoded = json.decode(response);

    final jsonWeather = jsonDecoded["main"];

    return WeatherModel.fromJson(jsonWeather);
  }
}

WeatherModel convertToWeather(WeatherModel weatherDto) {
  return WeatherModel(
      temp: weatherDto.temp,
      humidity: weatherDto.humidity,
      tempMin: weatherDto.tempMin,
      tempMax: weatherDto.tempMax);
}
