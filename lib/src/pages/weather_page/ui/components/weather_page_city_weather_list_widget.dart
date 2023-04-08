part of '../weather_page.dart';

class _WeatherPageCityWeatherListWidget extends StatelessWidget {
  const _WeatherPageCityWeatherListWidget({
    Key? key,
    required List<WeatherFromTime> weather,
  })  : _weather = weather,
        super(key: key);

  final List<WeatherFromTime> _weather;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: 20.h,
      ),
      sliver: SliverToBoxAdapter(
        child: Container(
          height: 600.h,
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
            horizontal: 20.w,
          ),
          decoration: BoxDecoration(
            color: Colors.blue.shade900.withOpacity(0.55),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _weather.length,
            itemBuilder: (context, index) =>
                _WeatherPageCityWeatherListItemWidget(
              time: _weather[index].date.hour,
              weatherId: _weather[index].weather.id,
              tempMax: _weather[index].temperature.tempMax.round(),
              tempMin: _weather[index].temperature.tempMin.round(),
            ),
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withOpacity(0.7),
              thickness: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
