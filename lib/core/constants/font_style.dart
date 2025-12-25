import 'package:donations/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FontStyleApp{
  static  TextStyle almaraiBold43px=GoogleFonts.almarai(
    fontWeight: FontWeight.bold,fontSize: 43.sp,color: ColorsApp.white,
    letterSpacing: 0
  );
  static  TextStyle almaraiRegular43px=GoogleFonts.almarai(
      fontWeight: FontWeight.normal,fontSize: 43.sp,color: Color(0xff0D4066),
      letterSpacing: 0
  );
  static  TextStyle almaraiBold56px=GoogleFonts.almarai(
      fontWeight: FontWeight.bold,fontSize: 56.sp,color: ColorsApp.white,
      letterSpacing: 0
  );

  static  TextStyle nahdiBold45px=GoogleFonts.almarai(
      fontWeight: FontWeight.bold,fontSize: 45.sp,color: Color(0xff0D4066),

  );
  static  TextStyle almaraiBold25px=GoogleFonts.almarai(
    fontWeight: FontWeight.bold,fontSize: 25.sp,color: Color(0xff6B6B6B),

  );
  static  TextStyle tajawalBold57px=GoogleFonts.tajawal(
    fontWeight: FontWeight.bold,fontSize: 57.sp,color: ColorsApp.white,

  );
  static  TextStyle tajawalBold60px=GoogleFonts.tajawal(
    fontWeight: FontWeight.bold,fontSize: 60.sp,color: Color(0xff0D4066),

  );
}