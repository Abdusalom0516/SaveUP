import 'package:boilerplate/core/constants/const_font_names.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static Roboto roboto = Roboto();
  static Serif serif = Serif();
  static Monospace monospace = Monospace();

  TextStyle bold({required double fontSize, Color? color});

  TextStyle semiBold({required double fontSize, Color? color});

  TextStyle medium({required double fontSize, Color? color});

  TextStyle normal({required double fontSize, Color? color});

  TextStyle regular({required double fontSize, Color? color});
}

class Serif extends AppTextStyles {
  @override
  TextStyle bold({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.notoSerif,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle semiBold({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.notoSerif,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle medium({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.notoSerif,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle normal({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.notoSerif,
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle regular({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.notoSerif,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color,
    );
  }
}

class Monospace extends AppTextStyles {
  @override
  TextStyle bold({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.jetBrainsMono,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle semiBold({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.jetBrainsMono,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle medium({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.jetBrainsMono,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle normal({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.jetBrainsMono,
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle regular({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.jetBrainsMono,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color,
    );
  }
}

class Roboto extends AppTextStyles {
  @override
  TextStyle bold({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.roboto,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle semiBold({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.roboto,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle medium({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.roboto,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle normal({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.roboto,
      fontWeight: FontWeight.normal,
      fontSize: fontSize,
      color: color,
    );
  }

  @override
  TextStyle regular({required double fontSize, Color? color}) {
    return TextStyle(
      fontFamily: ConstFontNames.roboto,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color,
    );
  }
}
