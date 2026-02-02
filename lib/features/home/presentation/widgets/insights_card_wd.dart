import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InsightsCard extends StatelessWidget {
  const InsightsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: colorScheme.tertiary.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          spacing: 13.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(7.r),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: colorScheme.primary.withValues(alpha: 0.8),
                size: 18.r,
              ),
            ),
            Column(
              spacing: 5.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.roboto.medium(
                    fontSize: 15.sp,
                    color: colorScheme.primary.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.roboto.regular(
                    fontSize: 16.sp,
                    color: colorScheme.primary.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
