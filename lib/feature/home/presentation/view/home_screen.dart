import 'package:donations/core/payment/utils/payment/nearpay/nearpay_functions.dart';
import 'package:donations/feature/home/presentation/view/widgets/box_item.dart';
import 'package:donations/feature/home/presentation/view/widgets/home_card_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/font_style.dart';
import '../../../../core/nearpay/near_pay.dart';
import '../../../home_details/data/money.dart';
import '../../../home_details/presentation/view/home_screen_details.dart';
import '../../data/model/home_screen_model.dart';
import 'package:flutter_terminal_sdk/flutter_terminal_sdk.dart';
import 'package:flutter_terminal_sdk/models/data/ui_dock_position.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Stack(
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
              ),
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
                        return StatefulBuilder(
                          builder: (context, setDialogState) => AlertDialog(
                            backgroundColor: ColorsApp.white,

                            content: Stack(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxHeight: 1700.h,
                                  ),
                                  //height: 2500.h,
                                  width: double.infinity,
                                  // العرض = عرض الصفحة
                                  color: ColorsApp.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 120.w,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        spacing: 32.h,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(height: 20.h),
                                          Text(
                                            "مبلغ التبرع",
                                            style: FontStyleApp.nahdiBold45px
                                                .copyWith(fontSize: 56.sp),
                                          ),
                                          SizedBox(height: 68.h),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 700.h,
                                            // يملى عرض الحاوية
                                            child: Wrap(
                                              spacing: 36.w,
                                              // المسافة بين العناصر أفقي
                                              runSpacing: 50.h,
                                              // المسافة بين الأسطر عمودي
                                              children: List.generate(
                                                MoneyDetails.fe2atNakdya.length,
                                                (index) {
                                                  bool isSelected =
                                                      currentIndex == index;

                                                  return InkWell(
                                                    onTap: () {
                                                      //final isSelected = widget.currentIndex == index;

                                                      setDialogState(() {
                                                        currentIndex = index;
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            // vertical: 12.h,
                                                            horizontal: 17.w,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              30.r,
                                                            ),
                                                        color: isSelected
                                                            ? Color(0xff0D4066)
                                                            : Color(0xffF8F8F8),
                                                      ),
                                                      // height: 700.h,
                                                      // خلي العرض ديناميكي حسب المحتوى
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            MoneyDetails
                                                                .fe2atNakdya[index],
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            style: FontStyleApp
                                                                .nahdiBold45px
                                                                .copyWith(
                                                                  color:
                                                                      isSelected
                                                                      ? ColorsApp
                                                                            .white
                                                                      : Color(
                                                                          0xff9C9C9C,
                                                                        ),
                                                                  fontSize:
                                                                      51.sp,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),

                                          ValueListenableBuilder<
                                            TextEditingValue
                                          >(
                                            valueListenable:
                                                widget.textEditingController,
                                            builder: (context, value, child) {
                                              return TextFormField(
                                                textDirection:
                                                    TextDirection.rtl,
                                                controller: widget
                                                    .textEditingController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  prefixIcon:
                                                      value.text.isNotEmpty
                                                      ? SvgPicture.asset(
                                                          AppAssets.ryal,
                                                          height: 22.h,
                                                          width: 22.w,
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                ColorsApp.grey,
                                                                BlendMode.srcIn,
                                                              ),
                                                        )
                                                      : null,

                                                  hintText: "قيمة المبلغ",
                                                  hintTextDirection:
                                                      TextDirection.rtl,
                                                  hintStyle: FontStyleApp
                                                      .nahdiBold45px
                                                      .copyWith(
                                                        fontSize: 40.sp,
                                                        color: Color(
                                                          0xff9C9C9C,
                                                        ),
                                                      ),
                                                  filled: true,
                                                  fillColor: Color(0xffF8F8F8),
                                                  border: InputBorder.none,
                                                ),
                                                style: FontStyleApp
                                                    .nahdiBold45px
                                                    .copyWith(
                                                      fontSize: 40.sp,
                                                      color: ColorsApp.grey,
                                                    ),
                                                maxLines: 1,
                                              );
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            spacing: 14.w,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(33.w),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff0F4366),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40.r,
                                                        ),
                                                  ),

                                                  child: InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "رجوع",
                                                      style: FontStyleApp
                                                          .nahdiBold45px
                                                          .copyWith(
                                                            fontSize: 56.sp,
                                                            color:
                                                                ColorsApp.white,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);

                                                    showDialog<void>(
                                                      context: context,
                                                      builder:
                                                          (
                                                            BuildContext
                                                            dialogContext,
                                                          ) {
                                                            return AlertDialog(
                                                              //icon
                                                              backgroundColor:
                                                                  ColorsApp
                                                                      .white,

                                                              content: SizedBox(
                                                                width: 1018.w,
                                                                height: 1200.h,
                                                                child: Column(
                                                                  spacing: 36.h,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Image.asset(
                                                                      AppAssets
                                                                          .check,
                                                                      height:
                                                                          241.h,
                                                                      width:
                                                                          241.w,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          75.h,
                                                                    ),
                                                                    Text(
                                                                      'تم بنجاح',
                                                                      style: FontStyleApp.almaraiBold56px.copyWith(
                                                                        fontSize:
                                                                            78.sp,
                                                                        color: Color(
                                                                          0xff0C3D61,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'شكراً لـ تبرعك',
                                                                      style: FontStyleApp.almaraiBold56px.copyWith(
                                                                        fontSize:
                                                                            78.sp,
                                                                        color: Color(
                                                                          0xff0C3D61,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                    );
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.all(
                                                      33.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: ColorsApp.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            40.r,
                                                          ),
                                                    ),

                                                    child: Text(
                                                      "تبرع الآن",
                                                      style: FontStyleApp
                                                          .nahdiBold45px
                                                          .copyWith(
                                                            fontSize: 56.sp,
                                                            color:
                                                                ColorsApp.white,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                BoxItem(),
                              ],
                            ),
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
                          child: StatefulBuilder(
                            builder: (context, setSheetState) => Container(
                              height: 877.h,
                              width: double.infinity, // العرض = عرض الصفحة
                              color: ColorsApp.white,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 120.w,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    spacing: 32.h,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(height: 26.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BoxItem(),
                                          Text(
                                            "مبلغ التبرع",
                                            style: FontStyleApp.nahdiBold45px
                                                .copyWith(fontSize: 56.sp),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 68.h),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 200.h,
                                        // يملى عرض الحاوية
                                        child: Wrap(
                                          spacing: 36.w,
                                          // المسافة بين العناصر أفقي
                                          runSpacing: 16.h,
                                          // المسافة بين الأسطر عمودي
                                          children: List.generate(
                                            MoneyDetails.fe2atNakdya.length,
                                            (index) {
                                              int selectedIndex = currentIndex;
                                              bool isSelected =
                                                  selectedIndex == index;

                                              return InkWell(
                                                onTap: () {
                                                  //selectedIndex = index;
                                                  setSheetState(() {
                                                    currentIndex = index;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                    // vertical: 12.h,
                                                    horizontal: 17.w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          30.r,
                                                        ),
                                                    color: isSelected
                                                        ? Color(0xff0D4066)
                                                        : Color(0xffF8F8F8),
                                                  ),
                                                  height: 93.h,
                                                  // خلي العرض ديناميكي حسب المحتوى
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [

                                                      Text(
                                                        MoneyDetails
                                                            .fe2atNakdya[index],
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: FontStyleApp
                                                            .nahdiBold45px
                                                            .copyWith(
                                                              color: isSelected
                                                                  ? ColorsApp
                                                                        .white
                                                                  : Color(
                                                                      0xff9C9C9C,
                                                                    ),
                                                              fontSize: 51.sp,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      ValueListenableBuilder<TextEditingValue>(
                                        valueListenable:
                                            widget.textEditingController,
                                        builder: (context, value, child) {
                                          return TextFormField(
                                            controller:
                                                widget.textEditingController,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]'),
                                              ),
                                            ],
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.right,
                                            decoration: InputDecoration(
                                              prefixIcon: value.text.isNotEmpty
                                                  ? SvgPicture.asset(
                                                      AppAssets.ryal,
                                                      height: 47.h,
                                                      width: 61.w,
                                                      colorFilter:
                                                          ColorFilter.mode(
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
                                              hintStyle: FontStyleApp
                                                  .nahdiBold45px
                                                  .copyWith(
                                                    fontSize: 40.sp,
                                                    color: Color(0xff9C9C9C),
                                                  ),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              filled: true,
                                              fillColor: Color(0xffF8F8F8),
                                            ),
                                            style: FontStyleApp.nahdiBold45px
                                                .copyWith(
                                                  fontSize: 40.sp,
                                                  color: ColorsApp.grey,
                                                ),
                                            maxLines: 1,
                                          );
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        spacing: 14.w,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(33.w),
                                              decoration: BoxDecoration(
                                                color: Color(0xff0F4366),
                                                borderRadius:
                                                    BorderRadius.circular(40.r),
                                              ),

                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  "رجوع",
                                                  style: FontStyleApp
                                                      .nahdiBold45px
                                                      .copyWith(
                                                        fontSize: 56.sp,
                                                        color: ColorsApp.white,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: ()async {
                                              int amount=1000;
                                              var terminal=await NearpayFunctions().getTerminalModel();
                                              await NearpayFunctions().purchase(terminal, amount, 12345, (response) {
                                                if(response.status=="Approved"){
                                                  print("RRN:${response.getLastTransaction()?.referenceId}");
                                                }
                                              },);
                                                Navigator.pop(context);

                                                showDialog<void>(
                                                  context: context,
                                                  builder: (BuildContext dialogContext) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          ColorsApp.white,
                                                      //icon
                                                      // title: Image.asset(AppAssets.check),
                                                      content: SizedBox(
                                                        width: 1018.w,
                                                        height: 852.h,
                                                        child: Column(
                                                          spacing: 36.h,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              AppAssets.check,
                                                              height: 241.h,
                                                              width: 241.w,
                                                            ),
                                                            SizedBox(
                                                              height: 75.h,
                                                            ),
                                                            Text(
                                                              'تم بنجاح',
                                                              style: FontStyleApp
                                                                  .almaraiBold56px
                                                                  .copyWith(
                                                                    fontSize:
                                                                        78.sp,
                                                                    color: Color(
                                                                      0xff0C3D61,
                                                                    ),
                                                                  ),
                                                            ),
                                                            Text(
                                                              'شكراً لـ تبرعك',
                                                              style: FontStyleApp
                                                                  .almaraiBold56px
                                                                  .copyWith(
                                                                    fontSize:
                                                                        78.sp,
                                                                    color: Color(
                                                                      0xff0C3D61,
                                                                    ),
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                                // (child: AlertDialog());
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(33.w),
                                                decoration: BoxDecoration(
                                                  color: ColorsApp.green,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        40.r,
                                                      ),
                                                ),

                                                child: Text(
                                                  "تبرع الآن",
                                                  style: FontStyleApp
                                                      .nahdiBold45px
                                                      .copyWith(
                                                        fontSize: 56.sp,
                                                        color: ColorsApp.white,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
      ),
    );
  }

  void _openDetails(BuildContext context, HomeScreenModel model) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreenDetails(model: model)),
    );
  }



}

// Text(
//   "ريال",
//   textDirection:
//       TextDirection.ltr,
//   style: FontStyleApp
//       .nahdiBold45px
//       .copyWith(
//         color: isSelected
//             ? ColorsApp
//                   .white
//             : Color(
//                 0xff9C9C9C,
//               ),
//         fontSize: 51.sp,
//       ),
// ),
// SizedBox(width: 6.w),
// Text(
//   "ريال",
//   textDirection:
//       TextDirection.ltr,
//   style: FontStyleApp
//       .nahdiBold45px
//       .copyWith(
//         color: isSelected
//             ? ColorsApp
//                   .white
//             : Color(
//                 0xff9C9C9C,
//               ),
//         fontSize: 51.sp,
//       ),
// ),
// SizedBox(width: 6.w),
