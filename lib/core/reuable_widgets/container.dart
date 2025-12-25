import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ReusableContainer extends StatelessWidget {
  const ReusableContainer({super.key,this.color,
    this.child,this.padding,this.alignment,
    this.width,this.height,this.gradient});

  final double? width;
  final double? height;
  final Color? color;
final Widget?child;
final EdgeInsets ?padding;
final Alignment ?alignment;
final Gradient? gradient;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      width: width?.w,
      height: height?.h,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),padding: padding,
      child:child ,
    );
  }
}
