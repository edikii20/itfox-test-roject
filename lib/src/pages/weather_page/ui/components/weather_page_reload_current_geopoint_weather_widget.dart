part of '../weather_page.dart';

class _WeatherPageReloadCurrentGeopointWeatherWidget extends StatelessWidget {
  const _WeatherPageReloadCurrentGeopointWeatherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Please turn on geolocation and try again',
            style: AppTextStyles.bold(
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 40.h),
          AppButtons.filledButton(
            child: Text(
              'Reload',
              style: AppTextStyles.bold(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
            width: 100.w,
            onTap: () => context
                .read<WeatherPageCubit>()
                .onTapReloadCurrentGeopointWeather(),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
