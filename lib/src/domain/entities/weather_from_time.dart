import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'package:itfox_test_project/src/domain/entities/temperature.dart';
import 'package:itfox_test_project/src/domain/entities/weather.dart';

part 'weather_from_time.g.dart';

@JsonSerializable()
class WeatherFromTime {
  @JsonKey(name: 'main')
  final Temperature temperature;
  final Weather weather;
  @JsonKey(name: 'dt_txt')
  final DateTime date;
  WeatherFromTime({
    required this.temperature,
    required this.weather,
    required this.date,
  });

  WeatherFromTime copyWith({
    Temperature? temperature,
    Weather? weather,
    DateTime? date,
  }) {
    return WeatherFromTime(
      temperature: temperature ?? this.temperature,
      weather: weather ?? this.weather,
      date: date ?? this.date,
    );
  }

  String toJson() => json.encode(_$WeatherFromTimeToJson(this));

  factory WeatherFromTime.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromTimeFromJson(json);

  @override
  String toString() =>
      'WeatherFromTime(temperature: $temperature, weather: $weather, date: $date)';

  @override
  bool operator ==(covariant WeatherFromTime other) {
    if (identical(this, other)) return true;

    return other.temperature == temperature &&
        other.weather == weather &&
        other.date == date;
  }

  @override
  int get hashCode => temperature.hashCode ^ weather.hashCode ^ date.hashCode;
}
