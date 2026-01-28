import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddDreamScreen extends HookWidget {
  const AddDreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final goalNameController = useTextEditingController();
    final targetAmountController = useTextEditingController();
    final startingAmountController = useTextEditingController();
    final chosenColorIndex = useState(0);
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Scaffold(
        body: CustomScrollView(
          slivers: [
            // App Bar Section
            _buildAppBarSection(colorScheme, texts, colors),
            SliverHeight(height: 20),
            // Fields Section
            _buildFieldsSection(colors, colorScheme, goalNameController, targetAmountController, startingAmountController, chosenColorIndex),
            SliverHeight(height: 35),
            // Create Dream Button Section
            _buildCreateDreamButtonSection(colorScheme),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildCreateDreamButtonSection(ColorScheme colorScheme) {
    return SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
            sliver: SliverToBoxAdapter(
              child: Container(
                height: 50.h,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  "Create Goal",
                  style: AppTextStyles.roboto.medium(
                    fontSize: 15.sp,
                    color: colorScheme.surface,
                  ),
                ),
              ),
            ),
          );
  }

  SliverPadding _buildFieldsSection(AppColors colors, ColorScheme colorScheme, TextEditingController goalNameController, TextEditingController targetAmountController, TextEditingController startingAmountController, ValueNotifier<int> chosenColorIndex) {
    return SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
            sliver: SliverToBoxAdapter(
              child: Column(
                spacing: 25.h,
                children: [
                  _buildTitleWithTextfield(
                    colors: colors,
                    colorScheme: colorScheme,
                    controller: goalNameController,
                    hint: "Tarvel to Japan",
                    mainIcon: Icons.account_tree_sharp,
                    secondaryIcon: null,
                    title: "Goal Name",
                  ),
                  _buildTitleWithTextfield(
                    colors: colors,
                    colorScheme: colorScheme,
                    controller: targetAmountController,
                    hint: "25 000",
                    mainIcon: Icons.attach_money_outlined,
                    secondaryIcon: Icons.attach_money_outlined,
                    title: "Target Amount",
                  ),
                  _buildTitleWithTextfield(
                    colors: colors,
                    colorScheme: colorScheme,
                    controller: startingAmountController,
                    hint: "0",
                    mainIcon: Icons.attach_money_outlined,
                    secondaryIcon: Icons.attach_money_outlined,
                    title: "Starting Amoun",
                  ),
                  Column(
                    spacing: 7.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: AppTextStyles.roboto.medium(
                          fontSize: 16.sp,
                          color: colorScheme.secondary,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          runSpacing: 15.h,
                          spacing: 10.w,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,

                          children: [
                            ColorOptionCard(
                              mainColor: colors.purple,
                              isChosen: chosenColorIndex.value == 0,
                              func: () {
                                chosenColorIndex.value = 0;
                              },
                            ),
                            ColorOptionCard(
                              mainColor: colors.blue,
                              isChosen: chosenColorIndex.value == 1,
                              func: () {
                                chosenColorIndex.value = 1;
                              },
                            ),
                            ColorOptionCard(
                              mainColor: colors.pink,
                              isChosen: chosenColorIndex.value == 2,
                              func: () {
                                chosenColorIndex.value = 2;
                              },
                            ),
                            ColorOptionCard(
                              mainColor: colors.green,
                              isChosen: chosenColorIndex.value == 3,
                              func: () {
                                chosenColorIndex.value = 3;
                              },
                            ),
                            ColorOptionCard(
                              mainColor: colors.orange,
                              isChosen: chosenColorIndex.value == 4,
                              func: () {
                                chosenColorIndex.value = 4;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildTitleWithTextfield({
    required AppColors colors,
    required ColorScheme colorScheme,
    required IconData mainIcon,
    required String title,
    required TextEditingController controller,
    required IconData? secondaryIcon,
    required String hint,
  }) {
    return Column(
      spacing: 7.h,
      children: [
        Row(
          spacing: 8.w,
          children: [
            Icon(mainIcon, color: colorScheme.secondary, size: 21.r),
            Text(
              title,
              style: AppTextStyles.roboto.medium(
                fontSize: 15.sp,
                color: colorScheme.secondary,
              ),
            ),
          ],
        ),
        TextField(
          controller: controller,
          cursorColor: colorScheme.secondary,
          style: AppTextStyles.roboto
              .medium(fontSize: 16.sp, color: colorScheme.secondary)
              .copyWith(
                decoration: TextDecoration.none,
                decorationColor: colors.transparent,
                decorationThickness: 0,
              ),
          decoration: InputDecoration(
            prefixIcon: secondaryIcon == null
                ? null
                : Icon(Icons.search, color: colors.secondaryDark, size: 21.r),
            hint: Text(
              hint,
              style: AppTextStyles.roboto.medium(
                fontSize: 16.sp,
                color: colorScheme.secondary,
              ),
            ),
            filled: true,
            fillColor: colorScheme.primaryContainer,
            focusColor: colors.transparent,
            hoverColor: colors.transparent,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.outline, width: 1.5.r),
            ),
            contentPadding: EdgeInsets.all(12.r),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.outline, width: 1.5.r),
            ),
          ),
        ),
      ],
    );
  }

  SliverAppBar _buildAppBarSection(
    ColorScheme colorScheme,
    ConstTexts texts,
    AppColors colors,
  ) {
    return SliverAppBar(
      shape: Border(
        bottom: BorderSide(color: colorScheme.outline, width: 1.5.r),
      ),
      floating: true,
      pinned: true,
      toolbarHeight: 70.h,
      centerTitle: false,
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
            child: Icon(
              Icons.keyboard_command_key_rounded,
              color: colors.white,
              size: 24.r,
            ),
          ),
          Column(
            spacing: 3.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Goal",
                style: AppTextStyles.roboto.medium(
                  fontSize: 18.sp,
                  color: colorScheme.primary,
                ),
              ),
              Text(
                "Create a savings goal",
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

class ColorOptionCard extends StatelessWidget {
  const ColorOptionCard({
    super.key,
    required this.mainColor,
    required this.func,
    required this.isChosen,
  });
  final Color mainColor;
  final VoidCallback func;
  final bool isChosen;

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => InkWell(
        onTap: func,
        child: Container(
          height: 45.h,
          width: 75.w,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isChosen ? colors.white : colors.transparent,
              width: 2.5.r,
            ),
          ),
        ),
      ),
    );
  }
}
