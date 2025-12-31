import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_terminal_sdk/flutter_terminal_sdk.dart';
import 'package:flutter_terminal_sdk/models/data/dto/payment_text.dart';
import 'package:flutter_terminal_sdk/models/data/purchase_response.dart';
import 'package:flutter_terminal_sdk/models/data/reverse_response.dart';
import 'package:flutter_terminal_sdk/models/data/ui_dock_position.dart';
import 'package:flutter_terminal_sdk/models/purchase_callbacks.dart';
import 'package:flutter_terminal_sdk/models/terminal_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'nearpay_jwt_data_source.dart';

class NearpayFunctions {
  final FlutterTerminalSdk terminalSdk = FlutterTerminalSdk();

  Future<void> initializeNearpay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isProductionNearpay = prefs.getBool("isProductionNearpay") ?? false;
    try {
      await terminalSdk.initialize(
        environment: isProductionNearpay == true
            ? Environment.production
            : Environment.sandbox,
        // Choose sandbox, production, internal
        googleCloudProjectNumber: 228434693352,
        // Add your google cloud project number
        huaweiSafetyDetectApiKey: "",
        // Add your huawei safety detect api key
        country: Country.sa,
        // Choose country: sa, tr, usa
        uiDockPosition: UiDockPosition
            .BOTTOM_CENTER, // Optional: set the location of the Tap to Pay modal
      );
    } catch (e) {
      print("Error initializing TerminalSDK: $e");
    }
  }

  Future<void> requestPermissions() async {
    try {
      print("checkRequiredPermissions...");

      var permissions = await terminalSdk.checkRequiredPermissions();
      String permission = "";
      for (var element in permissions) {
        print("permissions: ${element.permission}, ${element.isGranted}");
        permission = "$permission${element.permission} ${element.isGranted}\n";
      }
      print("permissions: $permission");
    } catch (e) {
      print("Error initializing: $e");
    }
  }

  Future<void> checkWifi() async {
    try {
      print("checkWifi...");

      var wifi = await terminalSdk.isWifiEnabled();

      print("wifi: $wifi");
    } catch (e) {
      print("Error initializing: $e");
    }
  }

  // check nfc
  Future<bool> checkNfc() async {
    try {
      print("checkNfc...");

      var nfc = await terminalSdk.isNfcEnabled();

      print("nfc: $nfc");
      return nfc;
    } catch (e) {
      print("Error initializing: $e");
      return false;
    }
  }

  Future<void> nearpayJwt() async {
    var result = await NearpayJwtDataSource.nearpayJwt();
    result.fold(
          (l) {
        print("Error jwt: ${l}");
      },
          (jwt) async {
        // print("jwt: $jwt");
        AndroidOptions? getAndroidOptions() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );
        final storage = FlutterSecureStorage(aOptions: getAndroidOptions()!);
        await storage.write(key: "nearpayJWT", value: jwt);
      },
    );
  }

  Future<void> verifyJWTNearpay() async {
    if (!terminalSdk.isInitialized) {
      print("SDK not initialized yet");
      return;
    }

    try {
      AndroidOptions getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
      final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
      String jwt = await storage.read(key: "nearpayJWT") ?? "";
      if (jwt.isNotEmpty) {
        final terminalModel = await terminalSdk.jwtLogin(jwt: jwt);
        await storage.write(
            key: "nearpayTerminalName", value: terminalModel.name);
        await storage.write(
            key: "nearpayTerminalLocalizedPaymentText",
            value: terminalModel.paymentText?.localizedPaymentText ?? "");
        await storage.write(
            key: "nearpayTerminalEnglishPaymentText",
            value: terminalModel.paymentText?.englishPaymentText ?? "");
        await storage.write(
            key: "nearpayTerminalTerminalUUID",
            value: terminalModel.terminalUUID ?? "");
        await storage.write(
            key: "nearpayTerminalTid", value: terminalModel.tid ?? "");
      } else {
        await nearpayJwt();
        String jwt = await storage.read(key: "nearpayJWT") ?? "";
        final terminalModel = await terminalSdk.jwtLogin(jwt: jwt);
        await storage.write(
            key: "nearpayTerminalName", value: terminalModel.name);
        await storage.write(
            key: "nearpayTerminalLocalizedPaymentText",
            value: terminalModel.paymentText?.localizedPaymentText ?? "");
        await storage.write(
            key: "nearpayTerminalEnglishPaymentText",
            value: terminalModel.paymentText?.englishPaymentText ?? "");
        await storage.write(
            key: "nearpayTerminalTerminalUUID",
            value: terminalModel.terminalUUID ?? "");
        await storage.write(
            key: "nearpayTerminalTid", value: terminalModel.tid ?? "");
      }
    } catch (ex) {
      print("Error verifying JWT: $ex");
      return;
    }
  }

  Future<TerminalModel> getTerminalModel() async {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );
    final storage = FlutterSecureStorage(aOptions: getAndroidOptions());
    String terminalUUID =
        await storage.read(key: "nearpayTerminalTerminalUUID") ?? "";
    String tid = await storage.read(key: "nearpayTerminalTid") ?? "";
    if (terminalUUID.isEmpty || tid.isEmpty) {
      await nearpayJwt();
      await verifyJWTNearpay();
      terminalUUID =
          await storage.read(key: "nearpayTerminalTerminalUUID") ?? "";
      tid = await storage.read(key: "nearpayTerminalTid") ?? "";
    }
    String terminalName = await storage.read(key: "nearpayTerminalName") ?? "";
    String localizedPaymentText =
        await storage.read(key: "nearpayTerminalLocalizedPaymentText") ?? "";
    String englishPaymentText =
        await storage.read(key: "nearpayTerminalEnglishPaymentText") ?? "";
    TerminalModel terminalModel = TerminalModel(
      name: terminalName,
      paymentText: PaymentText(
        localizedPaymentText: localizedPaymentText,
        englishPaymentText: englishPaymentText,
      ),
      terminalUUID: terminalUUID,
      tid: tid,
    );
    return terminalModel;
  }

  Future<void> purchase(TerminalModel connectedTerminal, int amount, int billId,
      void Function(PurchaseResponse)? onTransactionPurchaseCompleted) async {
    if (!terminalSdk.isInitialized) {
      print("SDK not initialized yet");
    }

    // if (connectedTerminal == null) {
    //   print("No connected terminal. Please connect to a terminal first.");
    //   return;
    // }

    // final amountText = _amountController.text.trim();
    // if (amountText.isEmpty) {
    //   setState(() => _status = "Please enter an amount.");
    //   return;
    // }

    // final amount = int.tryParse(amountText);
    // if (amount == null) {
    //   setState(() => _status = "Invalid amount entered.");
    //   return;

    try {
      // setState(() => _status = "Purchasing...");

      // Define the callbacks for purchase events
      // String? transactionUuid = const Uuid().v4();
      String intentId = const Uuid().v4();

      // var isTerminalReadyCheck = await _connectedTerminal?.isTerminalReady();
      // print("isTerminalReadyCheck: $isTerminalReadyCheck");
      // if (isTerminalReadyCheck == false) {
      //   setState(() => _status = "Terminal is not ready");
      //   return;
      // }

      await connectedTerminal.purchase(
        intentUUID: intentId,
        amount: amount,
        customerReferenceNumber: "",
        scheme: null,
        // eg.PaymentScheme.VISA, specifying this as null will allow all schemes to be accepted
        callbacks: PurchaseCallbacks(
          onSendTransactionFailure: (message) {
            print("Transaction failed message: $message");
            // setState(() => _status = "Transaction failed: $message");
          },
          onTransactionPurchaseCompleted: onTransactionPurchaseCompleted,
          //     (PurchaseResponse response) {
          //   print("onTransactionPurchaseCompleted");
          //
          //   // if (response.getLastTransaction()?.id != null) {
          //   //   await sendInvoiceData(billId, response.getLastTransaction()!.id!);
          //   // }
          //   status = response.status ?? "";
          //   try {
          //     // ... your success logic ...
          //     // if (!completer.isCompleted) completer.complete(true);
          //     completer = true;
          //     print("Transaction completer: $completer");
          //
          //
          //
          //   } catch (e) {
          //     print("ERROR IN CALLBACK: $e");
          //     // if (!completer.isCompleted) completer.complete(false);
          //     completer = false;
          //
          //   }
          //   print("dismissReaderUi");
          //
          //   connectedTerminal.dismissReaderUi();
          //   print("dismissReaderUiEnd");
          //
          //
          //
          //   // if (response.getLastTransaction() != null) {
          //   //   // _showTransactionDialog(response.getLastTransaction()!);
          //   //   print(
          //   //       "Purchase Successful Mada receipt:  ${response.getLastReceipt()?.getBKMReceipt().toString()}");
          //   //   print(
          //   //       "Purchase Successful isApproved:  ${response.getLastReceipt()?.getBKMReceipt().transactionUuid}");
          //   //   print(
          //   //       "url qr : ${response.getLastReceipt()?.getBKMReceipt().qrCode}");
          //   //   print(
          //   //       "Purchase Successful actionCode: ${response.getLastReceipt()?.getBKMReceipt().actionCode}");
          //   //   print(
          //   //       "Purchase Successful actionCodeMessage:  ${response.getLastReceipt()?.getBKMReceipt().actionCode}");
          //   //
          //   //   // intient id
          //   //   print("Intent ID: ${response.details?.intentId}");
          //   //
          //   //   print("transaction id: ${response.getLastTransaction()?.id}");
          //   //
          //   //   print(
          //   //       "transaction orderId: ${response.getLastTransaction()!.orderId}");
          //   //
          //   //   print(
          //   //       "transaction referenceId: ${response.getLastTransaction()!.referenceId}");
          //   //
          //   //   setState(() {
          //   //     intentId = response.details?.intentId;
          //   //     transactionUuid = response.getLastTransaction()!.id;
          //   //   });
          //   //   setState(() => _status =
          //   //   "Purchase Successful! ${response.getLastTransaction()!.id} ${response.getLastReceipt()?.getBKMReceipt().qrCode} ");
          //   //   setState(() {
          //   //     _statusQRcode =
          //   //     "${response.getLastReceipt()?.getBKMReceipt().qrCode}";
          //   //     result.text = response.getLastReceipt()!.data.toString();
          //   //   });
          //   // } else {
          //   //   setState(() => _status =
          //   //   "Purchase Failed! No transaction found in response.");
          //   // }
          // },

          // cardReaderCallbacks: CardReaderCallbacks(
          //   onReaderDisplayed: () {
          //     setState(() => _status = "Reader displayed...");
          //     print("Reader displayed...");
          //   },
          //   onReaderClosed: () {
          //     // setState(() => _status = "Reader closed...");
          //     print("Reader closed...");
          //   },
          //   onReadingStarted: () {
          //     setState(() => _status = "Reading started...");
          //     print("Reading started...");
          //   },
          //   onReaderWaiting: () {
          //     setState(() => _status = "Reader waiting...");
          //     print("Reader waiting...");
          //   },
          //   onReaderReading: () {
          //     setState(() => _status = "Reader reading...");
          //     print("Reader reading...");
          //   },
          //   onReaderRetry: () {
          //     setState(() => _status = "Reader retrying...");
          //     print("Reader retrying...");
          //   },
          //   onPinEntering: () {
          //     setState(() => _status = "Entering PIN...");
          //     print("Entering PIN...");
          //   },
          //   onReaderFinished: () {
          //     setState(() => _status = "Reader finished.");
          //     print("Reader finished...");
          //   },
          //   onReaderError: (message) {
          //     print("Reader error: $message");
          //     setState(() => _status = "Reader error: $message");
          //   },
          //   onCardReadSuccess: () {
          //     print("Card read successfully.");
          //     setState(() => _status = "Card read successfully.");
          //   },
          //   onCardReadFailure: (message) {
          //     setState(() => _status = "Card read failure: $message");
          //     print("Card read failure: $message");
          //   },
          // ),
        ),
      );
    } catch (e) {
      print("Error in purchase: $e");
      return;
    }
  }

  Future<ReverseResponse?> reverse(TerminalModel connectedTerminal,
      String transactionUuid, String intentId) async {
    if (!terminalSdk.isInitialized) {
      print("SDK not initialized yet");
      return null;
    }

    // print("transactionUuid $transactionUuid");
    // print("intentId $intentId");
    try {
      ReverseResponse reverseResponse =
      await connectedTerminal.reverseTransaction(
          transactionID: transactionUuid, intentId: intentId);
      print(
          "reverse Successful! ${reverseResponse.details.transactions?[0].id}");
      return reverseResponse;
    } catch (e) {
      print("Error in reverse: $e");
      return null;
    }
  }

  Future<String?> reconcile(TerminalModel connectedTerminal) async {
    if (!terminalSdk.isInitialized) {
      print("SDK not initialized yet");
      return null;
    }

    try {
      print("Reconcile...");
      final result = await connectedTerminal.reconcile();
      String reconcileId = result.receipt?.reconciliation.id ?? "";
      print("Reconcile Successful: ${result.toString()}");
      return reconcileId;
    } catch (e) {
      print("Error in Reconcile: $e");
      return null;
    }
  }

// Future<void> refund(
//     TerminalModel connectedTerminal,
//     String intentUUID,
//     int amount,
//     void Function(RefundResponse)? onTransactionRefundCompleted) async {
//   if (!terminalSdk.isInitialized) {
//     print("SDK not initialized yet");
//     return;
//   }
//   try {
//     String refundUuid = const Uuid().v4();
//
//     print("Refunding...");
//     final result = await connectedTerminal.refund(
//       refundUuid: refundUuid,
//       intentUUID: intentUUID,
//       amount: amount,
//       scheme: null,
//       callbacks: RefundCallbacks(
//         onTransactionRefundCompleted: onTransactionRefundCompleted,
//         //     (RefundResponse response) {
//         //   if (response.getLastTransaction() == null) {
//         //     print("Refund Failed! No transaction found in response.");
//         //     return;
//         //   }
//         //   // _showTransactionDialog(response.getLastTransaction()!);
//         //   print("Refund Successful! ${response.getLastReceipt()?.getBKMReceipt().id} ${response.getLastReceipt()?.getBKMReceipt().amountAuthorized} ${response.getLastReceipt()?.getBKMReceipt().isApproved}");
//         // },
//         onSendTransactionFailure: (message) {
//           print("Refund failed: $message");
//         },
//       ),
//     );
//     print("Refund Successful: ${result.toString()}");
//   } catch (e) {
//     print("Error in refund: $e");
//   }
// }

// Future<void> sendInvoiceData(int billId, String transactionUuid) async {
//   try {
//     // final response = await http.post(
//     //   Uri.parse(
//     //       "$url/api/Bills/PayNFCNearPay/${nfcPaymentModel.billId}/$transactionUuid"),
//     // );
//     final response = await ApiClient().post(
//       "${ApiEndPoint.payNFCNearPay}$billId/$transactionUuid",
//     );
//     String responseBody = response.data;
//     print("Nearpay invoice data: $responseBody");
//     // var responseJsonDecode = jsonDecode(responseBody);
//     // DtoSettings dtoSettings = DtoSettings.fromJson(responseJsonDecode);
//     // return dtoSettings;
//   } catch (e) {
//     print("Nearpay invoice data error: ${e.toString()}");
//     // String timeNow =
//     // intl.DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
//     // await GLogsFun.setLogs(LogsModel(
//     //   title: 'NFC payment invoice',
//     //   messageError: '$e',
//     //   iSuccess: false,
//     //   time: timeNow,
//     // ));
//     // return const DtoSettings();
//   }
// }

// Future<void> purchaseButton(int amount, int billId) async {
//   await NearpayFunctions().initializeNearpay();
//   await NearpayFunctions().requestPermissions();
//   await NearpayFunctions().checkWifi();
//   await NearpayFunctions().checkNfc();
//   // amount * 100
//   await NearpayFunctions().verifyJWTNearpayAndPurchase(amount, billId);
// }
}