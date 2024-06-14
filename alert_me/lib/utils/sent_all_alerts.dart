import 'dart:convert';
import 'sent_server_alerts.dart';
import 'settings_storage.dart';
import 'alert_sms.dart';
import 'package:flutter/material.dart';

class AlertSendModule {
  static Future<dynamic> sentAlerts() async {
    debugPrint("send all alerts called");
    var success;
    final List temp =
        jsonDecode(await SettingStorage.retrieveSettings() ?? "[]");
    if (temp.isNotEmpty) {
      if (temp[1] == true) {
        success = ServerAlerts.sentAlert();
      }
      if (temp[2] == true) {
        SMSSender.sendSMS();
      }
      if (temp[3] == true) {
        //SMSSender.sendhealthSMS();
      }
    }
    return success;
  }
}
