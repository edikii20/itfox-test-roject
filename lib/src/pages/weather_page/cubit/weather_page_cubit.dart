import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:itfox_test_project/src/domain/entities/city_weather.dart';
import 'package:itfox_test_project/src/domain/repositories/weather_repository.dart';

part 'weather_page_state.dart';

class WeatherPageCubit extends Cubit<WeatherPageState> {
  final WeatherRepository _weatherRepository;
  WeatherPageCubit({
    required WeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(WeatherPageState(
          weathers: [],
          addNewWeatherPageStatus: WeatherPagesStatus.loading,
          currentGeopointPageStatus: WeatherPagesStatus.loading,
          allPagesStatus: WeatherPagesStatus.loading,
        )) {
    _init();
  }

  Future<void> _init() async {
    List<CityWeather?> weathers = [];
    final currentLocationWeather =
        await _weatherRepository.getCurrentGeopointWeather();
    weathers.add(currentLocationWeather);
    final savedWeathers = (await _weatherRepository.getSavedWeathers());
    weathers.addAll(savedWeathers);
    emit(state.copyWith(
      weathers: weathers,
      currentGeopointPageStatus: currentLocationWeather == null
          ? WeatherPagesStatus.failure
          : WeatherPagesStatus.completed,
      addNewWeatherPageStatus: WeatherPagesStatus.completed,
      allPagesStatus: WeatherPagesStatus.completed,
    ));
    FlutterNativeSplash.remove();
  }

  Future<void> onTapAddNewWeather({required String city}) async {
    if (city.isEmpty) {
      return emit(
        state.copyWith(
          addNewWeatherPageStatus: WeatherPagesStatus.failure,
        ),
      );
    }
    final weathers = state.weathers;
    emit(state.copyWith(
      addNewWeatherPageStatus: WeatherPagesStatus.loading,
      allPagesStatus: WeatherPagesStatus.loading,
    ));
    final newWeather = await _weatherRepository.getCityWeather(city: city);
    if (newWeather == null) {
      return emit(state.copyWith(
        allPagesStatus: WeatherPagesStatus.completed,
        addNewWeatherPageStatus: WeatherPagesStatus.failure,
      ));
    }

    weathers.add(newWeather);
    emit(state.copyWith(
      weathers: weathers,
      allPagesStatus: WeatherPagesStatus.completed,
      addNewWeatherPageStatus: WeatherPagesStatus.completed,
    ));
  }

  Future<void> onTapReloadCurrentGeopointWeather() async {
    emit(state.copyWith(
      currentGeopointPageStatus: WeatherPagesStatus.loading,
      allPagesStatus: WeatherPagesStatus.loading,
    ));
    final currentLocationWeather =
        await _weatherRepository.getCurrentGeopointWeather();
    final weathers = state.weathers;
    weathers[0] = currentLocationWeather;

    emit(state.copyWith(
      weathers: weathers,
      currentGeopointPageStatus: currentLocationWeather == null
          ? WeatherPagesStatus.failure
          : WeatherPagesStatus.completed,
      allPagesStatus: WeatherPagesStatus.completed,
    ));
  }
}
