import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/constants/const_img_paths.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/home/data/models/model.dart';
import 'package:boilerplate/features/home/presentation/blocs/bloc.dart';
import 'package:boilerplate/features/home/presentation/widgets/dream_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

String _fmt(double amount) {
  if (amount >= 1000) return '\$${NumberFormat('#,##0', 'en_US').format(amount)}';
  return '\$${amount.toStringAsFixed(0)}';
}

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DreamsCubit, DreamsState>(
      builder: (context, state) {
        final loaded = state is DreamsLoaded ? state : null;
        return Scaffold(
          body: AppStateWrapper(
            builder: (colors, texts, colorScheme) => CustomScrollView(
              slivers: [
                _buildAppBarSection(texts, colorScheme, colors, loaded),
                SliverHeight(height: 20),
                _buildOverviewSection(colorScheme, texts, colors, loaded),
                SliverHeight(height: 20),
                _buildDreamsListSection(state, colors, colorScheme),
                SliverHeight(height: 35),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDreamsListSection(
    DreamsState state,
    AppColors colors,
    ColorScheme colorScheme,
  ) {
    if (state is DreamsLoading) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: CircularProgressIndicator(color: colors.accent),
          ),
        ),
      );
    }

    final activeDreams = state is DreamsLoaded
        ? state.dreams.where((d) => !d.isCompleted).toList()
        : <DreamModel>[];

    if (state is DreamsLoaded && activeDreams.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: Column(
              spacing: 12.h,
              children: [
                Icon(Icons.savings_outlined, size: 56.r, color: colorScheme.secondary),
                Text(
                  "No active goals",
                  style: AppTextStyles.roboto.medium(fontSize: 18.sp, color: colorScheme.primary),
                ),
                Text(
                  "Tap + to create your first savings goal",
                  style: AppTextStyles.roboto.regular(fontSize: 14.sp, color: colorScheme.secondary),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      sliver: SliverList.builder(
        itemCount: activeDreams.length,
        itemBuilder: (context, index) => DreamCard(dream: activeDreams[index]),
      ),
    );
  }

  SliverPadding _buildOverviewSection(
    ColorScheme colorScheme,
    ConstTexts texts,
    AppColors colors,
    DreamsLoaded? loaded,
  ) {
    final totalSaved = loaded?.totalSaved ?? 0;
    final totalTarget = loaded?.totalTarget ?? 0;
    final overallProgress = loaded?.overallProgress ?? 0;
    final overallPercent = loaded?.overallPercent ?? 0;
    final goalCount = loaded?.dreams.where((d) => !d.isCompleted).length ?? 0;

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
                    style: AppTextStyles.roboto.medium(fontSize: 16.sp, color: colorScheme.primary),
                  ),
                  Text(
                    "$goalCount ${texts.goalsLower} • ${_fmt(totalSaved)} ${texts.savedLower}",
                    style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary),
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
                        style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary),
                      ),
                      Text(
                        _fmt(totalSaved),
                        style: AppTextStyles.roboto.medium(fontSize: 20.sp, color: colorScheme.primary),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: overallProgress,
                          color: colors.accent,
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
                        "$overallPercent%",
                        style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary),
                      ),
                      Text(
                        "${texts.of} ${_fmt(totalTarget)}",
                        style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary),
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
    DreamsLoaded? loaded,
  ) {
    final totalSaved = loaded?.totalSaved ?? 0;
    return SliverAppBar(
      shape: Border(bottom: BorderSide(color: colorScheme.outline, width: 1.5.r)),
      floating: true,
      pinned: true,
      toolbarHeight: 70.h,
      title: Row(
        spacing: 10.r,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(ConstImgPaths.mainLogo, height: 50.r, width: 50.r, fit: BoxFit.cover),
          ),
          Text(texts.appName, style: AppTextStyles.roboto.bold(fontSize: 21.sp, color: colorScheme.primary)),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16.r),
          padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 5.r),
          decoration: BoxDecoration(
            color: colors.accent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: colors.accent.withValues(alpha: 0.5), width: 1.3.r),
          ),
          child: Text(
            _fmt(totalSaved),
            style: AppTextStyles.roboto.medium(fontSize: 16.sp, color: colors.accent),
          ),
        ),
      ],
    );
  }
}
