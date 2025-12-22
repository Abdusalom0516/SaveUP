import 'package:boilerplate/core/constants/const_img_paths.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => CustomScrollView(
        slivers: [
          // AppBar Section
          SliverAppBar(
            title: Row(
              spacing: 10.r,
              children: [
                Image.asset(
                  ConstImgPaths.mainLogo,
                  height: 50.r,
                  width: 50.r,
                  fit: BoxFit.contain,
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
                padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 5.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: colors.purple, width: 1.3.r),
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
          ),

          // Body Section
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      border: Border.all(
                        color: colorScheme.outline,
                        width: 1.3.r,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
