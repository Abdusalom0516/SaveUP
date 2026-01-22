import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/settings/presentation/widgets/settings_color_option_wd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chosenColorIndex = useState(0);
    final chosenFontFamilyIndex = useState(0);
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildAppBar(colorScheme, colors, texts),
            SliverHeight(height: 20),
            SliverPadding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    border: Border.all(
                      color: colorScheme.outline,
                      width: 1.5.r,
                    ),
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
                                    color: colors.purple,
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
                                        color: colors.purple,
                                        backgroundColor: colorScheme.tertiary,
                                        minHeight: 9.h,
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
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
            ),
            SliverHeight(height: 20),
            _buildThemeSection(colorScheme, colors, chosenColorIndex),
            SliverHeight(height: 20),
            _buildFontFamilySection(
              colorScheme,
              colors,
              texts,
              chosenFontFamilyIndex,
            ),
            SliverHeight(height: 35),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildFontFamilySection(
    ColorScheme colorScheme,
    AppColors colors,
    ConstTexts texts,
    ValueNotifier<int> chosenFontFamilyIndex,
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
                mainColor: colors.purple,
                title: texts.defaultT,
                subtitle: "Clean & Modern",
                extraText: "Sans-serif system font",
                textStyle: AppTextStyles.roboto.semiBold(
                  fontSize: 20.sp,
                  color: colors.purple,
                ),
                isChosen: chosenFontFamilyIndex.value == 0,
                func: () {
                  chosenFontFamilyIndex.value = 0;
                },
              ),
              SettingsFontFamilyOptionCard(
                mainColor: colors.purple,
                title: "Monospace",
                subtitle: "Code Style",
                extraText: "Technical & Precise",
                textStyle: AppTextStyles.monospace.semiBold(
                  fontSize: 20.sp,
                  color: colors.purple,
                ),
                isChosen: chosenFontFamilyIndex.value == 1,
                func: () {
                  chosenFontFamilyIndex.value = 1;
                },
              ),
              SettingsFontFamilyOptionCard(
                mainColor: colors.purple,
                title: "Serif",
                subtitle: "Classic & Elegant",
                extraText: "Traditional & refined",
                textStyle: AppTextStyles.serif.semiBold(
                  fontSize: 20.sp,
                  color: colors.purple,
                ),
                isChosen: chosenFontFamilyIndex.value == 2,
                func: () {
                  chosenFontFamilyIndex.value = 2;
                },
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
    ValueNotifier<int> chosenColorIndex,
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
                func: () {
                  chosenColorIndex.value = 0;
                },
                isChosen: chosenColorIndex.value == 0,
              ),
              SettingsColorOptionCard(
                mainColor: colors.blue,
                title: "Ocean Blue",
                subtitle: "Calm & Trustworthy",
                func: () {
                  chosenColorIndex.value = 1;
                },
                isChosen: chosenColorIndex.value == 1,
              ),
              SettingsColorOptionCard(
                mainColor: colors.green,
                title: "Forest Green",
                subtitle: "Fresh & Growth",
                func: () {
                  chosenColorIndex.value = 2;
                },
                isChosen: chosenColorIndex.value == 2,
              ),
              SettingsColorOptionCard(
                mainColor: colors.orange,
                title: "Sunset Orange",
                subtitle: "Energetic & Bold",
                func: () {
                  chosenColorIndex.value = 3;
                },
                isChosen: chosenColorIndex.value == 3,
              ),
              SettingsColorOptionCard(
                mainColor: colors.pink,
                title: "Pink Blush",
                subtitle: "Playful & Fun",
                func: () {
                  chosenColorIndex.value = 4;
                },
                isChosen: chosenColorIndex.value == 4,
              ),
              SettingsColorOptionCard(
                mainColor: colors.teal,
                title: "Teal Wave",
                subtitle: "Balanced & Unique",
                func: () {
                  chosenColorIndex.value = 5;
                },
                isChosen: chosenColorIndex.value == 5,
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
              color: colors.purple,
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
