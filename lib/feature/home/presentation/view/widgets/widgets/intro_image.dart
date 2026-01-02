import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/assets.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/font_style.dart';


class IntroImage extends StatelessWidget {
  const IntroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            AppAssets.homeScreen,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Positioned(
          bottom: 95.h,
          right: 75.w,
          left: 121.w,
          child: Text(
            "وَأَحْسِنُوا إِنَّ اللَّهَ يُحِبُّ الْمُحْسِنِينَ",
            textAlign: TextAlign.center,
            style: FontStyleApp.almaraiBold56px.copyWith(
              color: ColorsApp.white,
            ),
          ),
        ),
      ],
    );
  }
}
