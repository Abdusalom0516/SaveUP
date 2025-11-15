
import 'package:boilerplate/core/common/widgets/custom_width_wd.dart';
import 'package:flutter/material.dart';

class SliverWidth extends StatelessWidget {
  const SliverWidth({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Width(width: width),
    );
  }
}
