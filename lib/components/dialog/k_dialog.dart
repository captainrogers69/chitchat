import 'package:chitchat/service/app_router.dart';
import 'package:chitchat/utils/widgets/container_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

final dialogProvider = Provider<KDialog>((ref) {
  return KDialog(ref);
});

class KDialog {
  final Ref _ref;
  KDialog(this._ref);

  Future<void> openCupertinoSheet(
      {required Widget dialog, bool barrierDismissible = true}) async {
    showCupertinoModalPopup(
      context: _ref
          .read(goRouting)
          .configuration
          .navigatorKey
          .currentState!
          .overlay!
          .context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return dialog;
      },
    );
  }

  Future<void> openDialog(
      {required Widget dialog, bool barrierDismissible = true}) async {
    showDialog(
      context: _ref
          .read(goRouting)
          .configuration
          .navigatorKey
          .currentState!
          .overlay!
          .context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return dialog;
      },
    );
  }

  Future<void> openSheet({required Widget dialog}) async {
    showModalBottomSheet(
      context: _ref
          .read(goRouting)
          .configuration
          .navigatorKey
          .currentState!
          .overlay!
          .context,
      shape: roundedShapeStan,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return dialog;
      },
    );
  }

  Future<void> openConstraintsSheet(
      {required Widget dialog, double? constraints}) async {
    showModalBottomSheet(
      context: _ref
          .read(goRouting)
          .configuration
          .navigatorKey
          .currentState!
          .overlay!
          .context,
      shape: roundedShapeStan,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: constraints ?? 65.h,
      ),
      builder: (context) {
        return dialog;
      },
    );
  }
}
