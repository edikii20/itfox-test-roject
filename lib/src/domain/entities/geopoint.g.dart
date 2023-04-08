// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geopoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Geopoint _$GeopointFromJson(Map<String, dynamic> json) => Geopoint(
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
    );

Map<String, dynamic> _$GeopointToJson(Geopoint instance) => <String, dynamic>{
      'name': instance.name,
      'lat': instance.lat,
      'lon': instance.lon,
    };
