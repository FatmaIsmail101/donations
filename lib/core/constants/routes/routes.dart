import 'package:donations/core/constants/routes/routes_name.dart';
import 'package:donations/feature/home/data/model/home_screen_model.dart';
import 'package:donations/feature/home/presentation/view/home_screen.dart';
import 'package:donations/feature/home_details/presentation/view/home_screen_details.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case RoutesName.homeScreenDetails:
        return MaterialPageRoute(builder: (context) => HomeScreenDetails(
          model: HomeScreenModel(name: "تيسرت",id: 0),
        ));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
