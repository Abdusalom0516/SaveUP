import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickOptionCard extends StatelessWidget {
  const QuickOptionCard({super.key, required this.amount, required this.func});
  final int amount;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppStateWrapper(
        builder: (colors, texts, colorScheme) => InkWell(
          onTap: func,
          child: Container(
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.tertiary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              "\$$amount",
              style: AppTextStyles.roboto.medium(
                fontSize: 14.sp,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
