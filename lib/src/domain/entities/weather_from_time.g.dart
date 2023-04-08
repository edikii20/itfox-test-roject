// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_from_time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherFromTime _$WeatherFromTimeFromJson(Map<String, dynamic> json) =>
    WeatherFromTime(
      temperature: Temperature.fromJson(json['main'] as Map<String, dynamic>),
      weather: Weather.fromJson(json['weather'][0] as Map<String, dynamic>),
      date: DateTime.parse(json['dt_txt'] as String),
    );

Map<String, dynamic> _$WeatherFromTimeToJson(WeatherFromTime instance) =>
    <String, dynamic>{
      'main': instance.temperature,
      'weather': instance.weather,
      'dt_txt': instance.date.toIso8601String(),
    };
