import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:boilerplate/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class MainScreen extends HookWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationIndex = useState<int>(0);
    final pageController = usePageController();
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => Scaffold(
        body: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [HomeScreen(), HomeScreen(), HomeScreen(), HomeScreen()],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            border: Border(
              top: BorderSide(color: colorScheme.outline, width: 1.5.r),
            ),
          ),
          child: WaterDropNavBar(
            backgroundColor: colorScheme.primaryContainer,
            onItemSelected: (index) {
              navigationIndex.value = index;
            },
            waterDropColor: colors.purple,
            selectedIndex: navigationIndex.value,
            barItems: [
              BarItem(filledIcon: Icons.home, outlinedIcon: Icons.home),
              BarItem(filledIcon: Icons.star, outlinedIcon: Icons.star),
              BarItem(
                filledIcon: Icons.add_rounded,
                outlinedIcon: Icons.add_rounded,
              ),
              BarItem(filledIcon: Icons.settings, outlinedIcon: Icons.settings),
            ],
          ),
        ),
      ),
    );
  }
}
