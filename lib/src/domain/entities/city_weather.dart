import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:itfox_test_project/src/domain/entities/city.dart';
import 'package:itfox_test_project/src/domain/entities/weather_from_time.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_weather.g.dart';

@JsonSerializable()
class CityWeather {
  @JsonKey(name: 'list')
  final List<WeatherFromTime> weather;
  final City city;
  CityWeather({
    required this.weather,
    required this.city,
  });

  CityWeather copyWith({
    List<WeatherFromTime>? weather,
    City? city,
  }) {
    return CityWeather(
      weather: weather ?? this.weather,
      city: city ?? this.city,
    );
  }

  String toJson() => json.encode(_$CityWeatherToJson(this));

  factory CityWeather.fromJson(Map<String, dynamic> json) =>
      _$CityWeatherFromJson(json);

  @override
  String toString() => 'CityWeather(weather: $weather, city: $city)';

  @override
  bool operator ==(covariant CityWeather other) {
    if (identical(this, other)) return true;

    return listEquals(other.weather, weather) && other.city == city;
  }

  @override
  int get hashCode => weather.hashCode ^ city.hashCode;
}
