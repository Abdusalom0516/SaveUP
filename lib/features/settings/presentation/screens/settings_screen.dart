import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/settings/presentation/blocs/settings_cubit.dart';
import 'package:boilerplate/features/settings/presentation/widgets/font_family_option_card_wd.dart';
import 'package:boilerplate/features/settings/presentation/widgets/color_option_wd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) {
        final cubit = context.read<SettingsCubit>();
        final settings = context.read<SettingsCubit>().state;
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildAppBar(colorScheme, colors, texts),
              SliverHeight(height: 20),
              _buildPreviewSection(colorScheme, texts, colors),
              SliverHeight(height: 20),
              _buildThemeSection(
                colorScheme,
                colors,
                settings.colorIndex,
                cubit,
              ),
              SliverHeight(height: 20),
              _buildFontFamilySection(
                colorScheme,
                colors,
                texts,
                settings.fontIndex,
                cubit,
              ),
              SliverHeight(height: 105),
            ],
          ),
        );
      },
    );
  }

  SliverPadding _buildPreviewSection(
    ColorScheme colorScheme,
    ConstTexts texts,
    AppColors colors,
  ) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            border: Border.all(color: colorScheme.outline, width: 1.5.r),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            spacing: 10.r,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                texts.preview,
                style: AppTextStyles.roboto.medium(
                  fontSize: 18.sp,
                  color: colorScheme.primary,
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  spacing: 15.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10.r,
                      children: [
                        Container(
                          height: 18.h,
                          width: 4.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            color: colors.accent,
                          ),
                        ),
                        Text(
                          texts.sampleGoal,
                          style: AppTextStyles.roboto.medium(
                            fontSize: 16.sp,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      spacing: 6.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$5,000 / \$10,000",
                          style: AppTextStyles.roboto.regular(
                            fontSize: 16.sp,
                            color: colorScheme.primary,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: 0.75,
                                color: colors.accent,
                                backgroundColor: colorScheme.tertiary,
                                minHeight: 9.h,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildFontFamilySection(
    ColorScheme colorScheme,
    AppColors colors,
    ConstTexts texts,
    int fontIndex,
    SettingsCubit cubit,
  ) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            border: Border.all(color: colorScheme.outline, width: 1.5.r),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            spacing: 12.h,
            children: [
              SettingsFontFamilyOptionCard(
                mainColor: colors.accent,
                title: texts.defaultT,
                subtitle: "Clean & Modern",
                extraText: "Sans-serif system font",
                textStyle: AppTextStyles.robotoFont.semiBold(
                  fontSize: 20.sp,
                  color: colors.accent,
                ),
                isChosen: fontIndex == 0,
                func: () => cubit.setFont(0),
              ),
              SettingsFontFamilyOptionCard(
                mainColor: colors.accent,
                title: "Monospace",
                subtitle: "Code Style",
                extraText: "Technical & Precise",
                textStyle: AppTextStyles.monospace.semiBold(
                  fontSize: 20.sp,
                  color: colors.accent,
                ),
                isChosen: fontIndex == 1,
                func: () => cubit.setFont(1),
              ),
              SettingsFontFamilyOptionCard(
                mainColor: colors.accent,
                title: "Serif",
                subtitle: "Classic & Elegant",
                extraText: "Traditional & refined",
                textStyle: AppTextStyles.serif.semiBold(
                  fontSize: 20.sp,
                  color: colors.accent,
                ),
                isChosen: fontIndex == 2,
                func: () => cubit.setFont(2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildThemeSection(
    ColorScheme colorScheme,
    AppColors colors,
    int colorIndex,
    SettingsCubit cubit,
  ) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            border: Border.all(color: colorScheme.outline, width: 1.5.r),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            spacing: 15.h,
            children: [
              SettingsColorOptionCard(
                mainColor: colors.purple,
                title: "Purple Dream",
                subtitle: "Creative & Modern",
                func: () => cubit.setColor(0),
                isChosen: colorIndex == 0,
              ),
              SettingsColorOptionCard(
                mainColor: colors.blue,
                title: "Ocean Blue",
                subtitle: "Calm & Trustworthy",
                func: () => cubit.setColor(1),
                isChosen: colorIndex == 1,
              ),
              SettingsColorOptionCard(
                mainColor: colors.green,
                title: "Forest Green",
                subtitle: "Fresh & Growth",
                func: () => cubit.setColor(2),
                isChosen: colorIndex == 2,
              ),
              SettingsColorOptionCard(
                mainColor: colors.orange,
                title: "Sunset Orange",
                subtitle: "Energetic & Bold",
                func: () => cubit.setColor(3),
                isChosen: colorIndex == 3,
              ),
              SettingsColorOptionCard(
                mainColor: colors.pink,
                title: "Pink Blush",
                subtitle: "Playful & Fun",
                func: () => cubit.setColor(4),
                isChosen: colorIndex == 4,
              ),
              SettingsColorOptionCard(
                mainColor: colors.teal,
                title: "Teal Wave",
                subtitle: "Balanced & Unique",
                func: () => cubit.setColor(5),
                isChosen: colorIndex == 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverAppBar _buildAppBar(
    ColorScheme colorScheme,
    AppColors colors,
    ConstTexts texts,
  ) {
    return SliverAppBar(
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
              color: colors.accent,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(Icons.auto_awesome, color: colors.white, size: 24.r),
          ),
          Column(
            spacing: 3.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                texts.settings,
                style: AppTextStyles.roboto.medium(
                  fontSize: 18.sp,
                  color: colorScheme.primary,
                ),
              ),
              Text(
                texts.customizeYourExp,
                style: AppTextStyles.roboto.medium(
                  fontSize: 15.sp,
                  color: colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
