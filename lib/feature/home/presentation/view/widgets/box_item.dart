import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxItem extends StatelessWidget {
  const BoxItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: 20.w,height: 115.h,
      decoration: BoxDecoration(
          color: Color(0xff2D6866),
          borderRadius: BorderRadius.circular(20.r,),border: Border.all(
        color: Color(0xff707070)
      )
      ),
    );
  }
}
