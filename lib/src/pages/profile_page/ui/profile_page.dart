import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:itfox_test_project/src/app/cubit/app_cubit.dart';

import '../../../config/app_text_styles.dart';

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.goNamed('weather');
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Profile',
            style: AppTextStyles.bold(
              fontSize: 28.sp,
              color: Colors.black,
            ),
          ),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () => context.read<AppCubit>().logOut(),
            child: SvgPicture.asset(
              'assets/icons/log_out.svg',
              width: 60.w,
              height: 60.w,
              colorFilter: const ColorFilter.mode(
                Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
