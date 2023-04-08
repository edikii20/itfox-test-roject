import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static TextStyle regular({
    required double fontSize,
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontFamily: 'Nunito',
      fontSize: fontSize,
    );
  }

  static TextStyle medium({
    required double fontSize,
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontFamily: 'Nunito',
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBold({
    required double fontSize,
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontFamily: 'Nunito',
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bold({
    required double fontSize,
    required Color color,
  }) {
    return TextStyle(
      color: color,
      fontFamily: 'Nunito',
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }
}
