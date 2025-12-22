import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.mainColor,
  });
  final String title;
  final VoidCallback onTap;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppStateWrapper(
        builder: (colors, texts, colorScheme) => InkWell(
          onTap: onTap,
          child: Container(
            height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Text(
              title,
              style: AppTextStyles.roboto.medium(
                fontSize: 16.sp,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
