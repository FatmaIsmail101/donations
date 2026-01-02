import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/constants/assets.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/font_style.dart';


// باقي الإمبورتات اللي عندك (AppAssets, ColorsApp, FontStyleApp, .sp, .w, .h)

class CustomAmountField extends StatelessWidget {
  final TextEditingController controller;

  const CustomAmountField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            prefixIcon: value.text.isNotEmpty
                ? SvgPicture.asset(
              AppAssets.ryal,
              height:(kIsWeb)?70.h: 47.h,
              width:(kIsWeb)?100.w: 61.w,
              colorFilter: const ColorFilter.mode(
                ColorsApp.grey,
                BlendMode.srcIn,
              ),
            )
                : null,
            prefixIconConstraints: BoxConstraints(
              minWidth: 24.w,
              minHeight: 24.h,
            ),
            hintText: "قيمة المبلغ",
            hintStyle: FontStyleApp.nahdiBold45px.copyWith(
              fontSize: 40.sp,
              color: const Color(0xff9C9C9C),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            filled: true,
            fillColor: const Color(0xffF8F8F8),
          ),
          style: FontStyleApp.nahdiBold45px.copyWith(
            fontSize: 40.sp,
            color: ColorsApp.grey,
          ),
          maxLines: 1,
        );
      },
    );
  }
}