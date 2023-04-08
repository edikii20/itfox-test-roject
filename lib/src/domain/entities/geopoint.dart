import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'geopoint.g.dart';

@JsonSerializable()
class Geopoint {
  final String name;
  final double lat;
  final double lon;
  Geopoint({
    required this.name,
    required this.lat,
    required this.lon,
  });

  @override
  String toString() => 'Geopoint(name: $name, lat: $lat, lon: $lon)';

  @override
  bool operator ==(covariant Geopoint other) {
    if (identical(this, other)) return true;

    return other.name == name && other.lat == lat && other.lon == lon;
  }

  @override
  int get hashCode => name.hashCode ^ lat.hashCode ^ lon.hashCode;

  String toJson() => json.encode(_$GeopointToJson(this));

  factory Geopoint.fromJson(Map<String, dynamic> json) =>
      _$GeopointFromJson(json);

  Geopoint copyWith({
    String? name,
    double? lat,
    double? lon,
  }) {
    return Geopoint(
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }
}
