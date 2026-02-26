import 'package:boilerplate/core/constants/const_font_names.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static int _fontIndex = 0;
  static void setFontIndex(int i) => _fontIndex = i;

  // Returns the active font family — used everywhere in the app.
  // Changing _fontIndex makes the entire UI re-render with the new font.
  static AppTextStyles get roboto {
    switch (_fontIndex) {
      case 1:
        return monospace;
      case 2:
        return serif;
      default:
        return robotoFont;
    }
  }

  // Always-Roboto instance for font preview cards in Settings.
  static final Roboto robotoFont = Roboto();

  // Named accessors for font-preview cards in Settings (always specific font).
  static final Serif serif = Serif();
  static final Monospace monospace = Monospace();

  TextStyle bold({required double fontSize, Color? color});
  TextStyle semiBold({required double fontSize, Color? color});
  TextStyle medium({required double fontSize, Color? color});
  TextStyle normal({required double fontSize, Color? color});
  TextStyle regular({required double fontSize, Color? color});

}

class Serif extends AppTextStyles {
  @override
  TextStyle bold({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.notoSerif, fontWeight: FontWeight.bold, fontSize: fontSize, color: color);
  }

  @override
  TextStyle semiBold({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.notoSerif, fontWeight: FontWeight.w600, fontSize: fontSize, color: color);
  }

  @override
  TextStyle medium({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.notoSerif, fontWeight: FontWeight.w500, fontSize: fontSize, color: color);
  }

  @override
  TextStyle normal({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.notoSerif, fontWeight: FontWeight.normal, fontSize: fontSize, color: color);
  }

  @override
  TextStyle regular({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.notoSerif, fontWeight: FontWeight.w400, fontSize: fontSize, color: color);
  }
}

class Monospace extends AppTextStyles {
  @override
  TextStyle bold({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.jetBrainsMono, fontWeight: FontWeight.bold, fontSize: fontSize, color: color);
  }

  @override
  TextStyle semiBold({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.jetBrainsMono, fontWeight: FontWeight.w600, fontSize: fontSize, color: color);
  }

  @override
  TextStyle medium({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.jetBrainsMono, fontWeight: FontWeight.w500, fontSize: fontSize, color: color);
  }

  @override
  TextStyle normal({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.jetBrainsMono, fontWeight: FontWeight.normal, fontSize: fontSize, color: color);
  }

  @override
  TextStyle regular({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.jetBrainsMono, fontWeight: FontWeight.w400, fontSize: fontSize, color: color);
  }
}

class Roboto extends AppTextStyles {
  @override
  TextStyle bold({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.roboto, fontWeight: FontWeight.bold, fontSize: fontSize, color: color);
  }

  @override
  TextStyle semiBold({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.roboto, fontWeight: FontWeight.w600, fontSize: fontSize, color: color);
  }

  @override
  TextStyle medium({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.roboto, fontWeight: FontWeight.w500, fontSize: fontSize, color: color);
  }

  @override
  TextStyle normal({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.roboto, fontWeight: FontWeight.normal, fontSize: fontSize, color: color);
  }

  @override
  TextStyle regular({required double fontSize, Color? color}) {
    return TextStyle(fontFamily: ConstFontNames.roboto, fontWeight: FontWeight.w400, fontSize: fontSize, color: color);
  }
}
