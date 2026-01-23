import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              shape: Border(
                bottom: BorderSide(color: colorScheme.outline, width: 1.5.r),
              ),
              floating: true,
              pinned: true,
              toolbarHeight: 70.h,
              title: Row(
                spacing: 15.w,
                children: [
                  Container(
                    height: 50.r,
                    width: 50.r,
                    decoration: BoxDecoration(
                      color: colors.purple,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.auto_awesome,
                      color: colors.white,
                      size: 24.r,
                    ),
                  ),
                  Column(
                    spacing: 3.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        texts.premiumPlans,
                        style: AppTextStyles.roboto.medium(
                          fontSize: 18.sp,
                          color: colorScheme.primary,
                        ),
                      ),
                      Text(
                        texts.unlockDreams,
                        style: AppTextStyles.roboto.medium(
                          fontSize: 15.sp,
                          color: colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
