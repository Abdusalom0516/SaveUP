import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContributionHistoryCard extends StatelessWidget {
  const ContributionHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Container(
        padding: EdgeInsets.all(12.r),
        margin: EdgeInsets.only(bottom: 12.r),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          border: Border.all(color: colorScheme.outline, width: 1.3.r),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          spacing: 15.w,
          children: [
            Icon(Icons.circle, color: colors.purple, size: 13.r),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Apr 2024",
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.roboto.medium(
                      fontSize: 16.sp,
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    "Total: \$1,500",
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.roboto.medium(
                      fontSize: 14.sp,
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "+\$1,600",
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.roboto.medium(
                    fontSize: 16.sp,
                    color: colorScheme.primary,
                  ),
                ),
                Text(
                  "added",
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.roboto.medium(
                    fontSize: 14.sp,
                    color: colorScheme.secondary,
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

