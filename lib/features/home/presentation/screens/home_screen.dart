import 'package:boilerplate/core/constants/const_img_paths.dart';
import 'package:boilerplate/core/design_system/app_text_styles.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) =>  CustomScrollView(
        slivers: [
          // AppBar Section
          SliverAppBar(
            title: Row(
              spacing: 10.r,
              children: [
                Image.asset(
                  ConstImgPaths.mainLogo,
                  height: 50.r,
                  width: 50.r,
                  fit: BoxFit.contain,
                ),
                Text(texts.appName, style:AppTextStyles.roboto,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
