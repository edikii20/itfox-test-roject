import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'temperature.g.dart';

@JsonSerializable()
class Temperature {
  final double temp;
  @JsonKey(name: 'temp_min')
  final double tempMin;
  @JsonKey(name: 'temp_max')
  final double tempMax;
  Temperature({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
  });

  Temperature copyWith({
    double? temp,
    double? tempMin,
    double? tempMax,
  }) {
    return Temperature(
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
    );
  }

  String toJson() => json.encode(_$TemperatureToJson(this));

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);

  @override
  String toString() =>
      'Temperature(temp: $temp, tempMin: $tempMin, tempMax: $tempMax)';

  @override
  bool operator ==(covariant Temperature other) {
    if (identical(this, other)) return true;

    return other.temp == temp &&
        other.tempMin == tempMin &&
        other.tempMax == tempMax;
  }

  @override
  int get hashCode => temp.hashCode ^ tempMin.hashCode ^ tempMax.hashCode;
}
