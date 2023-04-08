// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
      temp: (json['temp'] as num).toDouble(),
      tempMin: (json['temp_min'] as num).toDouble(),
      tempMax: (json['temp_max'] as num).toDouble(),
    );

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
    };
