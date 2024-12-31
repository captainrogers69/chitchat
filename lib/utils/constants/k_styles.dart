import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'k_colors.dart';

class Kstyles {
  static final kSubHeadingStyle = GoogleFonts.josefinSans(
    fontSize: 18,
    color: KColors.grey600,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.0015000000223517411,
    fontWeight: FontWeight.w800,
  );
  static final kHintStyle = GoogleFonts.josefinSans(
    fontSize: 18,
    color: KColors.grey600,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.0015000000223517411,
    fontWeight: FontWeight.w500,
  );

  static final kButtonStyle = GoogleFonts.josefinSans(
    fontSize: 15.6,
    color: KColors.grey600,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.0015000000223517411,
    fontWeight: FontWeight.w500,
  );

  static final kHeading1Style = GoogleFonts.josefinSans(
    fontSize: 18,
    color: KColors.grey900,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.0015000000223517411,
    fontWeight: FontWeight.w500,
  );

  static final kVerySmallTextStyle = GoogleFonts.josefinSans(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 11,
      letterSpacing: 0.0105);
  static final kSmallTextStyle = GoogleFonts.josefinSans(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      letterSpacing: 0.0015000000223517411);

  static final kAppBarTextStyle = GoogleFonts.josefinSans(
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      fontSize: 15.5.sp,
      letterSpacing: 0.0105);
  static final kSplashStyle = GoogleFonts.josefinSans(
    color: const Color(0xff2e3191),
    fontWeight: FontWeight.bold,
    fontSize: 21.sp,
  );
  static final kSplashLightStyle = GoogleFonts.josefinSans(
    color: const Color(0xff2e3191),
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
  );
}
