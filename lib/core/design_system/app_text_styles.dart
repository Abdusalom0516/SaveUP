import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static Roboto roboto = Roboto();

  TextStyle bold({required double fontSize, Color? color});

  TextStyle semiBold({required double fontSize, Color? color});

  TextStyle medium({required double fontSize, Color? color});

  TextStyle normal({required double fontSize, Color? color});

  TextStyle regular({required double fontSize, Color? color});
}

class Roboto extends AppTextStyles {
  @override
  TextStyle bold({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle semiBold({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle medium({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle normal({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle regular({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color,
    );
  }
}
