import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/font_style.dart';
import '../../../../../../home_details/data/money.dart';
import '../text_field_home.dart';

class DonationAmountSelector extends StatefulWidget {
  final VoidCallback onDonate;
  final TextEditingController controller;

  const DonationAmountSelector({
    super.key,
    required this.onDonate,
    required this.controller,
  });

  @override
  State<DonationAmountSelector> createState() => _DonationAmountSelectorState();
}

class _DonationAmountSelectorState extends State<DonationAmountSelector> {
  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 32.h,
        children: [
          SizedBox(height: 26.h),
          Text(
            "مبلغ التبرع",
            style: FontStyleApp.nahdiBold45px.copyWith(fontSize: 56.sp),
            textAlign: TextAlign.right,
          ),
          SizedBox(height: 68.h),

          // قائمة المبالغ الجاهزة
          SizedBox(
            width: double.infinity,
            child: Wrap(
              spacing: 36.w,
              runSpacing: kIsWeb ? 50.h : 16.h, // اختلاف بسيط حسب المنصة
              alignment: WrapAlignment.end,
              children: List.generate(
                MoneyDetails.fe2atNakdya.length,
                    (index) {
                  bool isSelected = currentIndex == index;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        color: isSelected ? const Color(0xff0D4066) : const Color(0xffF8F8F8),
                      ),
                      height: kIsWeb ? null : 93.h,
                      child: Center(
                        child: Text(
                          MoneyDetails.fe2atNakdya[index],
                          textDirection: TextDirection.rtl,
                          style: FontStyleApp.nahdiBold45px.copyWith(
                            color: isSelected ? ColorsApp.white : const Color(0xff9C9C9C),
                            fontSize: 51.sp,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // حقل المبلغ المخصص
          CustomAmountField(controller: widget.controller),

          // الأزرار السفلية
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 14.w,
            children: [
              Expanded(
                child: _buildButton(
                  title: "رجوع",
                  color: const Color(0xff0F4366),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: _buildButton(
                  title: "تبرع الآن",
                  color: ColorsApp.green,
                  onTap: () {
                    Navigator.pop(context);
                    widget.onDonate();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
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
