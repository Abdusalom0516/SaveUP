import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) =>
          Center(child: CircularProgressIndicator(color: colors.purple)),
    );
  }
}
