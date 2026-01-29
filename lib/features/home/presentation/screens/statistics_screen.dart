import 'package:boilerplate/core/common/widgets/custom_height_wd.dart';
import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/common/widgets/custom_width_wd.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Scaffold(
        body: CustomScrollView(
          slivers: [
            // AppBar Section
            _buildAppBarSection(colorScheme, colors),
            SliverHeight(height: 20),
            // Current Progress Section
            _buildCurrentProgressSection(colorScheme, colors),
            SliverHeight(height: 20),
             SliverHeight(height: 35),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildCurrentProgressSection(
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            border: Border.all(color: colorScheme.outline, width: 1.3.r),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Text(
                "Current Progress",
                style: AppTextStyles.roboto.medium(
                  fontSize: 15.sp,
                  color: colorScheme.secondary,
                ),
              ),
              Height(height: 10),
              Text(
                "\$8,500",
                style: AppTextStyles.roboto.regular(
                  fontSize: 40.sp,
                  color: colorScheme.primary,
                ),
              ),
              Height(height: 5),
              Text(
                "of \$25,000",
                style: AppTextStyles.roboto.medium(
                  fontSize: 15.sp,
                  color: colorScheme.secondary,
                ),
              ),
              Height(height: 10),
              Column(
                spacing: 9.h,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.34,
                          color: colors.purple,
                          backgroundColor: colorScheme.tertiary,
                          minHeight: 12.h,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "34.0% Complete",
                        style: AppTextStyles.roboto.medium(
                          fontSize: 15.sp,
                          color: colorScheme.primary.withValues(alpha: 0.5),
                        ),
                      ),
                      Text(
                        "\$16,500 left",
                        style: AppTextStyles.roboto.medium(
                          fontSize: 15.sp,
                          color: colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBarSection(ColorScheme colorScheme, AppColors colors) {
    return SliverAppBar(
      shape: Border(
        bottom: BorderSide(color: colorScheme.outline, width: 1.5.r),
      ),
      floating: true,
      pinned: true,
      leadingWidth: double.infinity,
      toolbarHeight: 70.h,
      centerTitle: false,
      leading: Row(
        children: [
          Width(width: 16),
          InkWell(
            onTap: () {},
            child: Container(
              height: 40.r,
              width: 40.r,
              decoration: BoxDecoration(
                color: colorScheme.tertiary,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: colors.primaryDark,
                size: 21.r,
              ),
            ),
          ),
          Width(width: 16),
          Expanded(
            child: Column(
              spacing: 3.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  spacing: 9.w,
                  children: [
                    Container(
                      height: 18.h,
                      width: 5.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: colors.purple,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Travel to Japan",
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.roboto.medium(
                          fontSize: 18.sp,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  "Detailed Statistics",
                  style: AppTextStyles.roboto.medium(
                    fontSize: 15.sp,
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
