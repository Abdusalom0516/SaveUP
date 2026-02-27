import 'package:boilerplate/core/common/widgets/custom_sliver_height_wd.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/home/data/models/model.dart';
import 'package:boilerplate/features/home/presentation/blocs/bloc.dart';
import 'package:boilerplate/features/home/presentation/widgets/dream_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArchivedDreamsScreen extends StatelessWidget {
  const ArchivedDreamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DreamsCubit, DreamsState>(
      builder: (context, state) {
        return AppStateWrapper(
          builder: (colors, texts, colorScheme) {
            final completed = state is DreamsLoaded
                ? state.dreams.where((d) => d.isCompleted).toList()
                : <DreamModel>[];

            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    shape: Border(
                      bottom: BorderSide(
                        color: colorScheme.outline,
                        width: 1.5.r,
                      ),
                    ),
                    floating: true,
                    pinned: true,
                    toolbarHeight: 70.h,
                    title: Row(
                      spacing: 10.r,
                      children: [
                        Container(
                          height: 42.r,
                          width: 42.r,
                          decoration: BoxDecoration(
                            color: colors.green.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.check_circle_outline_rounded,
                            color: colors.green,
                            size: 24.r,
                          ),
                        ),
                        Text(
                          'Archived Goals',
                          style: AppTextStyles.roboto.bold(
                            fontSize: 21.sp,
                            color: colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is DreamsLoading)
                    SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 60.h),
                          child: CircularProgressIndicator(
                            color: colors.accent,
                          ),
                        ),
                      ),
                    )
                  else if (completed.isEmpty)
                    SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 60.h),
                          child: Column(
                            spacing: 12.h,
                            children: [
                              Icon(
                                Icons.emoji_events_outlined,
                                size: 56.r,
                                color: colorScheme.secondary,
                              ),
                              Text(
                                "No completed goals yet",
                                style: AppTextStyles.roboto.medium(
                                  fontSize: 18.sp,
                                  color: colorScheme.primary,
                                ),
                              ),
                              Text(
                                "Reach 100% on a goal to archive it here",
                                style: AppTextStyles.roboto.regular(
                                  fontSize: 14.sp,
                                  color: colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else ...[
                    SliverHeight(height: 20),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.r,
                            vertical: 8.r,
                          ),
                          decoration: BoxDecoration(
                            color: colors.green.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: colors.green.withValues(alpha: 0.35),
                              width: 1.r,
                            ),
                          ),
                          child: Row(
                            spacing: 8.w,
                            children: [
                              Icon(
                                Icons.check_circle_rounded,
                                color: colors.green,
                                size: 18.r,
                              ),
                              Text(
                                "${completed.length} goal${completed.length == 1 ? '' : 's'} completed",
                                style: AppTextStyles.roboto.medium(
                                  fontSize: 14.sp,
                                  color: colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverHeight(height: 15),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 16.r),
                      sliver: SliverList.builder(
                        itemCount: completed.length,
                        itemBuilder: (context, index) => DreamCard(
                          dream: completed[index],
                          isArchiveView: true,
                        ),
                      ),
                    ),
                  ],
                  SliverHeight(height: 95),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
