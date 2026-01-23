import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/premium/presentation/widgets/plan_card_wd.dart';
import 'package:boilerplate/features/premium/presentation/widgets/why_upgrade_card_wd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Scaffold(
        body: CustomScrollView(
          slivers: [
            // AppBar Section
            _buildAppBarSection(colorScheme, colors, texts),
            SliverHeight(height: 20),
            // Current Plan Section
            _buildCurrentPlanSection(colorScheme, colors, texts),
            SliverHeight(height: 20),
            // Plans Section
            _buildPlanCardsSection(colors),
            SliverHeight(height: 20),
            // Why Upgrade Section
            _buildWhyUpgradeSection(colorScheme, colors),
            SliverHeight(height: 35),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildWhyUpgradeSection(
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.tertiary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colorScheme.outline, width: 1.5.r),
          ),
          child: Column(
            spacing: 15.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Why Upgrade?",
                style: AppTextStyles.roboto.medium(
                  fontSize: 18.sp,
                  color: colorScheme.primary,
                ),
              ),
              Column(
                spacing: 10.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WhyUpgradeCard(
                    icon: Icons.stacked_line_chart,
                    mainColor: colors.purple,
                    title: "Track More Goals",
                    subTitle: "Save for multiple dreams simultaneously",
                  ),
                  WhyUpgradeCard(
                    icon: Icons.dark_mode_sharp,
                    mainColor: colors.blue,
                    title: "Stay Motivated",
                    subTitle: "Visual progress tracking keeps you on track",
                  ),
                  WhyUpgradeCard(
                    icon: Icons.filter_vintage_sharp,
                    mainColor: colors.orange,
                    title: "Lifetime Access",
                    subTitle: "One-time payment, no subscriptions",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverPadding _buildPlanCardsSection(AppColors colors) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Column(
          spacing: 15.h,
          children: [
            PlanCard(
              planTitle: "Starter",
              icon: Icons.webhook_outlined,
              func: () {},
              buttonText: "Get Starter",
              dreamCount: "1",
              mainColor: colors.blue,
              price: "2.99",
              priceCategory: "one-time",
              listOfWhys: [
                "Add 1 savings goal",
                "Full statistics & charts",
                "Color customization",
                "Progress tracking",
              ],
            ),
            PlanCard(
              planTitle: "Dream Pack",
              icon: Icons.whatshot,
              func: () {},
              buttonText: "Get Dream Pack",
              dreamCount: "3",
              mainColor: colors.purple,
              price: "5.00",
              priceCategory: "one-time",
              listOfWhys: [
                "Add 3 savings goals",
                "Full statistics & charts",
                "Color customization",
                "Progress tracking",
                "Priority support",
              ],
            ),
            PlanCard(
              planTitle: "Unlimited",
              icon: Icons.sunny,
              func: () {},
              buttonText: "Get Unlimited",
              dreamCount: "Unlimited",
              mainColor: colors.orange,
              price: "29.99",
              priceCategory: "lifetime",
              listOfWhys: [
                "Unlimited savings goals",
                "Full statistics & charts",
                "Color customization",
                "Progress tracking",
                "Priority support",
                "Early access to new features",
                "Lifetime updates",
              ],
            ),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildCurrentPlanSection(
    ColorScheme colorScheme,
    AppColors colors,
    ConstTexts texts,
  ) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.tertiary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: colorScheme.outline, width: 1.5.r),
          ),
          child: Column(
            spacing: 15.h,
            children: [
              Row(
                spacing: 15.w,
                children: [
                  Container(
                    height: 50.r,
                    width: 50.r,
                    decoration: BoxDecoration(
                      color: colors.purple.withValues(alpha: 0.2),
                      border: Border.all(color: colors.purple, width: 1.5.r),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.verified,
                      color: colors.white,
                      size: 24.r,
                    ),
                  ),
                  Column(
                    spacing: 3.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        texts.currentPlan,
                        style: AppTextStyles.roboto.medium(
                          fontSize: 18.sp,
                          color: colorScheme.primary,
                        ),
                      ),
                      Text(
                        texts.freeVersion,
                        style: AppTextStyles.roboto.medium(
                          fontSize: 15.sp,
                          color: colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: colorScheme.tertiary.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  spacing: 5.h,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          texts.freeVersion,
                          style: AppTextStyles.roboto.medium(
                            fontSize: 15.sp,
                            color: colorScheme.secondary,
                          ),
                        ),
                        Text(
                          "1 / 2",
                          style: AppTextStyles.roboto.medium(
                            fontSize: 16.sp,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 1 / 2,
                            color: colors.purple,
                            backgroundColor: colorScheme.tertiary,
                            minHeight: 9.h,
                            borderRadius: BorderRadius.circular(8.r),
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
    );
  }

  SliverAppBar _buildAppBarSection(
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
            child: Icon(Icons.star, color: colors.white, size: 24.r),
          ),
          Column(
            spacing: 3.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                texts.premiumPlans,
                style: AppTextStyles.roboto.medium(
                  fontSize: 18.sp,
                  color: colorScheme.primary,
                ),
              ),
              Text(
                texts.unlockDreams,
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
