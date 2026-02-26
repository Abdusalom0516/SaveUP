import 'package:boilerplate/core/common/widgets/custom_height_wd.dart';
import 'package:boilerplate/core/constants/const_texts.dart';
import 'package:boilerplate/core/design_system/app_colors.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_router.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/add_dream/presentation/widgets/colors_option_card_wd.dart';
import 'package:boilerplate/features/home/data/models/model.dart';
import 'package:boilerplate/features/home/presentation/blocs/bloc.dart';
import 'package:boilerplate/features/home/presentation/screens/statistics_screen.dart';
import 'package:boilerplate/features/home/presentation/widgets/custom_action_button.dart';
import 'package:boilerplate/features/home/presentation/widgets/quick_option_card_wd.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

String _fmt(double amount) {
  if (amount >= 1000) return '\$${NumberFormat('#,##0', 'en_US').format(amount)}';
  return '\$${amount.toStringAsFixed(0)}';
}

Color _colorFromIndex(int index, AppColors colors) {
  switch (index) {
    case 1:
      return colors.blue;
    case 2:
      return colors.pink;
    case 3:
      return colors.green;
    case 4:
      return colors.orange;
    default:
      return colors.purple;
  }
}

// ─── Main Card ──────────────────────────────────────────────────────────────

class DreamCard extends HookWidget {
  const DreamCard({super.key, required this.dream});

  final DreamModel dream;

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    return AppStateWrapper(
      builder: (colors, texts, colorScheme) {
        final cardColor = _colorFromIndex(dream.colorIndex, colors);
        return Container(
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
              // Title & Actions
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
                              color: cardColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          Text(
                            dream.name,
                            style: AppTextStyles.roboto.bold(fontSize: 18.sp, color: colorScheme.primary),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 5.w,
                        children: [
                          Icon(Icons.calendar_month, size: 16.r, color: colorScheme.secondary),
                          Text(
                            dream.formattedDeadline,
                            style: AppTextStyles.roboto.medium(fontSize: 16.sp, color: colorScheme.secondary),
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
                          final cubit = context.read<DreamsCubit>();
                          showDialog(
                            context: context,
                            builder: (_) => _EditDreamDialog(
                              dream: dream,
                              cubit: cubit,
                              colors: colors,
                              texts: texts,
                              colorScheme: colorScheme,
                            ),
                          );
                        },
                        child: Container(
                          height: 35.r,
                          width: 35.r,
                          decoration: BoxDecoration(
                            color: colorScheme.tertiary,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(Icons.edit, size: 18.r, color: colorScheme.primary),
                        ),
                      ),
                      InkWell(
                        onTap: () => _confirmDelete(context, colors, colorScheme),
                        child: Container(
                          height: 35.r,
                          width: 35.r,
                          decoration: BoxDecoration(
                            color: colors.red.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(Icons.delete, size: 18.r, color: colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Progress
              Column(
                spacing: 5.h,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(texts.current, style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary)),
                      Text(texts.target, style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_fmt(dream.currentAmount), style: AppTextStyles.roboto.medium(fontSize: 25.sp, color: colorScheme.primary)),
                      Text(_fmt(dream.targetAmount), style: AppTextStyles.roboto.medium(fontSize: 20.sp, color: colorScheme.primary.withValues(alpha: 0.5))),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          value: dream.progressRatio,
                          color: cardColor,
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
                      Text("${dream.progressPercent}%", style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary)),
                      Text("${_fmt(dream.remaining)} ${texts.leftLower}", style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary)),
                    ],
                  ),
                ],
              ),

              // Action Buttons
              Row(
                spacing: 9.w,
                children: [
                  CustomActionButton(
                    title: texts.update,
                    onTap: () {
                      final cubit = context.read<DreamsCubit>();
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => _UpdateSavingsDialog(
                          dream: dream,
                          cubit: cubit,
                          colors: colors,
                          texts: texts,
                          colorScheme: colorScheme,
                        ),
                      );
                    },
                    mainColor: cardColor,
                  ),
                  CustomActionButton(
                    title: texts.stats,
                    onTap: () => AppRouter.go(StatisticsScreen(dream: dream)),
                    mainColor: colorScheme.tertiary,
                  ),
                  InkWell(
                    onTap: () => isExpanded.value = !isExpanded.value,
                    borderRadius: BorderRadius.circular(15.r),
                    child: Container(
                      height: 45.r,
                      width: 45.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: AnimatedRotation(
                        turns: isExpanded.value ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Icon(Icons.keyboard_arrow_down_rounded, size: 24.r, color: colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),

              // Expandable Stats
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: isExpanded.value
                    ? _buildExpandedStats(colors, colorScheme)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, AppColors colors, ColorScheme colorScheme) {
    final cubit = context.read<DreamsCubit>();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: colorScheme.outline, width: 1.3.r),
        ),
        title: Text("Delete Goal", style: AppTextStyles.roboto.medium(fontSize: 18.sp, color: colorScheme.primary)),
        content: Text(
          'Delete "${dream.name}"? This cannot be undone.',
          style: AppTextStyles.roboto.regular(fontSize: 15.sp, color: colorScheme.secondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Cancel", style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              cubit.deleteDream(dream.id);
              toastification.show(
                context: context,
                type: ToastificationType.success,
                style: ToastificationStyle.flat,
                title: const Text('Goal deleted'),
                autoCloseDuration: const Duration(seconds: 2),
              );
            },
            child: Text("Delete", style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedStats(AppColors colors, ColorScheme colorScheme) {
    final cardColor = _colorFromIndex(dream.colorIndex, colors);
    return Column(
      children: [
        Divider(color: colorScheme.outline, thickness: 1.3.r, height: 1),
        SizedBox(height: 15.h),
        Row(
          spacing: 10.w,
          children: [
            Expanded(child: _miniStatCard("Days Left", "${dream.daysLeft}", colorScheme)),
            Expanded(child: _miniStatCard("Monthly Need", _fmt(dream.monthlyNeed), colorScheme)),
          ],
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: colorScheme.tertiary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Progress Chart", style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.primary)),
              SizedBox(height: 12.h),
              SizedBox(
                height: 180.h,
                child: LineChart(_buildChartData(colors, colorScheme, cardColor)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _miniStatCard(String title, String value, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 14.r),
      decoration: BoxDecoration(
        color: colorScheme.tertiary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.roboto.medium(fontSize: 13.sp, color: colorScheme.secondary)),
          SizedBox(height: 6.h),
          Text(value, style: AppTextStyles.roboto.bold(fontSize: 22.sp, color: colorScheme.primary)),
        ],
      ),
    );
  }

  LineChartData _buildChartData(AppColors colors, ColorScheme colorScheme, Color cardColor) {
    final spots = _buildChartSpots();
    final maxY = dream.targetAmount > 0
        ? (dream.targetAmount * 1.1).ceilToDouble()
        : (dream.currentAmount * 1.5 + 100).ceilToDouble();

    return LineChartData(
      minX: 0,
      maxX: (spots.length - 1).toDouble().clamp(1, double.infinity),
      minY: 0,
      maxY: maxY,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: maxY / 4,
        getDrawingHorizontalLine: (_) => FlLine(
          color: colorScheme.outline.withValues(alpha: 0.4),
          strokeWidth: 1,
        ),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 52.w,
            interval: maxY / 4,
            getTitlesWidget: (value, _) => Text(
              _fmtCompact(value),
              style: AppTextStyles.roboto.regular(fontSize: 10.sp, color: colorScheme.secondary),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28.h,
            interval: (spots.length / 4).ceilToDouble().clamp(1, double.infinity),
            getTitlesWidget: (value, _) {
              final idx = value.toInt();
              if (idx < 0 || idx >= dream.contributions.length) return const SizedBox.shrink();
              final sorted = [...dream.contributions]..sort((a, b) => a.createdAt.compareTo(b.createdAt));
              return Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Text(
                  DateFormat('MMM').format(sorted[idx].createdAt),
                  style: AppTextStyles.roboto.regular(fontSize: 9.sp, color: colorScheme.secondary),
                ),
              );
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          curveSmoothness: 0.35,
          color: cardColor,
          barWidth: 2.5.r,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [cardColor.withValues(alpha: 0.4), cardColor.withValues(alpha: 0.05)],
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _buildChartSpots() {
    if (dream.contributions.isEmpty) {
      return [const FlSpot(0, 0), FlSpot(1, dream.currentAmount)];
    }
    final sorted = [...dream.contributions]
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    double cumulative = 0;
    final spots = <FlSpot>[];
    for (int i = 0; i < sorted.length; i++) {
      cumulative = (cumulative + sorted[i].amount).clamp(0.0, dream.targetAmount);
      spots.add(FlSpot(i.toDouble(), cumulative));
    }
    if (spots.length == 1) spots.insert(0, const FlSpot(0, 0));
    return spots;
  }

  String _fmtCompact(double amount) {
    if (amount >= 1000000) return '\$${(amount / 1000000).toStringAsFixed(1)}M';
    if (amount >= 1000) return '\$${(amount / 1000).toStringAsFixed(0)}k';
    return '\$${amount.toStringAsFixed(0)}';
  }
}

// ─── Update Savings Dialog ──────────────────────────────────────────────────

class _UpdateSavingsDialog extends HookWidget {
  const _UpdateSavingsDialog({
    required this.dream,
    required this.cubit,
    required this.colors,
    required this.texts,
    required this.colorScheme,
  });

  final DreamModel dream;
  final DreamsCubit cubit;
  final AppColors colors;
  final ConstTexts texts;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final isAdding = useState(true);
    final amountController = useTextEditingController();
    final amountValue = useValueListenable(amountController);
    final parsedAmount = double.tryParse(amountValue.text.trim()) ?? 0;
    final buttonLabel = parsedAmount > 0
        ? "${isAdding.value ? texts.add : texts.remove} ${_fmt(parsedAmount)}"
        : isAdding.value ? texts.add : texts.remove;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 0),
      child: Container(
        height: 450.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.r),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          border: Border.all(color: colorScheme.outline, width: 1.5.r),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
              child: Row(
                spacing: 15.w,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(texts.updateSavings, style: AppTextStyles.roboto.medium(fontSize: 18.sp, color: colorScheme.primary)),
                        Text(dream.name, overflow: TextOverflow.ellipsis, style: AppTextStyles.roboto.regular(fontSize: 16.sp, color: colorScheme.secondary)),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => AppRouter.close(),
                    child: Container(
                      height: 40.r,
                      width: 40.r,
                      decoration: BoxDecoration(color: colorScheme.tertiary, borderRadius: BorderRadius.circular(12.r)),
                      child: Icon(Icons.close, color: colors.primaryDark, size: 21.r),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: colorScheme.outline, thickness: 1.5.r, height: 20.h),
            Height(height: 10),
            // Add / Remove toggle
            Container(
              height: 45.h,
              margin: EdgeInsets.symmetric(horizontal: 16.r),
              padding: EdgeInsets.all(4.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: colorScheme.tertiary.withValues(alpha: 0.2),
              ),
              child: Row(
                children: [
                  _toggleOption(texts.add, Icons.add_rounded, isAdding.value, () => isAdding.value = true, colorScheme, colors),
                  _toggleOption(texts.remove, Icons.remove_rounded, !isAdding.value, () => isAdding.value = false, colorScheme, colors),
                ],
              ),
            ),
            Height(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Text("Amount", overflow: TextOverflow.ellipsis, style: AppTextStyles.roboto.regular(fontSize: 16.sp, color: colorScheme.secondary)),
            ),
            Height(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: TextField(
                controller: amountController,
                cursorColor: colorScheme.primary,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: AppTextStyles.roboto.medium(fontSize: 16.sp, color: colorScheme.primary).copyWith(
                  decoration: TextDecoration.none,
                  decorationColor: colors.transparent,
                  decorationThickness: 0,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.attach_money_outlined),
                  hint: Text("0.00", style: AppTextStyles.roboto.medium(fontSize: 16.sp, color: colorScheme.secondary)),
                  filled: true,
                  fillColor: colorScheme.tertiary.withValues(alpha: 0.3),
                  focusColor: colors.transparent,
                  hoverColor: colors.transparent,
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: colorScheme.tertiary, width: 1.5.r)),
                  contentPadding: EdgeInsets.all(12.r),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: colorScheme.tertiary, width: 1.5.r)),
                ),
              ),
            ),
            Height(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.r),
              child: Text(texts.quickSelect, overflow: TextOverflow.ellipsis, style: AppTextStyles.roboto.regular(fontSize: 16.sp, color: colorScheme.secondary)),
            ),
            Height(height: 5),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
              child: Column(
                spacing: 8.h,
                children: [
                  Row(
                    spacing: 8.w,
                    children: [
                      QuickOptionCard(amount: 10, func: () => amountController.text = "10"),
                      QuickOptionCard(amount: 25, func: () => amountController.text = "25"),
                      QuickOptionCard(amount: 50, func: () => amountController.text = "50"),
                    ],
                  ),
                  Row(
                    spacing: 8.w,
                    children: [
                      QuickOptionCard(amount: 100, func: () => amountController.text = "100"),
                      QuickOptionCard(amount: 250, func: () => amountController.text = "250"),
                      QuickOptionCard(amount: 500, func: () => amountController.text = "500"),
                    ],
                  ),
                ],
              ),
            ),
            Height(height: 20),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.r),
              child: CustomActionButton(
                title: buttonLabel,
                onTap: () {
                  final amount = double.tryParse(amountController.text.trim()) ?? 0;
                  if (amount <= 0) return;
                  cubit.addContribution(
                    dreamId: dream.id,
                    amount: amount,
                    isAdding: isAdding.value,
                  );
                  AppRouter.close();
                  toastification.show(
                    context: context,
                    type: ToastificationType.success,
                    style: ToastificationStyle.flat,
                    title: Text(isAdding.value ? 'Savings added!' : 'Amount removed'),
                    autoCloseDuration: const Duration(seconds: 2),
                  );
                },
                mainColor: colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _toggleOption(
    String label,
    IconData icon,
    bool isActive,
    VoidCallback onTap,
    ColorScheme colorScheme,
    AppColors colors,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 45.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: isActive ? colorScheme.tertiary.withValues(alpha: 0.6) : colors.transparent,
          ),
          child: Row(
            spacing: 7.w,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 21.r, color: isActive ? colorScheme.primary : colorScheme.secondary),
              Text(label, style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: isActive ? colorScheme.primary : colorScheme.secondary)),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Edit Dream Dialog ───────────────────────────────────────────────────────

class _EditDreamDialog extends HookWidget {
  const _EditDreamDialog({
    required this.dream,
    required this.cubit,
    required this.colors,
    required this.texts,
    required this.colorScheme,
  });

  final DreamModel dream;
  final DreamsCubit cubit;
  final AppColors colors;
  final ConstTexts texts;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController(text: dream.name);
    final targetController = useTextEditingController(text: dream.targetAmount.toStringAsFixed(0));
    final colorIndex = useState(dream.colorIndex);
    final deadline = useState(dream.deadline);

    final colorOptions = [colors.purple, colors.blue, colors.pink, colors.green, colors.orange];

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 40.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          border: Border.all(color: colorScheme.outline, width: 1.5.r),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Edit Goal", style: AppTextStyles.roboto.medium(fontSize: 18.sp, color: colorScheme.primary)),
                  InkWell(
                    onTap: () => AppRouter.close(),
                    child: Container(
                      height: 36.r,
                      width: 36.r,
                      decoration: BoxDecoration(color: colorScheme.tertiary, borderRadius: BorderRadius.circular(10.r)),
                      child: Icon(Icons.close, color: colors.primaryDark, size: 18.r),
                    ),
                  ),
                ],
              ),
              Divider(color: colorScheme.outline, thickness: 1.3.r, height: 1),
              _fieldLabel("Goal Name", colorScheme),
              _textField(nameController, "Name", colorScheme),
              _fieldLabel("Target Amount", colorScheme),
              _textField(targetController, "Amount", colorScheme, keyboardType: TextInputType.number),
              _fieldLabel("Deadline", colorScheme),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: deadline.value,
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 365 * 20)),
                  );
                  if (picked != null) deadline.value = picked;
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: colorScheme.tertiary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: colorScheme.outline, width: 1.5.r),
                  ),
                  child: Row(
                    spacing: 8.w,
                    children: [
                      Icon(Icons.calendar_today_outlined, color: colorScheme.secondary, size: 18.r),
                      Text(
                        DateFormat('MMMM d, yyyy').format(deadline.value),
                        style: AppTextStyles.roboto.medium(fontSize: 15.sp, color: colorScheme.primary),
                      ),
                    ],
                  ),
                ),
              ),
              _fieldLabel("Color", colorScheme),
              Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: List.generate(
                  colorOptions.length,
                  (i) => ColorsOptionCard(
                    mainColor: colorOptions[i],
                    isChosen: colorIndex.value == i,
                    func: () => colorIndex.value = i,
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  CustomActionButton(
                    title: "Save Changes",
                    onTap: () {
                      final name = nameController.text.trim();
                      final target = double.tryParse(targetController.text.replaceAll(',', '')) ?? 0;
                      if (name.isEmpty || target <= 0) return;
                      cubit.updateDream(dream.copyWith(
                        name: name,
                        targetAmount: target,
                        colorIndex: colorIndex.value,
                        deadline: deadline.value,
                      ));
                      AppRouter.close();
                      toastification.show(
                        context: context,
                        type: ToastificationType.success,
                        style: ToastificationStyle.flat,
                        title: const Text('Goal updated!'),
                        autoCloseDuration: const Duration(seconds: 2),
                      );
                    },
                    mainColor: colors.purple,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String label, ColorScheme colorScheme) {
    return Text(label, style: AppTextStyles.roboto.medium(fontSize: 14.sp, color: colorScheme.secondary));
  }

  Widget _textField(TextEditingController ctrl, String hint, ColorScheme colorScheme, {TextInputType? keyboardType}) {
    return TextField(
      controller: ctrl,
      cursorColor: colorScheme.primary,
      keyboardType: keyboardType,
      style: AppTextStyles.roboto.medium(fontSize: 16.sp, color: colorScheme.primary).copyWith(
        decoration: TextDecoration.none,
        decorationColor: Colors.transparent,
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        hint: Text(hint, style: AppTextStyles.roboto.medium(fontSize: 16.sp, color: colorScheme.secondary)),
        filled: true,
        fillColor: colorScheme.tertiary.withValues(alpha: 0.2),
        contentPadding: EdgeInsets.all(12.r),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: colorScheme.outline, width: 1.5.r)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide(color: colorScheme.outline, width: 1.5.r)),
      ),
    );
  }
}
