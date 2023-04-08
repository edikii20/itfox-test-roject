import 'package:itfox_test_project/src/domain/api/geolocator_api.dart';
import 'package:itfox_test_project/src/domain/db/hive_db/box_manager.dart';
import 'package:itfox_test_project/src/domain/entities/city_weather.dart';

import '../api/open_weather_map_api.dart';

class WeatherRepository {
  WeatherRepository();

  Future<List<CityWeather>> getSavedWeathers() async {
    final weathersBox = await BoxManager.instance.openWeathersBox();
    List<CityWeather> savedWeathers = [];
    for (final city in weathersBox.values) {
      final weather =
          await OpenWeatherMapApi.instance.getWeatherByCity(city: city);
      if (weather != null) {
        savedWeathers.add(weather);
      }
    }
    await BoxManager.instance.closeBox(weathersBox);
    return savedWeathers;
  }

  Future<CityWeather?> getCityWeather({required String city}) async {
    final weather =
        await OpenWeatherMapApi.instance.getWeatherByCity(city: city);
    if (weather != null) {
      await _saveWeatherCity(city: city);
    }

    return weather;
  }

  Future<CityWeather?> getCurrentGeopointWeather() async {
    final geopoint = await GeolocatorApi.instance.getCurrentGeolacation();
    if (geopoint != null) {
      return await OpenWeatherMapApi.instance.getWeatherByGeopoint(
        lat: geopoint.lat,
        lon: geopoint.lon,
      );
    }

    return null;
  }

  Future<void> _saveWeatherCity({required String city}) async {
    final weathersBox = await BoxManager.instance.openWeathersBox();
    await weathersBox.add(city);
    await BoxManager.instance.closeBox(weathersBox);
  }
}
