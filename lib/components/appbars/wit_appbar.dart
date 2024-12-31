import 'package:chitchat/components/sizing_box.dart';
import 'package:chitchat/utils/constants/k_colors.dart';
import 'package:chitchat/utils/constants/k_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WitAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? titleWidget, subtitleWidget;
  final List<Widget>? actions;
  final bool shouldBack;
  final bool? noActions;
  final String title;
  final Widget? leading;
  final double fontSize;
  final Widget? bottom;
  const WitAppBar({
    this.subtitleWidget,
    this.shouldBack = true,
    this.noActions = false,
    required this.title,
    this.fontSize = 16,
    this.titleWidget,
    this.leading,
    this.actions,
    this.bottom,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return (shouldBack)
        ? AppBar(
            backgroundColor: KColors.whiteColor,
            leading: leading ?? const BackButton(color: KColors.primaryColor),
            automaticallyImplyLeading: shouldBack ? false : true,
            actions: noActions! ? [] : actions ?? [],
            centerTitle: false,
            scrolledUnderElevation: 0,
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/splash_logo.png',
                  height: 40,
                  width: 40,
                ),
                const Sbw(w: 12),
                titleWidget ??
                    Text(
                      title,
                      style: Kstyles.kAppBarTextStyle.copyWith(
                        fontSize: shouldBack ? 15.5.sp : 15.sp,
                        color: KColors.primaryColor,
                      ),
                    ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: preferredSize,
              child: bottom ?? const SizedBox(),
            ),
          )
        : AppBar(
            backgroundColor: KColors.whiteColor,
            automaticallyImplyLeading: shouldBack ? false : true,
            actions: noActions! ? [] : actions ?? [],
            centerTitle: false,
            scrolledUnderElevation: 0,
            elevation: 0,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleWidget ??
                    Text(
                      title,
                      style: Kstyles.kAppBarTextStyle.copyWith(
                        color: KColors.primaryColor,
                        fontSize: fontSize,
                      ),
                    ),
                subtitleWidget ?? const SizedBox()
              ],
            ),
            bottom: PreferredSize(
              preferredSize: preferredSize,
              child: bottom ?? const SizedBox(),
            ),
          );
  }

  @override
  Size get preferredSize => Size.fromHeight(bottom != null
      ? 1.5 * AppBar().preferredSize.height
      : AppBar().preferredSize.height);
}
