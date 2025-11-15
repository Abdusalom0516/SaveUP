import 'package:boilerplate/core/common/widgets/custom_loading_wd.dart';
import 'package:boilerplate/core/utils/app_state_wrapper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final Widget? child;
  final String imageUrl;

  const CustomCachedNetworkImage({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.child,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      builder: (colors, texts, colorScheme) => CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: imageUrl,
        imageBuilder: (context, image) {
          return Image(image: image, fit: BoxFit.cover);
        },
        placeholder: (context, url) => CustomLoading(),
        errorWidget: (a, b, c) => Container(
          decoration: BoxDecoration(
            color: colors.primaryDark,
            borderRadius: BorderRadius.circular(radius ?? 0.0),
            image: const DecorationImage(
              image: AssetImage("assets/images/logo.png"),
              fit: BoxFit.contain,
            ),
            border: Border.all(color: colorScheme.outline, width: 1.3.r),
          ),
          child: child,
        ),
      ),
    );
  }
}
