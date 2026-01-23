import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/premium/presentation/screens/premium_screen.dart';
import 'package:boilerplate/features/premium/presentation/widgets/plan_why_row_wd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.mainColor,
    required this.buttonText,
    required this.dreamCount,
    required this.planTitle,
    required this.price,
    required this.priceCategory,
    required this.listOfWhys,
    required this.icon,
    required this.func,
  });
  final IconData icon;
  final Color mainColor;
  final String planTitle, price, dreamCount, priceCategory, buttonText;
  final List<String> listOfWhys;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => InkWell(
        onTap: func,
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.tertiary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: mainColor, width: 1.5.r),
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
                      color: mainColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(icon, color: colors.white, size: 24.r),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 3.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          planTitle,
                          style: AppTextStyles.roboto.medium(
                            fontSize: 18.sp,
                            color: colorScheme.primary,
                          ),
                        ),
                        Text(
                          "$dreamCount dream",
                          style: AppTextStyles.roboto.medium(
                            fontSize: 15.sp,
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
                        "\$$price",
                        style: AppTextStyles.roboto.medium(
                          fontSize: 22.sp,
                          color: colorScheme.primary,
                        ),
                      ),
                      Text(
                        priceCategory,
                        style: AppTextStyles.roboto.regular(
                          fontSize: 15.sp,
                          color: colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                spacing: 9.h,
                children: [
                  for (String elem in listOfWhys)
                    PlanWhyRow(mainColor: mainColor, title: elem),
                ],
              ),
              Container(
                height: 50.h,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: mainColor,
                ),
                child: Text(
                  buttonText,
                  style: AppTextStyles.roboto.medium(
                    fontSize: 18.sp,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
