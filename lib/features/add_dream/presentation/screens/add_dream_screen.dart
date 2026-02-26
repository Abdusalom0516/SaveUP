import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/add_dream/presentation/widgets/colors_option_card_wd.dart';
import 'package:boilerplate/features/home/presentation/blocs/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class AddDreamScreen extends HookWidget {
  const AddDreamScreen({super.key, required this.onGoalCreated});

  final VoidCallback onGoalCreated;

  @override
  Widget build(BuildContext context) {
    final goalNameController = useTextEditingController();
    final targetAmountController = useTextEditingController();
    final startingAmountController = useTextEditingController();
    final chosenColorIndex = useState(0);
    final chosenDeadline = useState<DateTime?>(null);

    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildAppBarSection(colorScheme, texts, colors),
            SliverHeight(height: 20),
            _buildFieldsSection(
              colors,
              colorScheme,
              goalNameController,
              targetAmountController,
              startingAmountController,
              chosenColorIndex,
              chosenDeadline,
              context,
            ),
            SliverHeight(height: 35),
            _buildCreateDreamButtonSection(
              colorScheme,
              colors,
              onTap: () => _onCreateTapped(
                context,
                goalNameController,
                targetAmountController,
                startingAmountController,
                chosenColorIndex.value,
                chosenDeadline.value,
              ),
            ),
            SliverHeight(height: 40),
          ],
        ),
      ),
    );
  }

  void _onCreateTapped(
    BuildContext context,
    TextEditingController nameCtrl,
    TextEditingController targetCtrl,
    TextEditingController startCtrl,
    int colorIndex,
    DateTime? deadline,
  ) {
    final name = nameCtrl.text.trim();
    final target = double.tryParse(targetCtrl.text.replaceAll(',', '')) ?? 0;
    final start = double.tryParse(startCtrl.text.replaceAll(',', '')) ?? 0;

    if (name.isEmpty) {
      _showError(context, 'Please enter a goal name.');
      return;
    }
    if (target <= 0) {
      _showError(context, 'Please enter a valid target amount.');
      return;
    }
    if (deadline == null) {
      _showError(context, 'Please select a deadline.');
      return;
    }

    context.read<DreamsCubit>().createDream(
          name: name,
          targetAmount: target,
          startingAmount: start,
          colorIndex: colorIndex,
          deadline: deadline,
        );

    nameCtrl.clear();
    targetCtrl.clear();
    startCtrl.clear();

    onGoalCreated();

    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flat,
      title: const Text('Goal created!'),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  void _showError(BuildContext context, String message) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flat,
      title: Text(message),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  SliverPadding _buildCreateDreamButtonSection(
    ColorScheme colorScheme,
    AppColors colors, {
    required VoidCallback onTap,
  }) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
      sliver: SliverToBoxAdapter(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
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
      ),
    );
  }

  SliverPadding _buildFieldsSection(
    AppColors colors,
    ColorScheme colorScheme,
    TextEditingController goalNameController,
    TextEditingController targetAmountController,
    TextEditingController startingAmountController,
    ValueNotifier<int> chosenColorIndex,
    ValueNotifier<DateTime?> chosenDeadline,
    BuildContext context,
  ) {
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
              hint: "Travel to Japan",
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
              keyboardType: TextInputType.number,
            ),
            _buildTitleWithTextfield(
              colors: colors,
              colorScheme: colorScheme,
              controller: startingAmountController,
              hint: "0",
              mainIcon: Icons.attach_money_outlined,
              secondaryIcon: Icons.attach_money_outlined,
              title: "Starting Amount",
              keyboardType: TextInputType.number,
            ),
            Column(
              spacing: 7.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 8.w,
                  children: [
                    Icon(Icons.calendar_month_outlined, color: colorScheme.secondary, size: 21.r),
                    Text(
                      "Deadline",
                      style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.secondary),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: chosenDeadline.value ?? DateTime.now().add(const Duration(days: 365)),
                      firstDate: DateTime.now().add(const Duration(days: 1)),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
                    );
                    if (picked != null) chosenDeadline.value = picked;
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colorScheme.outline, width: 1.5.r),
                    ),
                    child: Row(
                      spacing: 8.w,
                      children: [
                        Icon(Icons.calendar_today_outlined, color: colorScheme.secondary, size: 18.r),
                        Text(
                          chosenDeadline.value == null
                              ? "Select deadline..."
                              : DateFormat('MMMM d, yyyy').format(chosenDeadline.value!),
                          style: AppTextStyles.roboto.medium(
                            fontSize: 16.sp,
                            color: chosenDeadline.value == null ? colorScheme.secondary : colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              spacing: 7.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Color",
                  style: AppTextStyles.roboto.medium(fontSize: 16.sp, color: colorScheme.secondary),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    runSpacing: 15.h,
                    spacing: 10.w,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      ColorsOptionCard(mainColor: colors.purple, isChosen: chosenColorIndex.value == 0, func: () => chosenColorIndex.value = 0),
                      ColorsOptionCard(mainColor: colors.blue, isChosen: chosenColorIndex.value == 1, func: () => chosenColorIndex.value = 1),
                      ColorsOptionCard(mainColor: colors.pink, isChosen: chosenColorIndex.value == 2, func: () => chosenColorIndex.value = 2),
                      ColorsOptionCard(mainColor: colors.green, isChosen: chosenColorIndex.value == 3, func: () => chosenColorIndex.value = 3),
                      ColorsOptionCard(mainColor: colors.orange, isChosen: chosenColorIndex.value == 4, func: () => chosenColorIndex.value = 4),
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
    TextInputType? keyboardType,
  }) {
    return Column(
      spacing: 7.h,
      children: [
        Row(
          spacing: 8.w,
          children: [
            Icon(mainIcon, color: colorScheme.secondary, size: 21.r),
            Text(title, style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.secondary)),
          ],
        ),
        TextField(
          controller: controller,
          cursorColor: colorScheme.secondary,
          keyboardType: keyboardType,
          style: AppTextStyles.roboto
              .medium(fontSize: 16.sp, color: colorScheme.secondary)
              .copyWith(decoration: TextDecoration.none, decorationColor: colors.transparent, decorationThickness: 0),
          decoration: InputDecoration(
            prefixIcon: secondaryIcon == null
                ? null
                : Icon(Icons.search, color: colors.secondaryDark, size: 21.r),
            hint: Text(hint, style: AppTextStyles.roboto.medium(fontSize: 16.sp, color: colorScheme.secondary)),
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
      shape: Border(bottom: BorderSide(color: colorScheme.outline, width: 1.5.r)),
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
            decoration: BoxDecoration(color: colors.purple, borderRadius: BorderRadius.circular(16.r)),
            child: Icon(Icons.keyboard_command_key_rounded, color: colors.white, size: 24.r),
          ),
          Column(
            spacing: 3.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("New Goal", style: AppTextStyles.roboto.medium(fontSize: 18.sp, color: colorScheme.primary)),
              Text("Create a savings goal", style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.secondary)),
            ],
          ),
        ],
      ),
    );
  }
}
