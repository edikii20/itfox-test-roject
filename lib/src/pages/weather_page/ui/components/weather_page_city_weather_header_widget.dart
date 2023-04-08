part of '../weather_page.dart';

class _WeatherPageCityWeatherHeaderWidget extends StatefulWidget {
  const _WeatherPageCityWeatherHeaderWidget({
    Key? key,
    required ScrollController scrollController,
    required String city,
    required int temp,
    required int tempMax,
    required int tempMin,
    required String weatherName,
  })  : _tempMin = tempMin,
        _weatherName = weatherName,
        _tempMax = tempMax,
        _temp = temp,
        _city = city,
        _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final String _city;
  final int _temp;
  final int _tempMax;
  final int _tempMin;
  final String _weatherName;

  @override
  State<_WeatherPageCityWeatherHeaderWidget> createState() =>
      _WeatherPageCityWeatherHeaderWidgetState();
}

class _WeatherPageCityWeatherHeaderWidgetState
    extends State<_WeatherPageCityWeatherHeaderWidget> {
  bool _isHide = true;

  @override
  void initState() {
    super.initState();
    widget._scrollController.addListener(() {
      if (widget._scrollController.offset > 150.h && _isHide) {
        setState(() {
          _isHide = false;
        });
      } else if (widget._scrollController.offset <= 150.h && !_isHide) {
        setState(() {
          _isHide = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      pinned: true,
      snap: false,
      centerTitle: true,
      expandedHeight: 250.h,
      toolbarHeight: 70.h,
      surfaceTintColor: Colors.white,
      collapsedHeight: 100.h,
      title: _isHide
          ? null
          : Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: '${widget._city}\n',
                    style: AppTextStyles.semiBold(
                      fontSize: 32.sp,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '${widget._temp}° | ${widget._weatherName}',
                    style: AppTextStyles.semiBold(
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        expandedTitleScale: 1,
        background: Center(
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: '${widget._city}\n',
                  style: AppTextStyles.semiBold(
                    fontSize: 32.sp,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '${widget._temp}°\n',
                  style: AppTextStyles.regular(
                    fontSize: 46.sp,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '${widget._weatherName}\n',
                  style: AppTextStyles.semiBold(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: 'Max: ${widget._tempMax}°, Min: ${widget._tempMin}°',
                  style: AppTextStyles.semiBold(
                    fontSize: 18.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
