
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsFontFamilyOptionCard extends StatelessWidget {
  const SettingsFontFamilyOptionCard({
    super.key,
    required this.mainColor,
    required this.title,
    required this.subtitle,
    required this.extraText,
    required this.textStyle,
    required this.func,
    required this.isChosen,
  });
  final Color mainColor;
  final String title, subtitle, extraText;
  final bool isChosen;
  final VoidCallback func;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => InkWell(
        onTap: func,
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.tertiary.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            spacing: 25.w,
            children: [
              Expanded(
                child: Column(
                  spacing: 5.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 16.sp,
                        color: colorScheme.primary,
                      ),
                    ),
                    Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: textStyle,
                    ),
                    Text(
                      extraText,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 16.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              isChosen
                  ? Icon(Icons.circle, size: 12.r, color: mainColor)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
