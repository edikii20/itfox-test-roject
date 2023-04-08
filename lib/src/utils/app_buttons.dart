import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppButtons {
  static Widget filledButton({
    required Widget child,
    required Function()? onTap,
    required Color color,
    double? width,
  }) {
    return Stack(
      children: [
        Container(
          width: width ?? double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
