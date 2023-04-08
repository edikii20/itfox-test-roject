import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:itfox_test_project/src/domain/entities/city_weather.dart';
import 'package:itfox_test_project/src/domain/entities/weather_from_time.dart';
import 'package:itfox_test_project/src/pages/weather_page/cubit/weather_page_cubit.dart';
import 'package:itfox_test_project/src/utils/app_buttons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../config/app_text_styles.dart';

part 'components/weather_page_bottom_nav_bar_widget.dart';
part 'components/weather_page_city_weather_header_widget.dart';
part 'components/weather_page_city_weather_widget.dart';
part 'components/weather_page_city_weather_list_widget.dart';
part 'components/weather_page_city_weather_list_item_widget.dart';
part 'components/weather_page_add_new_weather_widget.dart';
part 'components/weather_page_reload_current_geopoint_weather_widget.dart';

class WeatherPageWidget extends StatefulWidget {
  const WeatherPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<WeatherPageWidget> createState() => _WeatherPageWidgetState();
}

class _WeatherPageWidgetState extends State<WeatherPageWidget> {
  late final PageController _weatherPagesController;

  @override
  void initState() {
    super.initState();
    _weatherPagesController = PageController();
  }

  @override
  void dispose() {
    _weatherPagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: _WeatherPageBottomNavBarWidget(
          pageController: _weatherPagesController,
        ),
        body: SafeArea(
          child: BlocBuilder<WeatherPageCubit, WeatherPageState>(
            buildWhen: (previous, current) =>
                previous.allPagesStatus != current.allPagesStatus &&
                    previous.weathers != current.weathers ||
                current.addNewWeatherPageStatus == WeatherPagesStatus.completed,
            builder: (context, state) {
              return state.allPagesStatus == WeatherPagesStatus.loading
                  ? Center(
                      child: SizedBox(
                        width: 32.w,
                        height: 32.w,
                        child: const CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 3,
                        ),
                      ),
                    )
                  : PageView.builder(
                      controller: _weatherPagesController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.weathers.length + 1,
                      itemBuilder: (context, index) {
                        if (index == state.weathers.length) {
                          return const _WeatherPageAddNewWeatherWidget();
                        } else if (index == 0) {
                          return state.currentGeopointPageStatus ==
                                  WeatherPagesStatus.completed
                              ? _WeatherPageCityWeatherWidget(
                                  cityWeather: state.weathers[index]!,
                                )
                              : state.currentGeopointPageStatus ==
                                      WeatherPagesStatus.failure
                                  ? const _WeatherPageReloadCurrentGeopointWeatherWidget()
                                  : Center(
                                      child: SizedBox(
                                        width: 32.w,
                                        height: 32.w,
                                        child: const CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 3,
                                        ),
                                      ),
                                    );
                        } else {
                          return _WeatherPageCityWeatherWidget(
                            cityWeather: state.weathers[index]!,
                          );
                        }
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
