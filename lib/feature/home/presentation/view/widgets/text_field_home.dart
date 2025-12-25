import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/font_style.dart';

class TextFieldHome extends StatefulWidget {
   TextFieldHome({super.key,required this.textEditingController});
  final textEditingController;

  @override
  State<TextFieldHome> createState() => _TextFieldHomeState();
}

class _TextFieldHomeState extends State<TextFieldHome> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.textEditingController.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
        prefixText: widget.textEditingController.text.isNotEmpty
            ? "ريال "
            : "",
        prefixStyle: FontStyleApp
            .almaraiBold43px
            .copyWith(
          color: Color(0xff9C9C9C),
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
    )
    ;
  }
}
