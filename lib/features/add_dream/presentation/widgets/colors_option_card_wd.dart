import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorsOptionCard extends StatelessWidget {
  const ColorsOptionCard({
    super.key,
    required this.mainColor,
    required this.func,
    required this.isChosen,
  });
  final Color mainColor;
  final VoidCallback func;
  final bool isChosen;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => InkWell(
        onTap: func,
        child: Container(
          height: 45.h,
          width: 75.w,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isChosen ? colors.white : colors.transparent,
              width: 2.5.r,
            ),
          ),
        ),
      ),
    );
  }
}
