import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppStateWrapper extends StatelessWidget {
  const AppStateWrapper({super.key, required this.builder});
  final Widget Function(
    AppColors colors,
    ConstTexts texts,
    ColorScheme colorScheme,
  )
  builder;

  @override
  Widget build(BuildContext context) {
    AppColors colors = AppColors();
    ConstTexts texts = ConstTexts();
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return builder(colors, texts, colorScheme);
  }
}

class UserMeModel {}
