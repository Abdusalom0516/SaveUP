import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsColorOptionCard extends StatelessWidget {
  const SettingsColorOptionCard({
    super.key,
    required this.mainColor,
    required this.title,
    required this.subtitle,
    required this.func,
    required this.isChosen,
  });

  final Color mainColor;
  final String title;
  final String subtitle;
  final VoidCallback func;
  final bool isChosen;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => InkWell(
        onTap: func,
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: colorScheme.tertiary.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isChosen ? mainColor : colors.transparent,
              width: 1.5.r,
            ),
          ),
          child: Row(
            spacing: 15.w,
            children: [
              Container(
                height: 55.r,
                width: 55.r,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 2.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 18.sp,
                        color: colorScheme.primary,
                      ),
                    ),
                    Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 15.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              isChosen
                  ? Icon(Icons.circle, color: mainColor, size: 12.r)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
