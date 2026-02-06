import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.mainColor,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final Color mainColor;
  final IconData icon;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Expanded(
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            border: Border.all(color: colorScheme.outline, width: 1.3.r),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            spacing: 10.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 10.w,
                children: [
                  Container(
                    padding: EdgeInsets.all(7.r),
                    decoration: BoxDecoration(
                      color: mainColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(icon, color: mainColor, size: 21.r),
                  ),
                  Text(
                    title,
                    style: AppTextStyles.roboto.medium(
                      fontSize: 15.sp,
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Text(
                subtitle,
                style: AppTextStyles.roboto.medium(
                  fontSize: 23.sp,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
