import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/add_dream/presentation/screens/add_dream_screen.dart';
import 'package:boilerplate/features/home/presentation/screens/archived_dreams_screen.dart';
import 'package:boilerplate/features/home/presentation/screens/home_screen.dart';
import 'package:boilerplate/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationIndex = useState<int>(0);
    final pageController = usePageController();
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Scaffold(
        extendBody: true,
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomeScreen(),
            const ArchivedDreamsScreen(),
            AddDreamScreen(
              onGoalCreated: () => pageController.jumpToPage(0),
            ),
            const SettingsScreen(),
          ],
        ),
        bottomNavigationBar: _FloatingNavBar(
          selectedIndex: navigationIndex.value,
          accentColor: colors.accent,
          colorScheme: colorScheme,
          onItemSelected: (index) {
            navigationIndex.value = index;
            pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}

// ─── Floating Nav Bar ────────────────────────────────────────────────────────

class _FloatingNavBar extends StatelessWidget {
  const _FloatingNavBar({
    required this.selectedIndex,
    required this.onItemSelected,
    required this.accentColor,
    required this.colorScheme,
  });

  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Color accentColor;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.fromLTRB(16.r, 0, 16.r, 24.r),
        height: 68.h,
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(26.r),
          border: Border.all(color: colorScheme.outline, width: 1.3.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 28,
              spreadRadius: 0,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              outlineIcon: Icons.home_outlined,
              label: "Home",
              index: 0,
              selectedIndex: selectedIndex,
              accentColor: accentColor,
              colorScheme: colorScheme,
              onTap: onItemSelected,
            ),
            _NavItem(
              icon: Icons.check_circle_rounded,
              outlineIcon: Icons.check_circle_outline_rounded,
              label: "Archive",
              index: 1,
              selectedIndex: selectedIndex,
              accentColor: accentColor,
              colorScheme: colorScheme,
              onTap: onItemSelected,
            ),
            _AddNavItem(
              index: 2,
              selectedIndex: selectedIndex,
              accentColor: accentColor,
              onTap: onItemSelected,
            ),
            _NavItem(
              icon: Icons.settings_rounded,
              outlineIcon: Icons.settings_outlined,
              label: "Settings",
              index: 3,
              selectedIndex: selectedIndex,
              accentColor: accentColor,
              colorScheme: colorScheme,
              onTap: onItemSelected,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Regular Nav Item ─────────────────────────────────────────────────────────

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.outlineIcon,
    required this.label,
    required this.index,
    required this.selectedIndex,
    required this.accentColor,
    required this.colorScheme,
    required this.onTap,
  });

  final IconData icon;
  final IconData outlineIcon;
  final String label;
  final int index;
  final int selectedIndex;
  final Color accentColor;
  final ColorScheme colorScheme;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 5.r, vertical: 9.r),
          decoration: BoxDecoration(
            color: isSelected ? accentColor.withValues(alpha: 0.13) : Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                child: Icon(
                  isSelected ? icon : outlineIcon,
                  color: isSelected ? accentColor : colorScheme.secondary,
                  size: 22.r,
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                child: isSelected
                    ? Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          label,
                          style: AppTextStyles.roboto.medium(
                            fontSize: 10.sp,
                            color: accentColor,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Add Nav Item ─────────────────────────────────────────────────────────────

class _AddNavItem extends StatelessWidget {
  const _AddNavItem({
    required this.index,
    required this.selectedIndex,
    required this.accentColor,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final Color accentColor;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeInOut,
            height: 48.r,
            width: 48.r,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(17.r),
              boxShadow: [
                BoxShadow(
                  color: accentColor.withValues(alpha: isSelected ? 0.55 : 0.30),
                  blurRadius: isSelected ? 18 : 10,
                  spreadRadius: isSelected ? 1 : 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AnimatedRotation(
              turns: isSelected ? 0.125 : 0,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              child: Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 26.r,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
