// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../../../core/constants/assets.dart';
// import '../../../../../../core/constants/colors.dart';
// import '../../../../../../core/constants/font_style.dart';
// import '../../../../../home_details/data/money.dart';
// import '../box_item.dart';
// import 'donation_amount_item.dart';
//
// class DonationAmountDialog extends StatelessWidget {
//    DonationAmountDialog({super.key,required this.currentIndex,required this.onSelect});
// final int currentIndex;
// final ValueChanged<int>onSelect;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: ColorsApp.white,
//       content: Stack(
//         children: [
//           Container(
//             constraints: BoxConstraints(
//               maxHeight: 1700.h,
//             ),
//             //height: 2500.h,
//             width: double.infinity,
//             // العرض = عرض الصفحة
//             color: ColorsApp.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 120.w,
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   spacing: 32.h,
//                   mainAxisAlignment:
//                   MainAxisAlignment.start,
//                   crossAxisAlignment:
//                   CrossAxisAlignment.end,
//                   children: [
//                     SizedBox(height: 20.h),
//                     Text(
//                       "مبلغ التبرع",
//                       style: FontStyleApp.nahdiBold45px
//                           .copyWith(fontSize: 56.sp),
//                     ),
//                     SizedBox(height: 68.h),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 700.h,
//                       // يملى عرض الحاوية
//                       child: Wrap(
//                         spacing: 36.w,
//                         // المسافة بين العناصر أفقي
//                         runSpacing: 50.h,
//                         // المسافة بين الأسطر عمودي
//                         children: List.generate(MoneyDetails.fe2atNakdya.length, (
//                             index,
//                             ) {
//                           // bool isSelected =
//                           //     currentIndex ==
//                           //         index;
//
//                           return DonationAmountItem(
//                             onTap: ()=>onSelect(index),
//                             value: MoneyDetails.fe2atNakdya[index],
//                             isSelected: currentIndex==index,
//                           );
//                         }),
//                       ),
//                     ),
//
//                    TextFormField(),
//                     Row(
//                       mainAxisAlignment:
//                       MainAxisAlignment.center,
//                       spacing: 14.w,
//                       children: [
//                         Expanded(
//                           child: Container(
//                             alignment: Alignment.center,
//                             padding: EdgeInsets.all(33.w),
//                             decoration: BoxDecoration(
//                               color: Color(0xff0F4366),
//                               borderRadius:
//                               BorderRadius.circular(
//                                 40.r,
//                               ),
//                             ),
//
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 "رجوع",
//                                 style: FontStyleApp
//                                     .nahdiBold45px
//                                     .copyWith(
//                                   fontSize: 56.sp,
//                                   color:
//                                   ColorsApp.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: InkWell(
//                             onTap: () {
//                               Navigator.pop(context);
//
//                               showDialog<void>(
//                                 context: context,
//                                 builder:
//                                     (
//                                     BuildContext
//                                     dialogContext,
//                                     ) {
//                                   return AlertDialog(
//                                     //icon
//                                     backgroundColor:
//                                     ColorsApp
//                                         .white,
//
//                                     content: SizedBox(
//                                       width: 1018.w,
//                                       height: 1200.h,
//                                       child: Column(
//                                         spacing: 36.h,
//                                         mainAxisAlignment:
//                                         MainAxisAlignment
//                                             .center,
//                                         children: [
//                                           Image.asset(
//                                             AppAssets
//                                                 .check,
//                                             height:
//                                             241.h,
//                                             width:
//                                             241.w,
//                                           ),
//                                           SizedBox(
//                                             height:
//                                             75.h,
//                                           ),
//                                           Text(
//                                             'تم بنجاح',
//                                             style: FontStyleApp.almaraiBold56px.copyWith(
//                                               fontSize:
//                                               78.sp,
//                                               color: Color(
//                                                 0xff0C3D61,
//                                               ),
//                                             ),
//                                           ),
//                                           Text(
//                                             'شكراً لـ تبرعك',
//                                             style: FontStyleApp.almaraiBold56px.copyWith(
//                                               fontSize:
//                                               78.sp,
//                                               color: Color(
//                                                 0xff0C3D61,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               );
//                               //(child: AlertDialog());
//                             },
//                             child: Container(
//                               alignment: Alignment.center,
//                               padding: EdgeInsets.all(
//                                 33.w,
//                               ),
//                               decoration: BoxDecoration(
//                                 color: ColorsApp.green,
//                                 borderRadius:
//                                 BorderRadius.circular(
//                                   40.r,
//                                 ),
//                               ),
//
//                               child: Text(
//                                 "تبرع الآن",
//                                 style: FontStyleApp
//                                     .nahdiBold45px
//                                     .copyWith(
//                                   fontSize: 56.sp,
//                                   color:
//                                   ColorsApp.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           BoxItem(),
//         ],
//       ),
//     );
//   }
// }
