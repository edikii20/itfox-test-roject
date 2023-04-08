part of '../weather_page.dart';

class _WeatherPageCityWeatherListItemWidget extends StatelessWidget {
  const _WeatherPageCityWeatherListItemWidget({
    Key? key,
    required int time,
    required int weatherId,
    required int tempMax,
    required int tempMin,
  })  : _tempMin = tempMin,
        _tempMax = tempMax,
        _weatherId = weatherId,
        _time = time,
        super(key: key);

  final int _time;
  final int _weatherId;
  final int _tempMax;
  final int _tempMin;

  String _pickWeatherIconName() {
    if (_weatherId >= 200 && _weatherId < 300) {
      return 'assets/icons/thunderstorm.svg';
    } else if (_weatherId >= 300 && _weatherId < 400) {
      return 'assets/icons/drizzle.svg';
    } else if (_weatherId >= 500 && _weatherId < 600) {
      return 'assets/icons/rain.svg';
    } else if (_weatherId >= 600 && _weatherId < 700) {
      return 'assets/icons/snow.svg';
    } else if (_weatherId >= 700 && _weatherId < 800) {
      return 'assets/icons/fog.svg';
    } else if (_weatherId == 800) {
      return 'assets/icons/clear.svg';
    } else {
      return 'assets/icons/clouds.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${_time < 10 ? '0$_time' : _time}:00',
          style: AppTextStyles.semiBold(
            fontSize: 22.sp,
            color: Colors.white,
          ),
        ),
        SvgPicture.asset(
          _pickWeatherIconName(),
          width: 28.w,
          height: 28.w,
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Min:  ',
                style: AppTextStyles.semiBold(
                  fontSize: 22.sp,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text:
                    '${_tempMin < 10 && _tempMin >= 0 ? '    $_tempMin' : _tempMin <= -10 ? _tempMin : '  $_tempMin'}°',
                style: AppTextStyles.semiBold(
                  fontSize: 22.sp,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Max:  ',
                style: AppTextStyles.semiBold(
                  fontSize: 22.sp,
                  color: Colors.white,
                ),
              ),
              TextSpan(
                text:
                    '${_tempMax < 10 && _tempMax >= 0 ? '    $_tempMax' : _tempMax <= -10 ? _tempMax : '  $_tempMax'}°',
                style: AppTextStyles.semiBold(
                  fontSize: 22.sp,
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
