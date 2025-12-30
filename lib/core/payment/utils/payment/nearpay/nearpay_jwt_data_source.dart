import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
//import 'package:easacc_pos/core/utiles/api_end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../../api/api_client.dart';
// import '../../../error/failures.dart';

class NearpayJwtDataSource {
  static Future< String> nearpayJwt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String deviceCode = prefs.getString("deviceCode") ?? "";
    return deviceCode;
    //try {
    // final response = await ApiClient().get(
    //   "${ApiEndPoint.nearpayJWT}$deviceCode",
    // );
    // return Right(response.data);
    // } on DioException catch (failure) {
    //   return Left(ServerFailure(failure.response?.data ?? ""));
    // }
    // }
  }
}
