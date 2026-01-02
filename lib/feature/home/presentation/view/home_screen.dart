import 'package:donations/feature/home/presentation/view/widgets/home_card_item.dart';
import 'package:donations/feature/home/presentation/view/widgets/widgets/box_item.dart';
import 'package:donations/feature/home/presentation/view/widgets/widgets/dialog/donation_amount_selector.dart';
import 'package:donations/feature/home/presentation/view/widgets/widgets/intro_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/font_style.dart';
import '../../../../core/nearpay/near_pay.dart';
import '../../../home_details/presentation/view/home_screen_details.dart';
import '../../data/model/home_screen_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController textEditingController = TextEditingController();

  int currentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          surfaceTintColor: Colors.transparent,
          foregroundColor: ColorsApp.white,
          backgroundColor: ColorsApp.white,
          actions: [Image.asset(AppAssets.appImg)],
        ),
        backgroundColor: ColorsApp.white,
        body: SingleChildScrollView(
          child: Column(
            spacing: 34.h,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //image
              IntroImage(),
              SizedBox(height: 38.h),
              Row(
                spacing: 20.w,
                children: [
                  Expanded(
                    child: HomeCardItem(
                      top: 38.h,
                      onTap: () => _openDetails(
                        context,
                        HomeScreenModel(id: 0, name: "الفئات النقدية"),
                      ),
                      img: AppAssets.nafakatNakdya,
                      title: "الفئات النقدية",
                    ),
                  ),
                  Expanded(
                    child: Column(
                      spacing: 10.h,
                      children: [
                        //إعانة الأسر
                        HomeCardItem(
                          onTap: () => _openDetails(
                            context,
                            HomeScreenModel(id: 1, name: "إعــانة الاسر"),
                          ),
                          img: AppAssets.e3ana,
                          title: "إعــانة الاسر",
                          right: 200.w,
                          top: 38.h,
                        ),
                        Row(
                          spacing: 22.w,
                          children: [
                            //تيسرت
                            HomeCardItem(
                              onTap: () => _openDetails(
                                context,
                                HomeScreenModel(id: 3, name: "تيسرت"),
                              ),
                              left: 47.0.w,
                              top: 30.h,
                              isAspect: true,
                              img: AppAssets.taysarat,
                              title: "تيسرت",
                            ),
                            //فرجت
                            HomeCardItem(
                              onTap: () => _openDetails(
                                context,
                                HomeScreenModel(id: 4, name: "فرجت"),
                              ),
                              img: AppAssets.foregat,
                              title: "فرجت",
                              //left: 40.0.w,
                              top: 30.h,
                              isAspect: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //Button
              InkWell(
                onTap: () {
                  if (kIsWeb) {
                    showDialog<void>(
                      context: context,
                      // false = user must tap button, true = tap outside dialog
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          backgroundColor: ColorsApp.white,

                          content: Stack(
                            children: [
                              Container(
                                constraints: BoxConstraints(maxHeight: 1700.h),
                                //height: 2500.h,
                                width: double.infinity,
                                // العرض = عرض الصفحة
                                color: ColorsApp.white,
                                child: DonationAmountSelector(
                                  onDonate: () async {
                                    FocusScope.of(context).unfocus();

                                    final res = await transaction1(
                                      context,
                                      textEditingController.text,
                                    );
                                    if (res) {
                                      Navigator.pop(context);

                                      _showSuccessDialog(context);
                                    } else if (!res) {
                                      Navigator.pop(context);

                                      _showErrorDialog(context, "لم يتم الدفع");
                                      // Navigator.pop(context);
                                    }
                                  },
                                  controller: textEditingController,
                                ),
                              ),
                              BoxItem(),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(0), // صفر = مستوي
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ), // هنا
                          child: Container(
                            height: 877.h,
                            width: double.infinity, // العرض = عرض الصفحة
                            color: ColorsApp.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 120.w),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 50.h),
                                    child: BoxItem(),
                                  ),
                                  DonationAmountSelector(
                                    onDonate: () async {
                                      FocusScope.of(context).unfocus();

                                      final res = await transaction1(
                                        context,
                                        textEditingController.text,
                                      );
                                      if (res) {
                                        Navigator.pop(context);

                                        _showSuccessDialog(context);
                                      } else if (!res) {
                                       Navigator.pop(context);

                                        _showErrorDialog(
                                          context,
                                          "لم يتم الدفع",
                                        );
                                        // Navigator.pop(context);
                                      }
                                    },
                                    controller: textEditingController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorsApp.greyWOpacity100),
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff0D4066),
                        Color(0xff2D6866),
                        ColorsApp.green,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.add, color: ColorsApp.white),
                      Text("تبرع سريع", style: FontStyleApp.almaraiBold43px),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Text(
          "©all rights reserved easacc",
          style: FontStyleApp.almaraiBold25px.copyWith(
            color: Color(0xff6B6B6B),
          ),
        ),
      ),
    );
  }

  void _openDetails(BuildContext context, HomeScreenModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreenDetails(model: model)),
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
