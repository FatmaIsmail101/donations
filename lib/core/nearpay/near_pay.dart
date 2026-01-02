import 'package:donations/core/nearpay/terminal_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_terminal_sdk/flutter_terminal_sdk.dart';
import 'package:flutter_terminal_sdk/models/card_reader_callbacks.dart';
import 'package:flutter_terminal_sdk/models/data/ui_dock_position.dart';
import 'package:flutter_terminal_sdk/models/nearpay_user_response.dart';
import 'package:flutter_terminal_sdk/models/purchase_callbacks.dart';
import 'package:flutter_terminal_sdk/models/terminal_response.dart';
import 'package:uuid/uuid.dart';

final FlutterTerminalSdk _terminalSdk = FlutterTerminalSdk();

Future<void> initialize() async {
  // initializing the terminalSDK may throw an exception, so wrap it in a try-catch block

  try {
    await _terminalSdk.initialize(
      environment: Environment.sandbox,

      // Choose sandbox, production, internal
      googleCloudProjectNumber: 162056333315,
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

Future<void> sendOtp(String mobile) async {
  try {
    await _terminalSdk.sendMobileOtp(mobile);
    print("✅ OTP sent to $mobile");
  } catch (e) {
    print("❌ Error sending OTP: $e");
  }
}

Future<TerminalModel?> connectToTerminal() async {
  try {
    print("🔄 جاري الاتصال بالـ Terminal (TID: ${TerminalConfig.tid})...");
    // await initialize();
    final result = await _terminalSdk.connectTerminal(
      tid: TerminalConfig.tid,
      userUUID: TerminalConfig.userUUID,
      terminalUUID: TerminalConfig.terminalUUID,
    );
    print(result);
    return result;
  } catch (e) {
    print("❌ خطأ أثناء الاتصال: $e");
    print(e.toString());

    if (e.toString().contains("timeout")) {
      print("⏰ الجهاز غير متصل بالشبكة أو بعيد");
    } else if (e.toString().contains("invalid")) {
      print("🔑 تأكدي من TID أو UUID");
    }

    return null;
  }
}

transaction(String amount) async {
  final connectedTerminal = await _terminalSdk.connectTerminal(
    tid: TerminalConfig.tid,
    userUUID: TerminalConfig.userUUID,
    terminalUUID: TerminalConfig.terminalUUID,
  );
  double? amountDouble = double.tryParse(amount.replaceAll(',', ''));
  try {
    final intentUUID = const Uuid().v4();
    final customerReferenceNumber = "";
    await connectedTerminal.purchase(
      intentUUID: intentUUID,
      amount: amountDouble?.toInt() ?? 0,
      callbacks: PurchaseCallbacks(
        cardReaderCallbacks: CardReaderCallbacks(
          onCardReadSuccess: () {
            print("success");
          },
          onReaderDismissed: () {
            print("Reader dismissed by user");
          },
        ),
      ),
    );
  } catch (e) {}
}

Future<bool> transaction1(BuildContext context, String amount) async {
  //await initialize();
  final mobile = "+966509738300";

  if (TerminalConfig.userUUID.isEmpty) {
    await sendOtp(mobile);
    final code = await promptForOtp(context);
    if (code == null || code.isEmpty) {
      print("❌ User cancelled OTP entry");
      return false;
    }
    final verified = await verifyOtp(mobile, code);
    if (!verified) {
      print("❌ OTP verification failed, aborting transaction");
      return false;
    }
  } // خد userUUID

  final connectedTerminal = await connectToTerminal();
  if (connectedTerminal == null) {
    print("فشل الاتصال بالترمينال، لا يمكن إتمام العملية");
    return false;
  }

  print(connectedTerminal?.tid ?? "");
  double? amountDouble = double.tryParse(amount.replaceAll(',', ''));
  try {
    final intentUUID = const Uuid().v4();
    final customerReferenceNumber = "01142674856";
    await connectedTerminal?.purchase(
      intentUUID: intentUUID,
      amount: amountDouble?.toInt() ?? 0,
      callbacks: PurchaseCallbacks(
        cardReaderCallbacks: CardReaderCallbacks(
          onCardReadSuccess: () {
            print("success");
          },
          onReaderDismissed: () {
            print("Reader dismissed by user");
          },
        ),
      ),
    );
    print("connectedTerminal.terminalUUID:${connectedTerminal?.terminalUUID}");
    print("connectedTerminal.name:${connectedTerminal?.name}");
    print("connectedTerminal.tid:${connectedTerminal?.tid}");

    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<String?> promptForOtp(BuildContext context) async {
  String otp = '';
  return showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: Text('Enter OTP'),
      content: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) => otp = value,
        decoration: InputDecoration(hintText: "OTP code"),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(otp),
          child: Text('Submit'),
        ),
      ],
    ),
  );
}

Future<bool> verifyOtp(String mobile, String code) async {
  try {
    final user = await _terminalSdk.verifyMobileOtp(
      mobileNumber: mobile,
      code: code,
    );
    TerminalConfig.userUUID = user.userUUID ?? "";
    print("✅ OTP verified, userUUID: ${TerminalConfig.userUUID}");
    return TerminalConfig.userUUID.isNotEmpty;
  } catch (e) {
    print("❌ Error verifying OTP: $e");
    return false;
  }
}
