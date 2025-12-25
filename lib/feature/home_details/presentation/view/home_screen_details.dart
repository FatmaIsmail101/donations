import 'package:donations/core/constants/assets.dart';
import 'package:donations/core/constants/colors.dart';
import 'package:donations/core/constants/font_style.dart';
import 'package:donations/feature/home/data/model/home_screen_model.dart';
import 'package:donations/feature/home_details/data/money.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenDetails extends StatefulWidget {
  HomeScreenDetails({super.key, required this.model});

  HomeScreenModel model;
final TextEditingController textEditingController=TextEditingController();
  @override
  State<HomeScreenDetails> createState() => _HomeScreenDetailsState();
}

class _HomeScreenDetailsState extends State<HomeScreenDetails> {

int currentIndex=-1;

  @override
  Widget build(BuildContext context) {
    // final model=ModalRoute.of(context)!.settings.arguments as HomeScreenModel;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: ColorsApp.white,elevation: 0,
        actions: [
        Image.asset(AppAssets.appImg),
      ],scrolledUnderElevation: 0,
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
                  Image.asset(AppAssets.nafakatNakdyaDetails),
               Positioned (
                 bottom: 68.h,top:(kIsWeb)?300.h: 128.h,left:widget.model.name=="الفئات النقدية"?296.w: 360.w,right: (kIsWeb)?310.w:0,
                  child: Text(
                    widget.model.name,style: FontStyleApp.nahdiBold45px.copyWith(
                    color: ColorsApp.white
                  ),),
                ),

                ],
                ),
                SizedBox(height: 42.h,),
                Text(
                  widget.model.name=="الفئات النقدية"?"الفئات النقدية":"مبلغ التبرع",
                  style: FontStyleApp.nahdiBold45px.copyWith(
                    fontSize: 56.sp,
                    color: Color(0xff0C3D61),
                  ),
                ),
                // SizedBox(height: 39.h),
              SizedBox(
                width: double.infinity,
              // height: 500.h,
                child: Wrap(
                  spacing: 36.w, // المسافة بين العناصر أفقي
                  runSpacing: 12.h, // المسافة بين الأسطر عمودي
                  children: List.generate(
                    widget.model.name == "الفئات النقدية"
                        ? MoneyDetails.fe2atNakdya.length
                        : MoneyDetails.e3anaFamily.length,
                        (index) {
                      bool isSelected = currentIndex == index;

                      return InkWell(
                        onTap: () {
                          currentIndex = index;
                          setState(() {});
                        },
                        child: Container(

                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 17.w,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: isSelected ? Color(0xff0D4066) : Color(0xffF8F8F8),
                          ),
                          height:(kIsWeb)? 400.h:93.h,
                          // ممكن تحددي عرض ثابت أو خليها minWidth لو حابة
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: 12.w,
                            children: [
                              Text(
                                "ريال",
                                textDirection: TextDirection.ltr,
                                style: FontStyleApp.nahdiBold45px.copyWith(
                                  color: isSelected ? ColorsApp.white : Color(0xff9C9C9C),
                                  fontSize: 51.sp,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                widget.model.name == "الفئات النقدية"
                                    ? MoneyDetails.fe2atNakdya[index]
                                    : MoneyDetails.e3anaFamily[index],
                                textDirection: TextDirection.rtl,
                                style: FontStyleApp.nahdiBold45px.copyWith(
                                  color: isSelected ? ColorsApp.white : Color(0xff9C9C9C),
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

                TextFormField(
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  controller: widget.textEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'),
                    ),
                  ],
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,

                  decoration: InputDecoration(
                    prefixText:widget.textEditingController.text.isNotEmpty? "ريال":"",
                    prefixStyle: widget.textEditingController.text.isNotEmpty?FontStyleApp.almaraiBold43px.copyWith(
                        color: Color(0xff9C9C9C)
                    ):TextStyle(),
                    hint: Text(
                      textDirection: TextDirection.rtl,
                      "قيمة المبلغ",
                      style: FontStyleApp.nahdiBold45px.copyWith(
                        fontSize: 40.sp,
                        color: Color(0xff9C9C9C),
                      ),
                    ),
                    border: InputBorder.none,
                    focusColor: Color(0xffF8F8F8),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: Color(0xffF8F8F8),
                  ),
                  style: FontStyleApp.nahdiBold45px.copyWith(fontSize: 40.sp,
                  color: ColorsApp.grey),
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 14.w,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(33.w),
                        decoration: BoxDecoration(
                          color: Color(0xff0F4366),
                          borderRadius: BorderRadius.circular(40.r),
                        ),

                        child: InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Text(
                            "رجوع",
                            style: FontStyleApp.nahdiBold45px.copyWith(
                              fontSize: 56.sp,
                              color: ColorsApp.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(33.w),
                        decoration: BoxDecoration(
                          color: ColorsApp.green,
                          borderRadius: BorderRadius.circular(40.r),
                        ),

                        child: InkWell(
                          onTap: () {
                           // Navigator.pop(context);

                            showDialog<void>(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return AlertDialog(
                                  backgroundColor: ColorsApp.white,
                                  //icon

                                  content: SizedBox(
                                    width: 1018.w,
                                    height: 852.h,
                                    child: Column(
                                      spacing: 36.h,
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Image.asset(AppAssets.check,height: 241.h,width: 241.w,),
                                       SizedBox(height: 75.h,),
                                        Text(
                                          'تم بنجاح',
                                          style: FontStyleApp
                                              .almaraiBold56px
                                              .copyWith(
                                            fontSize: 78.sp,
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
                                            fontSize: 78.sp,
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
                            (child: AlertDialog());
                          },
                          child: Text(
                            "تبرع الآن",
                            style: FontStyleApp.nahdiBold45px.copyWith(
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
    );
  }
}
