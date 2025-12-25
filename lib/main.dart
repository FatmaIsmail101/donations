import 'package:donations/core/constants/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/constants/routes/routes.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching=false;
  runApp( Directionality(
      textDirection: TextDirection.rtl,
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 1920),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "الصدقات",
          initialRoute: RoutesName.homeScreen,
          onGenerateRoute: Routes.routes,
        );
      },
    );
  }
}
