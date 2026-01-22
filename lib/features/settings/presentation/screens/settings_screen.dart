import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chosenColorIndex = useState(0);
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildAppBar(colorScheme, colors, texts),
            SliverHeight(height: 20),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
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
                    spacing: 15.h,
                    children: [
                      SettingsColorOption(
                        mainColor: colors.purple,
                        title: "Purple Dream",
                        subtitle: "Creative & Modern",
                        func: () {
                          chosenColorIndex.value = 0;
                        },
                        isChosen: chosenColorIndex.value == 0,
                      ),
                      SettingsColorOption(
                        mainColor: colors.blue,
                        title: "Ocean Blue",
                        subtitle: "Calm & Trustworthy",
                        func: () {
                          chosenColorIndex.value = 1;
                        },
                        isChosen: chosenColorIndex.value == 1,
                      ),
                      SettingsColorOption(
                        mainColor: colors.purple,
                        title: "Forest Green",
                        subtitle: "Fresh & Growth",
                        func: () {
                          chosenColorIndex.value = 2;
                        },
                        isChosen: chosenColorIndex.value == 2,
                      ),
                      SettingsColorOption(
                        mainColor: colors.purple,
                        title: "Sunset Orange",
                        subtitle: "Energetic & Bold",
                        func: () {
                          chosenColorIndex.value = 3;
                        },
                        isChosen: chosenColorIndex.value == 3,
                      ),
                      SettingsColorOption(
                        mainColor: colors.purple,
                        title: "Pink Blush",
                        subtitle: "Playful & Fun",
                        func: () {
                          chosenColorIndex.value = 4;
                        },
                        isChosen: chosenColorIndex.value == 4,
                      ),
                      SettingsColorOption(
                        mainColor: colors.purple,
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
            ),
          ],
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

class SettingsColorOption extends StatelessWidget {
  const SettingsColorOption({
    super.key,
    required this.mainColor,
    required this.title,
    required this.subtitle,
    required this.func,
    required this.isChosen,
  });

  final Color mainColor;
  final String title;
  final String subtitle;
  final VoidCallback func;
  final bool isChosen;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => InkWell(
        onTap: func,
        child: Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: colorScheme.tertiary.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isChosen ? mainColor : colors.transparent,
              width: 1.5.r,
            ),
          ),
          child: Row(
            spacing: 15.w,
            children: [
              Container(
                height: 55.r,
                width: 55.r,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: 2.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 18.sp,
                        color: colorScheme.primary,
                      ),
                    ),
                    Text(
                      subtitle,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 15.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              isChosen
                  ? Icon(Icons.circle, color: mainColor, size: 12.r)
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
