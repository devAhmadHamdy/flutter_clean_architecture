import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/data/models/weather_dto.dart';
import 'package:flutter_clean_architecture/data/repository/weather_repo_impl.dart';
import 'package:flutter_clean_architecture/domain/models/weather_model.dart';
import 'package:flutter_clean_architecture/domain/use_cases/get_weather_use_case.dart';

class WeatherEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final _city;

  FetchWeather(this._city);

  @override
  // TODO: implement props
  List<Object> get props => [_city];
}

class ResetWeather extends WeatherEvent {}

class WeatherState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class WeatherIsNotSearched extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final _weather;

  WeatherIsLoaded(this._weather);

  WeatherModel get getWeather => _weather;

  @override
  // TODO: implement props
  List<Object> get props => [_weather];
}

class WeatherIsNotLoaded extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  GetWeatherUseCase weatherUseCase;

  WeatherBloc(this.weatherUseCase):super(WeatherState());

  @override
  WeatherState get state => WeatherIsNotSearched();


  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchWeather) {
      yield WeatherIsLoading();

      try {
        WeatherModel weather = await weatherUseCase.getWeather(event._city);

        yield WeatherIsLoaded(convertToWeather(weather));
      } catch (_) {
        print(_);
        yield WeatherIsNotLoaded();
      }
    } else if (event is ResetWeather) {
      yield WeatherIsNotSearched();
    }
  }
}
