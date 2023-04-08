// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityWeather _$CityWeatherFromJson(Map<String, dynamic> json) => CityWeather(
      weather: (json['list'] as List<dynamic>)
          .map((e) => WeatherFromTime.fromJson(e as Map<String, dynamic>))
          .toList(),
      city: City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CityWeatherToJson(CityWeather instance) =>
    <String, dynamic>{
      'list': instance.weather,
      'city': instance.city,
    };
