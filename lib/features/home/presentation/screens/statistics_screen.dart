import 'package:boilerplate/core/common/widgets/custom_width_wd.dart';
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
            SliverAppBar(
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
            ),
          ],
        ),
      ),
    );
  }
}
