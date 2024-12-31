import 'package:chitchat/utils/constants/k_colors.dart';
import 'package:chitchat/utils/widgets/container_util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DragHandle extends StatelessWidget {
  final double? width, height;
  final Color? color;
  const DragHandle({
    this.height,
    this.color,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: witRadiusSmall,
            color: color ?? KColors.primaryColor,
          ),
          width: width ?? 17.w,
          height: height ?? 6,
        ),
      ],
    );
  }
}
