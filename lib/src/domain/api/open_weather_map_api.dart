import 'package:dio/dio.dart';
import 'package:itfox_test_project/src/domain/entities/city_weather.dart';
import 'package:itfox_test_project/src/domain/entities/geopoint.dart';

class OpenWeatherMapApi {
  final _weatherApiUrl = 'http://api.openweathermap.org/data/2.5/forecast';
  final _geopointApiUrl = 'http://api.openweathermap.org/geo/1.0/direct';
  final _apiKey = '63807e1aa63543450a2e03e82aabee59';
  final _dio = Dio();
  static final instance = OpenWeatherMapApi._();

  OpenWeatherMapApi._();

  Future<CityWeather?> getWeatherByCity({required String city}) async {
    try {
      final geopoint = await _getCityGeopoint(city: city);
      if (geopoint != null) {
        return await getWeatherByGeopoint(
          lat: geopoint.lat,
          lon: geopoint.lon,
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
    return null;
  }

  Future<CityWeather?> getWeatherByGeopoint({
    required double lat,
    required double lon,
  }) async {
    try {
      final response = await _dio.get(
        _weatherApiUrl,
        queryParameters: {
          'appid': _apiKey,
          'cnt': 12,
          'units': 'metric',
          'lat': lat,
          'lon': lon,
        },
      );
      if ((response.data as Map<dynamic, dynamic>).isNotEmpty) {
        return CityWeather.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
    return null;
  }

  Future<Geopoint?> _getCityGeopoint({required String city}) async {
    try {
      final response = await _dio.get(
        _geopointApiUrl,
        queryParameters: {
          'q': city,
          'limit': 1,
          'appid': _apiKey,
        },
      );
      if ((response.data as List<dynamic>).isNotEmpty) {
        return Geopoint.fromJson(response.data[0]);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
    }
    return null;
  }
}
