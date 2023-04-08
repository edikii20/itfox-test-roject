part of '../weather_page.dart';

class _WeatherPageBottomNavBarWidget extends StatelessWidget {
  const _WeatherPageBottomNavBarWidget({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 20.w,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300,
              width: 0.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                'assets/icons/menu.svg',
                width: 28.w,
                height: 28.w,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
            BlocBuilder<WeatherPageCubit, WeatherPageState>(
              buildWhen: (previous, current) =>
                  previous.addNewWeatherPageStatus !=
                      WeatherPagesStatus.completed &&
                  current.addNewWeatherPageStatus ==
                      WeatherPagesStatus.completed,
              builder: (context, state) {
                return SmoothPageIndicator(
                  controller: _pageController,
                  count: state.weathers.length + 1,
                  effect: ScrollingDotsEffect(
                    dotHeight: 10.h,
                    dotWidth: 10.h,
                    maxVisibleDots: 9,
                    activeDotColor: Colors.black,
                  ),
                );
              },
            ),
            GestureDetector(
              onTap: () => context.goNamed('profile'),
              child: SvgPicture.asset(
                'assets/icons/user.svg',
                width: 28.w,
                height: 28.w,
                colorFilter: const ColorFilter.mode(
                  Colors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
