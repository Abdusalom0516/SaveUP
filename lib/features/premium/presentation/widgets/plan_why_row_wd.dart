
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanWhyRow extends StatelessWidget {
  const PlanWhyRow({super.key, required this.title, required this.mainColor});
  final String title;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Row(
        spacing: 10.w,
        children: [
          Container(
            height: 25.r,
            width: 25.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: mainColor.withValues(alpha: 0.2),
            ),
            child: Icon(Icons.done, color: mainColor, size: 16.r),
          ),
          Text(
            title,
            style: AppTextStyles.roboto.regular(
              fontSize: 14.sp,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
