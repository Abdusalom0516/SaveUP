import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(builder: (colors, texts, colorScheme) => Scaffold(
      body: Center(
        child: Text("Premium Screen"),
      ),
    ),);
  }
}