import 'package:chitchat/service/app_router.dart';
import 'package:chitchat/utils/constants/k_colors.dart';
import 'package:chitchat/utils/constants/k_styles.dart';
import 'package:chitchat/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class ChatApp extends ConsumerWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Sizer(
      builder: (_, __, ___) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp.router(
            scaffoldMessengerKey: ref.read(snackKeyProvider),
            routerConfig: ref.read(goRouting),
            debugShowCheckedModeBanner: false,
            darkTheme: AppTheme.lightTheme,
            themeMode: ThemeMode.system,
            theme: AppTheme.lightTheme,
            title: 'ChitChat',
          ),
        );
      },
    );

    // MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const Scaffold(),
    // );
  }
}

/// This Provider returns the [GlobalKey<ScaffoldMessengerState>] which can display the snackbar/toast

/// Use this [currentState?.showSnackBar(SnackBar(content: Text("Snackbar Display"));]
final snackKeyProvider = Provider<GlobalKey<ScaffoldMessengerState>>((ref) {
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
      GlobalKey<ScaffoldMessengerState>();
  return snackBarKey;
});

SnackBar snackbarcontent(String message, {bool error = false}) {
  return SnackBar(
    duration: const Duration(milliseconds: 1200),
    backgroundColor: error ? KColors.darkErrorColor : KColors.primaryColor,
    content: Text(
      message,
      style: Kstyles.kButtonStyle.copyWith(
        color: KColors.whiteColor,
      ),
    ),
  );
}
