import 'package:donations/core/constants/assets.dart';
import 'package:donations/core/constants/colors.dart';
import 'package:donations/core/constants/font_style.dart';
import 'package:donations/feature/home/data/model/home_screen_model.dart';
import 'package:donations/feature/home_details/data/money.dart';
import 'package:donations/feature/home_details/presentation/view/widget/donation_selector_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/nearpay/near_pay.dart';

class HomeScreenDetails extends StatelessWidget {
  HomeScreenDetails({super.key, required this.model});

  HomeScreenModel model;
  final TextEditingController textEditingController = TextEditingController();

  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    final presetAmounts = model.name == "الفئات النقدية"
        ? MoneyDetails.fe2atNakdya
        : MoneyDetails.e3anaFamily;

    final title = model.name == "الفئات النقدية"
        ? "الفئات النقدية"
        : "مبلغ التبرع";

    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorsApp.white,
        elevation: 0,
        actions: [Image.asset(AppAssets.appImg)],
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: ColorsApp.white,

        leading: SizedBox(),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: ColorsApp.white,
        ),
        width: double.infinity,
        // height: 1500.h,
        padding: EdgeInsets.all(24.w), // المسافة داخل الكونتينر

        child: Padding(
          padding: EdgeInsets.all(54.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 32.h,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      model.name == "الفئات النقدية"
                          ? AppAssets.nafakatNakdyaDetails
                          : "assets/images/screen_details_soura.png",
                    ),
                    Positioned(
                      bottom: 68.h,
                      top: (kIsWeb) ? 300.h : 128.h,
                      left: model.name == "الفئات النقدية" ? 296.w : 360.w,
                      right: (kIsWeb) ? 310.w : 0,
                      child: Text(
                        model.name,
                        style: FontStyleApp.nahdiBold45px.copyWith(
                          color: ColorsApp.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 42.h),
                Padding(
                  padding: EdgeInsets.all(54.w),
                  child: DonationAmountSelectorDetails(
                    title: title,
                    presetAmounts: presetAmounts,
                    controller: textEditingController,
                    onDonate: () async {
                      FocusScope.of(context).unfocus();

                      final res = await transaction1(
                        context,
                        textEditingController.text,
                      );
                      if (res) {
                        _showSuccessDialog(context);
                      } else if (!res) {
                        _showErrorDialog(context, "لم يتم الدفع");
                        // Navigator.pop(context);
                      }
                    },
                    showRyalIcon: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Text(
        "©all rights reserved easacc",
        style: FontStyleApp.almaraiBold25px.copyWith(color: Color(0xff6B6B6B)),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColorsApp.white,
          content: SizedBox(
            width: 1018.w,
            height: kIsWeb ? 1200.h : 852.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 36.h,
              children: [
                Image.asset(AppAssets.check, height: 241.h, width: 241.w),
                SizedBox(height: 75.h),
                Text(
                  'تم بنجاح',
                  style: FontStyleApp.almaraiBold56px.copyWith(
                    fontSize: 78.sp,
                    color: const Color(0xff0C3D61),
                  ),
                ),
                Text(
                  'شكراً لـ تبرعك',
                  style: FontStyleApp.almaraiBold56px.copyWith(
                    fontSize: 78.sp,
                    color: const Color(0xff0C3D61),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsApp.white,
        content: SizedBox(
          width: 1018.w,
          height: kIsWeb ? 1200.h : 852.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 36.h,
            children: [
              Image.asset(AppAssets.error, height: 241.h, width: 241.w),
              SizedBox(height: 75.h),
              Text(
                'عذراً',
                style: FontStyleApp.almaraiBold56px.copyWith(
                  fontSize: 78.sp,
                  color: const Color(0xff0C3D61),
                ),
              ),
              Text(
                'لـم يتم الدفع',
                style: FontStyleApp.almaraiBold56px.copyWith(
                  fontSize: 78.sp,
                  color: const Color(0xff0C3D61),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
