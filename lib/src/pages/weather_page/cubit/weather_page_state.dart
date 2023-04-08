part of 'weather_page_cubit.dart';

enum WeatherPagesStatus { completed, loading, failure }

class WeatherPageState {
  final List<CityWeather?> weathers;
  final WeatherPagesStatus currentGeopointPageStatus;
  final WeatherPagesStatus addNewWeatherPageStatus;
  final WeatherPagesStatus allPagesStatus;
  WeatherPageState({
    required this.weathers,
    required this.currentGeopointPageStatus,
    required this.addNewWeatherPageStatus,
    required this.allPagesStatus,
  });

  WeatherPageState copyWith({
    List<CityWeather?>? weathers,
    WeatherPagesStatus? currentGeopointPageStatus,
    WeatherPagesStatus? addNewWeatherPageStatus,
    WeatherPagesStatus? allPagesStatus,
  }) {
    return WeatherPageState(
      weathers: weathers ?? this.weathers,
      currentGeopointPageStatus:
          currentGeopointPageStatus ?? this.currentGeopointPageStatus,
      addNewWeatherPageStatus:
          addNewWeatherPageStatus ?? this.addNewWeatherPageStatus,
      allPagesStatus: allPagesStatus ?? this.allPagesStatus,
    );
  }

  @override
  bool operator ==(covariant WeatherPageState other) {
    if (identical(this, other)) return true;

    return listEquals(other.weathers, weathers) &&
        other.currentGeopointPageStatus == currentGeopointPageStatus &&
        other.addNewWeatherPageStatus == addNewWeatherPageStatus &&
        other.allPagesStatus == allPagesStatus;
  }

  @override
  int get hashCode {
    return weathers.hashCode ^
        currentGeopointPageStatus.hashCode ^
        addNewWeatherPageStatus.hashCode ^
        allPagesStatus.hashCode;
  }
}
