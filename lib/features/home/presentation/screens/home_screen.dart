import 'dart:developer';
import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/constants/const_img_paths.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppStateWrapper(
        builder: (colors, texts, colorScheme) => CustomScrollView(
          slivers: [
            // AppBar Section
            _buildAppBarSection(texts, colorScheme, colors),
            SliverHeight(height: 25),
            // Overview Section
            _buildOverviewSection(colorScheme, texts, colors),
            SliverHeight(height: 25),
            // Dreams List Section
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              sliver: SliverList.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const DreamCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildOverviewSection(
    ColorScheme colorScheme,
    ConstTexts texts,
    AppColors colors,
  ) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            border: Border.all(color: colorScheme.outline, width: 1.3.r),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            spacing: 25.h,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    texts.overview,
                    style: AppTextStyles.roboto.medium(
                      fontSize: 16.sp,
                      color: colorScheme.primary,
                    ),
                  ),
                  Text(
                    "2 ${texts.goalsLower} • \$450 ${texts.savedLower}",
                    style: AppTextStyles.roboto.medium(
                      fontSize: 14.sp,
                      color: colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              Column(
                spacing: 7.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        texts.totalProgress,
                        style: AppTextStyles.roboto.medium(
                          fontSize: 14.sp,
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        "\$69.000",
                        style: AppTextStyles.roboto.medium(
                          fontSize: 20.sp,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: 0.37,
                          color: colors.purple,
                          backgroundColor: colorScheme.tertiary,
                          minHeight: 9.h,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "37%",
                        style: AppTextStyles.roboto.medium(
                          fontSize: 14.sp,
                          color: colorScheme.secondary,
                        ),
                      ),
                      Text(
                        "${texts.of} \$185.000",
                        style: AppTextStyles.roboto.medium(
                          fontSize: 14.sp,
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

  SliverAppBar _buildAppBarSection(
    ConstTexts texts,
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return SliverAppBar(
      toolbarHeight: 70.h,
      title: Row(
        spacing: 10.r,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              ConstImgPaths.mainLogo,
              height: 50.r,
              width: 50.r,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            texts.appName,
            style: AppTextStyles.roboto.bold(
              fontSize: 21.sp,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16.r),
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
          decoration: BoxDecoration(
            color: colors.purple.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: colors.purple.withValues(alpha: 0.5),
              width: 1.3.r,
            ),
          ),
          child: Text(
            "\$69.000",
            style: AppTextStyles.roboto.medium(
              fontSize: 16.sp,
              color: colors.purple,
            ),
          ),
        ),
      ],
    );
  }
}

class DreamCard extends StatelessWidget {
  const DreamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          border: Border.all(color: colorScheme.outline, width: 1.3.r),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          spacing: 15.h,
          children: [
            // Title & Actions Part
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 7.h,
                  children: [
                    Row(
                      spacing: 9.w,
                      children: [
                        Container(
                          height: 20.r,
                          width: 6.r,
                          decoration: BoxDecoration(
                            color: colors.purple,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        Text(
                          "Dream Car",
                          style: AppTextStyles.roboto.bold(
                            fontSize: 18.sp,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 5.w,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16.r,
                          color: colorScheme.secondary,
                        ),
                        Text(
                          "6/15/2026",
                          style: AppTextStyles.roboto.medium(
                            fontSize: 16.sp,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  spacing: 9.w,
                  children: [
                    InkWell(
                      onTap: () {
                        log("Edit Goal Tapped");
                      },
                      child: Container(
                        height: 35.r,
                        width: 35.r,
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 18.r,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        log("Delete Goal Tapped");
                      },
                      child: Container(
                        height: 35.r,
                        width: 35.r,
                        decoration: BoxDecoration(
                          color: colors.red.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.delete,
                          size: 18.r,
                          color: colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Progress Part
            Column(
              spacing: 5.h,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      texts.current,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 14.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Text(
                      texts.target,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 14.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$8.500",
                      style: AppTextStyles.roboto.medium(
                        fontSize: 25.sp,
                        color: colorScheme.primary,
                      ),
                    ),
                    Text(
                      "\$12,000",
                      style: AppTextStyles.roboto.medium(
                        fontSize: 20.sp,
                        color: colorScheme.primary.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.75,
                        color: colors.purple,
                        backgroundColor: colorScheme.tertiary,
                        minHeight: 9.h,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "55%",
                      style: AppTextStyles.roboto.medium(
                        fontSize: 14.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "\$4.500 ${texts.leftLower}",
                      style: AppTextStyles.roboto.medium(
                        fontSize: 14.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Actions Part
            Row(
              spacing: 9.w,
              children: [
                CustomActionButton(
                  title: texts.update,
                  onTap: () {
                    log("Update Goal Tapped");
                  },
                  mainColor: colors.purple,
                ),
                CustomActionButton(
                  title: texts.remove,
                  onTap: () {
                    log("Remove Goal Tapped");
                  },
                  mainColor: colorScheme.tertiary,
                ),
                Container(
                  height: 45.r,
                  width: 45.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 24.r,
                    color: colorScheme.primary,
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

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.mainColor,
  });
  final String title;
  final VoidCallback onTap;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppStateWrapper(
        builder: (colors, texts, colorScheme) => InkWell(
          onTap: onTap,
          child: Container(
            height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Text(
              title,
              style: AppTextStyles.roboto.medium(
                fontSize: 16.sp,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
