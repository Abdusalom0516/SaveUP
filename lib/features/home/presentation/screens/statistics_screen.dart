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
            // Statistics Cards Section
            _buildStatisticsCardsSection(colors),
            SliverHeight(height: 20),
            // Insights Section
            _buildInsightsSection(colorScheme),
            SliverHeight(height: 20),
            // Contribution History Title Section
            _buildContributionHistoryTitleSection(colorScheme),
            SliverHeight(height: 15),
            // Contribution History Section
            _buildContributionHistorySection(colorScheme, colors),
            SliverHeight(height: 30),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildContributionHistoryTitleSection(ColorScheme colorScheme) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Text(
          "Contribution History",
          style: AppTextStyles.roboto.medium(
            fontSize: 18.sp,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }

  SliverPadding _buildContributionHistorySection(
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverList.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ContributionHistoryCard(),
      ),
    );
  }

  SliverPadding _buildInsightsSection(ColorScheme colorScheme) {
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
            spacing: 15.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Insights",
                style: AppTextStyles.roboto.medium(
                  fontSize: 18.sp,
                  color: colorScheme.primary,
                ),
              ),
              Column(
                spacing: 12.h,
                children: [
                  InsightsCard(
                    icon: Icons.star_purple500_outlined,
                    title: "Best Month",
                    subtitle: "Mar 2024 - \$1,700",
                  ),
                  InsightsCard(
                    icon: Icons.arrow_downward_rounded,
                    title: "Lowest Month",
                    subtitle: "Jun 2024 - \$1,100",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatisticsCardsSection(AppColors colors) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Row(
          spacing: 12.w,
          children: [
            StatisticsCard(
              mainColor: colors.green,
              icon: Icons.attach_money_rounded,
              title: "Avg/Month",
              subtitle: "\$1417",
            ),
            StatisticsCard(
              mainColor: colors.orange,
              icon: Icons.compare_arrows_outlined,
              title: "Updates",
              subtitle: "11",
            ),
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

class InsightsCard extends StatelessWidget {
  const InsightsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  final IconData icon;
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: colorScheme.tertiary.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          spacing: 13.w,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(7.r),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: colorScheme.primary.withValues(alpha: 0.8),
                size: 18.r,
              ),
            ),
            Column(
              spacing: 5.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.roboto.medium(
                    fontSize: 15.sp,
                    color: colorScheme.primary.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.roboto.regular(
                    fontSize: 16.sp,
                    color: colorScheme.primary.withValues(alpha: 0.9),
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
