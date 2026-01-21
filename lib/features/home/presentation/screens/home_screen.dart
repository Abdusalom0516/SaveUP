import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/constants/const_img_paths.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/home/presentation/widgets/dream_card.dart';
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
            SliverHeight(height: 20),
            // Overview Section
            _buildOverviewSection(colorScheme, texts, colors),
            SliverHeight(height: 20),
            // Dreams List Section
            _buildDreamsListSection(),
            SliverHeight(height: 35),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildDreamsListSection() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      sliver: SliverList.builder(
        itemCount: 3,
        itemBuilder: (context, index) => const DreamCard(),
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
      shape: Border(
        bottom: BorderSide(color: colorScheme.outline, width: 1.3.r),
      ),
      floating: true,
      pinned: true,
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
