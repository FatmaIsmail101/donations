import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NamiPayment {
  static const MethodChannel _channel = MethodChannel('nami_payment');

  // static Future<void> namiPayConnect(
  //     String ipAddress, String portNo, BuildContext context) async {
  //   try {
  //     final int connectionStatus =
  //         await _channel.invokeMethod('namiPayConnect', {
  //       'ipAddress': ipAddress,
  //       'portNo': portNo,
  //     });
  //
  //     if (connectionStatus == 0) {
  //       if (context.mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Socket Connected')),
  //         );
  //       }
  //     } else {
  //       if (context.mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('Socket Connection Failed')),
  //         );
  //       }
  //     }
  //   } on PlatformException catch (e) {
  //     print('Namipay connect failed: ${e.message}');
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error: ${e.message}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  // }
  //
  // static Future<String> namiPaySignature(
  //     String ecrRefNo, String terminalId, BuildContext context) async {
  //   String combinedValue = "$ecrRefNo$terminalId";
  //   String response = "";
  //   try {
  //     response = await _channel.invokeMethod('namiPaySignature', {
  //       'combinedValue': combinedValue,
  //     });
  //   } on PlatformException catch (e) {
  //     print('Namipay signature failed: ${e.message}');
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error: ${e.message}'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   }
  //   return response;
  // }

  static Future<List<String>?> namiPayPurchase(
      String ipAddress,
      String reqData,
      int transactionType,
      String ecrRefNo,
      String registerReqData,
      BuildContext context) async {
    try {
      String response = await _channel.invokeMethod('namiPayPurchase', {
        'ipAddress': ipAddress,
        'reqData': reqData,
        'transactionType': transactionType,
        'ecrRefNo': ecrRefNo,
        'registerReqData': registerReqData,
      });
      print('Namipay response: $response');
      List<String> responseParts = response.split(";");
      String responseMessage = responseParts[3];

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseMessage),
          ),
        );
      }
      return responseParts;
    } on PlatformException catch (e) {
      // print('Namipay purchase failed: ${e.message}');
      // print('Code: ${e.code}');
      // print('Message: ${e.message}');
      // print('Details: ${e.details}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return null;
    }
  }

  // static Future<DtoSettings> getInvoiceData(String token, String url, int id,
  //     List<String> responseParts, BuildContext context) async {
  //   String body = jsonEncode({
  //     "TerminalId": responseParts[12], // TID
  //     "ReceiptNumber": responseParts[35], // ECR Transaction Reference Number
  //     "AppName": "Namipay", // NamiPay
  //     "CardNumber": responseParts[4], // PAN
  //     "CardScheme": responseParts[27], // Scheme Label
  //     "IssuerBankId": "",
  //     "AcquirerBankId": "",
  //     "HostStatusCode": int.parse(responseParts[2]), // Response Code
  //     "HostStatusDesc": responseParts[3], // Response Message
  //     "Reference": responseParts[35], // ECR Transaction Reference Number
  //     "TransactionId": responseParts[10], // RRN
  //     "Company": responseParts[31], // Merchant Name
  //     "Id": id
  //   });
  //   try {
  //     final response = await http.post(
  //       Uri.parse("$url/api/v3/selforder/PaymentOrder"),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer  $token',
  //       },
  //       body: body,
  //     );
  //     String responseBody = response.body;
  //     print("Namipay invoice data: $responseBody");
  //     var responseJsonDecode = jsonDecode(responseBody);
  //     DtoSettings dtoSettings = DtoSettings.fromJson(responseJsonDecode);
  //     return dtoSettings;
  //   } catch (e) {
  //     print("Namipay invoice error: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error: $e'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     String timeNow =
  //     intl.DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now());
  //     await GLogsFun.setLogs(LogsModel(
  //       title: 'NFC payment invoice',
  //       messageError: '$e',
  //       iSuccess: false,
  //       time: timeNow,
  //     ));
  //     return const DtoSettings();
  //   }
  // }
}
