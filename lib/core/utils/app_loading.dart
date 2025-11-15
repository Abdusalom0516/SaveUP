import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoadingScreen extends StatelessWidget {
  final EdgeInsets? padding;

  const AppLoadingScreen({this.padding = EdgeInsets.zero, super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Center(
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: SizedBox(
            height: 48.r,
            width: 48.r,
            child: CircularProgressIndicator(
              strokeWidth: 8.w,
              color: colors.greenPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

void showAppLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AppLoadingScreen(padding: EdgeInsets.all(100.w));
    },
  );
}

void loading(BuildContext context) => showAppLoadingDialog(context);
