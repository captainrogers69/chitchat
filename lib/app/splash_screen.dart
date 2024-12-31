import 'dart:async';

import 'package:chitchat/utils/constants/k_colors.dart';
import 'package:chitchat/utils/constants/k_routes.dart';
import 'package:chitchat/utils/constants/k_styles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const id = KRoutes.splashScreen;
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;
  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();
    splashTransition();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.whiteColor,
      body: SizedBox(
        height: 100.h,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                      height: 100.h / _fontSize),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: _textOpacity,
                    child: Text(
                      "ChitChat",
                      style: Kstyles.kSplashStyle.copyWith(
                        color: KColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100.h,
                child: Column(
                  children: [
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 2000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          opacity: _containerOpacity,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 2000),
                            curve: Curves.fastLinearToSlowEaseIn,
                            height: 100.w / _containerSize,
                            width: 100.w / _containerSize,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // color: KColors.primaryColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Center(
                              child: SizedBox(
                                  // child: Image.asset('assets/Fine logo.png'),
                                  // child: Image.asset('assets/splash_logo.png'),
                                  // child: SvgPicture.network(
                                  //   "https://stage.digitaldocsys.in/static/media/logo.1d27a411b42cb041bf3a4ac1c42ef669.svg",
                                  //   fit: BoxFit.contain,
                                  //   height: 150,
                                  //   width: 150,
                                  //   placeholderBuilder: (context) {
                                  //     return const SizedBox();
                                  //   },
                                  // ),
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void splashTransition() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });
    _controller.forward();
    Timer(const Duration(milliseconds: 700), () {
      setState(() {
        _fontSize = 1.06;
      });
    });
    Timer(const Duration(milliseconds: 800), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });

      fetchCurrentUser();
    });
  }

  void fetchCurrentUser() {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      // final currentUser = await ref.read(userProvider.notifier).fetchUser();
      // if (currentUser) {
      //   if (mounted) {
      //     ref.read(authProvider).checkAppVersion();
      //     ref.read(goRouting).pushReplacement(KRoutes.homeScreen);
      //     ref.read(remoteConfigServiceProvider).checkforRestriction();
      //   }
      // } else {
      //   if (mounted) {
      //     ref.read(goRouting).pushReplacement(KRoutes.signInScreen);
      //     ref.read(authProvider).checkAppVersion();
      //     ref.read(remoteConfigServiceProvider).checkforRestriction();
      //   }
      // }
    });
  }
}
