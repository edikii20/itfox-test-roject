part of '../weather_page.dart';

class _WeatherPageAddNewWeatherWidget extends StatefulWidget {
  const _WeatherPageAddNewWeatherWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_WeatherPageAddNewWeatherWidget> createState() =>
      _WeatherPageAddNewWeatherWidgetState();
}

class _WeatherPageAddNewWeatherWidgetState
    extends State<_WeatherPageAddNewWeatherWidget> {
  late final TextEditingController _cityInputController;

  @override
  void initState() {
    super.initState();
    _cityInputController = TextEditingController();
  }

  @override
  void dispose() {
    _cityInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<WeatherPageCubit, WeatherPageState>(
        buildWhen: (previous, current) =>
            previous.addNewWeatherPageStatus != current.addNewWeatherPageStatus,
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _cityInputController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  errorStyle: AppTextStyles.medium(
                    fontSize: 12.sp,
                    color: Colors.red.shade900,
                  ),
                  hintText: 'City',
                  errorText: state.addNewWeatherPageStatus ==
                          WeatherPagesStatus.failure
                      ? 'Incorrect City'
                      : null,
                ),
                style: AppTextStyles.semiBold(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 40.h),
              AppButtons.filledButton(
                child:
                    state.addNewWeatherPageStatus == WeatherPagesStatus.loading
                        ? SizedBox(
                            width: 26.h,
                            height: 26.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Add new weather',
                            style: AppTextStyles.bold(
                              fontSize: 18.sp,
                              color: Colors.white,
                            ),
                          ),
                onTap: state.addNewWeatherPageStatus ==
                        WeatherPagesStatus.loading
                    ? null
                    : () => context.read<WeatherPageCubit>().onTapAddNewWeather(
                          city: _cityInputController.text.trim(),
                        ),
                color: Colors.black,
              ),
            ],
          );
        },
      ),
    );
  }
}
