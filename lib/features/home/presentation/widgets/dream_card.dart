import 'dart:developer';
import 'package:boilerplate/core/common/widgets/custom_height_wd.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_router.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/home/presentation/screens/statistics_screen.dart';
import 'package:boilerplate/features/home/presentation/widgets/custom_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DreamCard extends HookWidget {
  const DreamCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdding = useState(true);
    final amountController = useTextEditingController();
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          border: Border.all(color: colorScheme.outline, width: 1.3.r),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          spacing: 15.h,
          children: [
            // Title & Actions Part
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 7.h,
                  children: [
                    Row(
                      spacing: 9.w,
                      children: [
                        Container(
                          height: 20.r,
                          width: 6.r,
                          decoration: BoxDecoration(
                            color: colors.purple,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        Text(
                          "Dream Car",
                          style: AppTextStyles.roboto.bold(
                            fontSize: 18.sp,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 5.w,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 16.r,
                          color: colorScheme.secondary,
                        ),
                        Text(
                          "6/15/2026",
                          style: AppTextStyles.roboto.medium(
                            fontSize: 16.sp,
                            color: colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  spacing: 9.w,
                  children: [
                    InkWell(
                      onTap: () {
                        log("Update Card Clicked...");
                      },
                      child: Container(
                        height: 35.r,
                        width: 35.r,
                        decoration: BoxDecoration(
                          color: colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.edit,
                          size: 18.r,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        log("Delete Goal Tapped");
                      },
                      child: Container(
                        height: 35.r,
                        width: 35.r,
                        decoration: BoxDecoration(
                          color: colors.red.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.delete,
                          size: 18.r,
                          color: colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // Progress Part
            Column(
              spacing: 5.h,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      texts.current,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 14.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Text(
                      texts.target,
                      style: AppTextStyles.roboto.medium(
                        fontSize: 14.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$8.500",
                      style: AppTextStyles.roboto.medium(
                        fontSize: 25.sp,
                        color: colorScheme.primary,
                      ),
                    ),
                    Text(
                      "\$12,000",
                      style: AppTextStyles.roboto.medium(
                        fontSize: 20.sp,
                        color: colorScheme.primary.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.75,
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
                      "55%",
                      style: AppTextStyles.roboto.medium(
                        fontSize: 14.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "\$4.500 ${texts.leftLower}",
                      style: AppTextStyles.roboto.medium(
                        fontSize: 14.sp,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Actions Part
            Row(
              spacing: 9.w,
              children: [
                CustomActionButton(
                  title: texts.update,
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => Dialog(
                        insetPadding: EdgeInsets.symmetric(
                          horizontal: 16.r,
                          vertical: 0,
                        ),
                        child: Container(
                          height: 450.h,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 16.r),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            border: Border.all(
                              color: colorScheme.outline,
                              width: 1.5.r,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 16.r,
                                ),
                                child: Row(
                                  spacing: 15.w,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Update Savings",
                                            style: AppTextStyles.roboto.medium(
                                              fontSize: 18.sp,
                                              color: colorScheme.primary,
                                            ),
                                          ),
                                          Text(
                                            "Dream Car",
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.roboto.regular(
                                              fontSize: 16.sp,
                                              color: colorScheme.secondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        AppRouter.close();
                                      },
                                      child: Container(
                                        height: 40.r,
                                        width: 40.r,
                                        decoration: BoxDecoration(
                                          color: colorScheme.tertiary,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: colors.primaryDark,
                                          size: 21.r,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: colorScheme.outline,
                                thickness: 1.5.r,
                                height: 20.h,
                              ),
                              Height(height: 10),
                              Container(
                                height: 45.h,
                                margin: EdgeInsets.symmetric(horizontal: 16.r),
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: colorScheme.tertiary.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          isAdding.value = true;
                                        },
                                        child: Container(
                                          height: 45.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            color: isAdding.value
                                                ? colorScheme.tertiary
                                                      .withValues(alpha: 0.6)
                                                : colors.transparent,
                                          ),
                                          child: Row(
                                            spacing: 7.w,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_rounded,
                                                size: 21.r,
                                                color: isAdding.value
                                                    ? colorScheme.primary
                                                    : colorScheme.secondary,
                                              ),
                                              Text(
                                                texts.add,
                                                style: AppTextStyles.roboto
                                                    .medium(
                                                      fontSize: 14.sp,
                                                      color: isAdding.value
                                                          ? colorScheme.primary
                                                          : colorScheme
                                                                .secondary,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          isAdding.value = false;
                                        },
                                        child: Container(
                                          height: 45.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                            color: !isAdding.value
                                                ? colorScheme.tertiary
                                                      .withValues(alpha: 0.6)
                                                : colors.transparent,
                                          ),
                                          child: Row(
                                            spacing: 7.w,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.remove_rounded,
                                                size: 21.r,
                                                color: !isAdding.value
                                                    ? colorScheme.primary
                                                    : colorScheme.secondary,
                                              ),
                                              Text(
                                                texts.remove,
                                                style: AppTextStyles.roboto
                                                    .medium(
                                                      fontSize: 14.sp,
                                                      color: !isAdding.value
                                                          ? colorScheme.primary
                                                          : colorScheme
                                                                .secondary,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Height(height: 15),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.r),
                                child: Text(
                                  "Amount",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.roboto.regular(
                                    fontSize: 16.sp,
                                    color: colorScheme.secondary,
                                  ),
                                ),
                              ),
                              Height(height: 5),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.r),
                                child: TextField(
                                  controller: amountController,
                                  cursorColor: colorScheme.primary,
                                  style: AppTextStyles.roboto
                                      .medium(
                                        fontSize: 16.sp,
                                        color: colorScheme.primary,
                                      )
                                      .copyWith(
                                        decoration: TextDecoration.none,
                                        decorationColor: colors.transparent,
                                        decorationThickness: 0,
                                      ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.attach_money_outlined,
                                    ),
                                    hint: Text(
                                      "0.00",
                                      style: AppTextStyles.roboto.medium(
                                        fontSize: 16.sp,
                                        color: colorScheme.secondary,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: colorScheme.tertiary.withValues(
                                      alpha: 0.3,
                                    ),
                                    focusColor: colors.transparent,
                                    hoverColor: colors.transparent,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                        color: colorScheme.tertiary,
                                        width: 1.5.r,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(12.r),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide(
                                        color: colorScheme.tertiary,
                                        width: 1.5.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Height(height: 15),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.r),
                                child: Text(
                                  "Quick Select",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.roboto.regular(
                                    fontSize: 16.sp,
                                    color: colorScheme.secondary,
                                  ),
                                ),
                              ),
                              Height(height: 5),
                              Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 16.r,
                                ),
                                child: Column(
                                  spacing: 8.h,
                                  children: [
                                    Row(
                                      spacing: 8.w,
                                      children: [
                                        QuickOptionCard(amount: 10),
                                        QuickOptionCard(amount: 25),
                                        QuickOptionCard(amount: 50),
                                      ],
                                    ),
                                    Row(
                                      spacing: 8.w,
                                      children: [
                                        QuickOptionCard(amount: 100),
                                        QuickOptionCard(amount: 250),
                                        QuickOptionCard(amount: 500),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Height(height: 20),
                              Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 16.r,
                                ),
                                child: CustomActionButton(
                                  title: "Add \$10",
                                  onTap: () {},
                                  mainColor: colors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  mainColor: colors.purple,
                ),
                CustomActionButton(
                  title: texts.stats,
                  onTap: () {
                    log("Stats Goal Tapped");
                    AppRouter.go(StatisticsScreen());
                  },
                  mainColor: colorScheme.tertiary,
                ),
                Container(
                  height: 45.r,
                  width: 45.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 24.r,
                    color: colorScheme.primary,
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

class QuickOptionCard extends StatelessWidget {
  const QuickOptionCard({super.key, required this.amount});
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppStateWrapper(
        builder: (colors, texts, colorScheme) => InkWell(
          onTap: () {},
          child: Container(
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colorScheme.tertiary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              "\$$amount",
              style: AppTextStyles.roboto.medium(
                fontSize: 14.sp,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
