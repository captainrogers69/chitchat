import 'package:chitchat/components/sizing_box.dart';
import 'package:chitchat/enums/button_state.dart';
import 'package:chitchat/utils/constants/k_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class KBorderButton extends StatelessWidget {
  final double? width, height, roundCorner;
  final Color? buttonColor, labelColor;
  final double? labelSize, spinkitSize;
  final KButtonCorner? buttonCorner;
  final KButtonState? buttonState;
  final KButtonType? buttonType;
  final void Function()? onTap;
  final String label, asset;
  final Color? spinkitColor;
  const KBorderButton(
      {this.spinkitColor,
      required this.label,
      required this.onTap,
      this.buttonCorner,
      this.buttonState,
      this.buttonColor,
      this.roundCorner,
      this.spinkitSize,
      this.buttonType,
      this.labelColor,
      this.asset = '',
      this.labelSize,
      this.height,
      this.width,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonTheme(
          buttonColor: KColors.whiteColor,
          child: MaterialButton(
            elevation: 0,
            // elevation: buttonColor != KColors.grey500 ||
            //         buttonType == KButtonType.disabledButton
            //     ? 0
            //     : 4,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: buttonColor ??
                    (buttonType == KButtonType.primaryButton
                        ? KColors.primaryColor
                        : buttonType == KButtonType.successButton
                            ? KColors.switchColor
                            : buttonType == KButtonType.errorButton
                                ? KColors.errorColor
                                : buttonType == KButtonType.disabledButton
                                    ? KColors.grey500
                                    : buttonType == KButtonType.whiteButton
                                        ? KColors.whiteColor
                                        : KColors.primaryColor),
              ),
              borderRadius: BorderRadius.circular(
                roundCorner ??
                    (buttonCorner == KButtonCorner.circular
                        ? 31
                        : buttonCorner == KButtonCorner.rounded
                            ? 15
                            : buttonCorner == KButtonCorner.mid
                                ? 10
                                : buttonCorner == KButtonCorner.standard
                                    ? 5
                                    : 2),
              ),
            ),
            onPressed: onTap,
            height: height ?? 42,
            minWidth: width ?? 33.w,
            // color: buttonColor ??
            //     (buttonType == KButtonType.primaryButton
            //         ? KColors.primaryColor
            //         : buttonType == KButtonType.successButton
            //             ? KColors.successColor
            //             : buttonType == KButtonType.errorButton
            //                 ? KColors.errorColor
            //                 : buttonType == KButtonType.disabledButton
            //                     ? KColors.grey500
            //                     : KColors.primaryColor),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: buttonState == KButtonState.processing
                  ? [
                      SpinKitThreeBounce(
                        color: spinkitColor ?? KColors.whiteColor,
                        size: spinkitSize ?? 20,
                      ),
                    ]
                  : asset != ''
                      ? [
                          Image.asset(
                            asset,
                            color: KColors.whiteColor,
                            height: 16,
                          ),
                          const Sbw(w: 8),
                          Text(
                            label,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: labelColor ?? KColors.whiteColor,
                                  fontSize: labelSize ?? 12.sp,
                                ),
                          ),
                        ]
                      : [
                          Text(
                            label,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: labelColor ?? KColors.whiteColor,
                                  fontSize: labelSize ?? 12.sp,
                                ),
                          ),
                        ],
            ),
          ),
        ),
      ],
    );
  }
}
