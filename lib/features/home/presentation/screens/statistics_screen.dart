import 'package:boilerplate/core/common/widgets/custom_height_wd.dart';
import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/common/widgets/custom_width_wd.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_router.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/home/data/models/model.dart';
import 'package:boilerplate/features/home/presentation/widgets/contribution_history_card_wd.dart';
import 'package:boilerplate/features/home/presentation/widgets/insights_card_wd.dart';
import 'package:boilerplate/features/home/presentation/widgets/statistics_card_wd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

String _fmt(double amount) {
  if (amount >= 1000) return '\$${NumberFormat('#,##0', 'en_US').format(amount)}';
  return '\$${amount.toStringAsFixed(0)}';
}

Color _colorFromIndex(int index, AppColors colors) {
  switch (index) {
    case 1: return colors.blue;
    case 2: return colors.pink;
    case 3: return colors.green;
    case 4: return colors.orange;
    default: return colors.purple;
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key, required this.dream});

  final DreamModel dream;

  // Compute monthly totals for positive contributions
  Map<String, double> _monthlyTotals() {
    final map = <String, double>{};
    for (final c in dream.contributions.where((c) => c.isAdding)) {
      map[c.formattedMonth] = (map[c.formattedMonth] ?? 0) + c.absoluteAmount;
    }
    return map;
  }

  String _avgMonthly() {
    final totals = _monthlyTotals();
    if (totals.isEmpty) return '\$0';
    final avg = totals.values.fold(0.0, (a, b) => a + b) / totals.length;
    return _fmt(avg);
  }

  String _bestMonth() {
    final totals = _monthlyTotals();
    if (totals.isEmpty) return 'N/A';
    final best = totals.entries.reduce((a, b) => a.value >= b.value ? a : b);
    return '${best.key} — ${_fmt(best.value)}';
  }

  String _lowestMonth() {
    final totals = _monthlyTotals();
    if (totals.isEmpty) return 'N/A';
    final low = totals.entries.reduce((a, b) => a.value <= b.value ? a : b);
    return '${low.key} — ${_fmt(low.value)}';
  }

  List<({ContributionModel contribution, double runningTotal})> _historyItems() {
    final sorted = [...dream.contributions]
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    double running = 0;
    final items = sorted.map((c) {
      running = (running + c.amount).clamp(0.0, dream.targetAmount);
      return (contribution: c, runningTotal: running);
    }).toList();
    return items.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) {
        final cardColor = _colorFromIndex(dream.colorIndex, colors);
        final historyItems = _historyItems();
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildAppBarSection(colorScheme: colorScheme, colors: colors, texts: texts, cardColor: cardColor),
              SliverHeight(height: 20),
              _buildCurrentProgressSection(colorScheme: colorScheme, colors: colors, texts: texts, cardColor: cardColor),
              SliverHeight(height: 20),
              _buildStatisticsCardsSection(colors: colors, texts: texts),
              SliverHeight(height: 20),
              _buildInsightsSection(colorScheme: colorScheme, texts: texts),
              SliverHeight(height: 20),
              _buildContributionHistoryTitleSection(colorScheme: colorScheme, texts: texts),
              SliverHeight(height: 15),
              _buildContributionHistorySection(colorScheme: colorScheme, colors: colors, cardColor: cardColor, historyItems: historyItems, texts: texts),
              SliverHeight(height: 30),
            ],
          ),
        );
      },
    );
  }

  SliverPadding _buildContributionHistoryTitleSection({
    required ColorScheme colorScheme,
    required ConstTexts texts,
  }) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Text(
          texts.contributionHistory,
          style: AppTextStyles.roboto.medium(fontSize: 18.sp, color: colorScheme.primary),
        ),
      ),
    );
  }

  SliverPadding _buildContributionHistorySection({
    required ColorScheme colorScheme,
    required AppColors colors,
    required Color cardColor,
    required List<({ContributionModel contribution, double runningTotal})> historyItems,
    required ConstTexts texts,
  }) {
    if (historyItems.isEmpty) {
      return SliverPadding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
        sliver: SliverToBoxAdapter(
          child: Text(
            'No contributions yet.',
            style: AppTextStyles.roboto.regular(fontSize: 14.sp, color: colorScheme.secondary),
          ),
        ),
      );
    }
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverList.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          final c = item.contribution;
          final sign = c.isAdding ? '+' : '-';
          return ContributionHistoryCard(
            month: c.formattedDate,
            totalLabel: '${texts.total}: ${_fmt(item.runningTotal)}',
            amountLabel: '$sign${_fmt(c.absoluteAmount)}',
            isAdding: c.isAdding,
            dotColor: cardColor,
          );
        },
      ),
    );
  }

  SliverPadding _buildInsightsSection({
    required ColorScheme colorScheme,
    required ConstTexts texts,
  }) {
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
              Text(texts.insights, style: AppTextStyles.roboto.medium(fontSize: 18.sp, color: colorScheme.primary)),
              Column(
                spacing: 12.h,
                children: [
                  InsightsCard(
                    icon: Icons.star_purple500_outlined,
                    title: texts.bestMonth,
                    subtitle: _bestMonth(),
                  ),
                  InsightsCard(
                    icon: Icons.arrow_downward_rounded,
                    title: texts.lowestMonth,
                    subtitle: _lowestMonth(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatisticsCardsSection({
    required AppColors colors,
    required ConstTexts texts,
  }) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Row(
          spacing: 12.w,
          children: [
            StatisticsCard(
              mainColor: colors.green,
              icon: Icons.attach_money_rounded,
              title: texts.avgMonth,
              subtitle: _avgMonthly(),
            ),
            StatisticsCard(
              mainColor: colors.orange,
              icon: Icons.compare_arrows_outlined,
              title: texts.updates,
              subtitle: "${dream.contributions.length}",
            ),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildCurrentProgressSection({
    required ColorScheme colorScheme,
    required AppColors colors,
    required ConstTexts texts,
    required Color cardColor,
  }) {
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
              Text(texts.currentProgress, style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.secondary)),
              Height(height: 10),
              Text(_fmt(dream.currentAmount), style: AppTextStyles.roboto.regular(fontSize: 40.sp, color: colorScheme.primary)),
              Height(height: 5),
              Text("of ${_fmt(dream.targetAmount)}", style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.secondary)),
              Height(height: 10),
              Column(
                spacing: 9.h,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: dream.progressRatio,
                          color: cardColor,
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
                        "${dream.progressPercent.toStringAsFixed(1)}% ${texts.complete}",
                        style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.primary.withValues(alpha: 0.5)),
                      ),
                      Text(
                        "${_fmt(dream.remaining)} ${texts.left}",
                        style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.secondary),
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

  SliverAppBar _buildAppBarSection({
    required ColorScheme colorScheme,
    required AppColors colors,
    required ConstTexts texts,
    required Color cardColor,
  }) {
    return SliverAppBar(
      shape: Border(bottom: BorderSide(color: colorScheme.outline, width: 1.5.r)),
      floating: true,
      pinned: true,
      leadingWidth: double.infinity,
      toolbarHeight: 70.h,
      centerTitle: false,
      leading: Row(
        children: [
          Width(width: 16),
          InkWell(
            onTap: () => AppRouter.close(),
            child: Container(
              height: 40.r,
              width: 40.r,
              decoration: BoxDecoration(color: colorScheme.tertiary, borderRadius: BorderRadius.circular(12.r)),
              child: Icon(Icons.arrow_back_rounded, color: colors.primaryDark, size: 21.r),
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
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r), color: cardColor),
                    ),
                    Expanded(
                      child: Text(
                        dream.name,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.roboto.medium(fontSize: 18.sp, color: colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                Text(texts.detailedStatistics, style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.secondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
