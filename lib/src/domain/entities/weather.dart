import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final int id;
  @JsonKey(name: 'main')
  final String name;
  Weather({
    required this.id,
    required this.name,
  });

  Weather copyWith({
    int? id,
    String? name,
  }) {
    return Weather(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  String toJson() => json.encode(_$WeatherToJson(this));

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  @override
  String toString() => 'Weather(id: $id, name: $name)';

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
