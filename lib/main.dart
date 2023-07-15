import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';
import 'package:sms_inout_test/sms_advanced_package.dart';
import 'dart:async';

import 'package:sms_inout_test/telephony.dart';
//import 'package:telephony/telephony.dart';

// onBackgroundMessage(SmsMessage message) {
//   debugPrint("onBackgroundMessage called");
// }

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isTelephony = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: _isTelephony ? TelephonyPackage() : SmsAdvancedPackage(),
      ),
    );
  }
}
