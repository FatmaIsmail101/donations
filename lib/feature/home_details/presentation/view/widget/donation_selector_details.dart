import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/assets.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/font_style.dart';
import '../../../../home/presentation/view/widgets/text_field_home.dart';
import '../../../../home/presentation/view/widgets/widgets/text_field_home.dart';

class DonationAmountSelectorDetails extends StatefulWidget {
  final String title; // "مبلغ التبرع" أو "الفئات النقدية"
  final List<String> presetAmounts; // المبالغ الجاهزة
  final TextEditingController controller;
  final VoidCallback onDonate;
  final bool showRyalIcon; // هل نظهر أيقونة الريال جنب المبالغ؟

  const DonationAmountSelectorDetails({
    super.key,
    required this.title,
    required this.presetAmounts,
    required this.controller,
    required this.onDonate,
    this.showRyalIcon = true,
  });

  @override
  State<DonationAmountSelectorDetails> createState() => _DonationAmountSelectorDetailsState();
}

class _DonationAmountSelectorDetailsState extends State<DonationAmountSelectorDetails> {
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 32.h,
        children: [
          Text(
            widget.title,
            style: FontStyleApp.nahdiBold45px.copyWith(
              fontSize: 56.sp,
              color: const Color(0xff0C3D61),
            ),
            textAlign: TextAlign.right,
          ),

          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 36.w,
              runSpacing: 12.h,
              alignment: WrapAlignment.end,
              children: List.generate(widget.presetAmounts.length, (index) {
                bool isSelected = currentIndex == index;
                return InkWell(
                  onTap: () => setState(() => currentIndex = index),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 17.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.r),
                      color: isSelected ? const Color(0xff0D4066) : const Color(0xffF8F8F8),
                    ),
                    height: kIsWeb ? 400.h : 93.h,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 12.w,
                      children: [
                        if (widget.showRyalIcon)
                          SvgPicture.asset(
                            AppAssets.ryal,
                            height: kIsWeb ? 100.h : 50.h,
                            width: kIsWeb ? 100.w : 50.w,
                            colorFilter: ColorFilter.mode(
                              isSelected ? ColorsApp.white : const Color(0xff9C9C9C),
                              BlendMode.srcIn,
                            ),
                          ),
                        Text(
                          widget.presetAmounts[index],
                          textDirection: TextDirection.rtl,
                          style: FontStyleApp.nahdiBold45px.copyWith(
                            color: isSelected ? ColorsApp.white : const Color(0xff9C9C9C),
                            fontSize: 51.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),

          CustomAmountField(controller: widget.controller),

          // الأزرار
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 14.w,
            children: [
              Expanded(child: _buildButton("رجوع",  title: 'رجوع',
                  color:  const Color(0xff0F4366), onTap: () {
                Navigator.pop(context);
                  })),
              Expanded(child: _buildButton("تبرع الآن",  title: 'تبرع الآن',
                  color: ColorsApp.green, onTap: () {
                   // Navigator.pop(context);
                    widget.onDonate();
                  })),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String s, {
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(33.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40.r),
        ),
        child: Text(
          title,
          style: FontStyleApp.nahdiBold45px.copyWith(
            fontSize: 56.sp,
            color: ColorsApp.white,
          ),
        ),
      ),
    );
  }
}