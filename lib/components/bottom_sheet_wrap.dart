import 'dart:io';

import 'package:chitchat/utils/constants/k_colors.dart';
import 'package:chitchat/utils/widgets/container_util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomSheetWrap extends StatelessWidget {
  final Widget child;
  const BottomSheetWrap({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: witBoxShadow,
          color: KColors.whiteColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: Platform.isAndroid ? 8 : 20.sp,
                top: 8,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
