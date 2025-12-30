import 'package:flutter_terminal_sdk/flutter_terminal_sdk.dart';
import 'package:flutter_terminal_sdk/models/data/ui_dock_position.dart';

final FlutterTerminalSdk _terminalSdk = FlutterTerminalSdk();

call() async {
  // initializing the terminalSDK may throw an exception, so wrap it in a try-catch block

  try {
    await _terminalSdk.initialize(

      environment: Environment.sandbox,

      // Choose sandbox, production, internal
      googleCloudProjectNumber: 12345678,
      // Add your google cloud project number
      huaweiSafetyDetectApiKey:
          "3lA5jiaqe14enqRRgsVPj0O5FRmEL4LUjsoDlqqXwNs7Jy7eO0pUFvAGhy4w",
      // Add your huawei safety detect api key
      uiDockPosition: UiDockPosition.BOTTOM_CENTER,
      // Optional: set the location of the Tap to Pay modal
      country: Country.sa, // Choose country: sa, tr, usa
    );
  } catch (e) {
    print("Error initializing TerminalSDK: $e");
  }
}
Future<void> sendOtp() async {
  try {
    var mobile = "+201142674856";
    await _terminalSdk.sendMobileOtp(mobile);
  } catch (e) {
    print("Error sending OTP: $e");
  }}

