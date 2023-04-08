part of '../weather_page.dart';

class _WeatherPageCityWeatherWidget extends StatefulWidget {
  const _WeatherPageCityWeatherWidget({
    Key? key,
    required CityWeather cityWeather,
  })  : _cityWeather = cityWeather,
        super(key: key);

  final CityWeather _cityWeather;

  @override
  State<_WeatherPageCityWeatherWidget> createState() =>
      _WeatherPageCityWeatherWidgetState();
}

class _WeatherPageCityWeatherWidgetState
    extends State<_WeatherPageCityWeatherWidget> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        _WeatherPageCityWeatherHeaderWidget(
          scrollController: _scrollController,
          city: widget._cityWeather.city.name,
          temp: widget._cityWeather.weather.first.temperature.temp.round(),
          tempMax:
              widget._cityWeather.weather.first.temperature.tempMax.round(),
          tempMin:
              widget._cityWeather.weather.first.temperature.tempMin.round(),
          weatherName: widget._cityWeather.weather.first.weather.name,
        ),
        _WeatherPageCityWeatherListWidget(
          weather: widget._cityWeather.weather,
        ),
      ],
    );
  }
}
