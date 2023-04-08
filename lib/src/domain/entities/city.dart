import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'city.g.dart';

@JsonSerializable()
class City {
  final String name;
  final String country;
  City({
    required this.name,
    required this.country,
  });

  City copyWith({
    String? name,
    String? country,
  }) {
    return City(
      name: name ?? this.name,
      country: country ?? this.country,
    );
  }

  String toJson() => json.encode(_$CityToJson(this));

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  @override
  String toString() => 'City(name: $name, country: $country)';

  @override
  bool operator ==(covariant City other) {
    if (identical(this, other)) return true;

    return other.name == name && other.country == country;
  }

  @override
  int get hashCode => name.hashCode ^ country.hashCode;
}
