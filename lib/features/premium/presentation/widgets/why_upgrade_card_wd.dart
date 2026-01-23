
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhyUpgradeCard extends StatelessWidget {
  const WhyUpgradeCard({
    super.key,
    required this.icon,
    required this.mainColor,
    required this.title,
    required this.subTitle,
  });
  final String title, subTitle;
  final IconData icon;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Row(
        spacing: 10.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 35.r,
            width: 35.r,
            decoration: BoxDecoration(
              color: mainColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: mainColor, size: 20.r),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.roboto.medium(
                    fontSize: 14.sp,
                    color: colorScheme.primary,
                  ),
                ),
                Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: AppTextStyles.roboto.medium(
                    fontSize: 14.sp,
                    color: colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
