import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/font_style.dart';

class HomeCardItem extends StatelessWidget {
  const HomeCardItem({super.key,required this.onTap,required this.img,
  required this.title,this.left=0,this.isAspect=false,
    this.right=0,this.bottom=0,this.top=0});
final VoidCallback onTap;
final String img;
final String title;
final double left;
  final double bottom;
  final double right;
  final double top;
final bool isAspect;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          isAspect?
          SizedBox(
            width: 252.w, // أو double.infinity

            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: AspectRatio(
                aspectRatio: 252 / 400,

                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(ColorsApp.blue, BlendMode.color),

                  child: Image.asset(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ):
          ClipRRect(
            clipBehavior: Clip.antiAlias,

            borderRadius: BorderRadius.circular(20.r),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(ColorsApp.blue, BlendMode.color),
              child: Image.asset(img
              ),
            ),
          ),
          Positioned(
            top: top,
            left: left,
            right: right,bottom: bottom,
            child: Text(
              textAlign: TextAlign.center,
              title,
              style: FontStyleApp.almaraiBold43px.copyWith(
                color: Color(0xff0D4066),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
