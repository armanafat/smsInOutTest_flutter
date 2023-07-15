import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';


onBackgroundMessage(SmsMessage message) {
  debugPrint("onBackgroundMessage called");
}

class TelephonyPackage extends StatefulWidget {
  const TelephonyPackage({super.key});

  @override
  State<TelephonyPackage> createState() => _TelephonyPackageState();
}

class _TelephonyPackageState extends State<TelephonyPackage> {

  static const _testPhoneNumber = '09397956869';
  static const _testSmsMessage ='Hi ,this is a test';

  String _message = " ";
  List _messagesList= [];
  final telephony = Telephony.instance;



  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body ?? "Error reading message body.";
    });
  }

  onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }

    if (!mounted) return;

    List<SmsMessage> ListOne = await telephony
          .getInboxSms(
              columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
              filter: SmsFilter.where(SmsColumn.ADDRESS)
                  .equals("1234567890")
                  .and(SmsColumn.BODY)
                  .like("starwars"),
              sortOrder: [
                OrderBy(SmsColumn.ADDRESS, sort: Sort.ASC),
                OrderBy(SmsColumn.BODY)
              ])
          .then((value) => _messagesList = value);

  }


  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         Center(
                child: Text(
              "Latest received SMS: $_message and massage list items :$_messagesList",
              style: const TextStyle(fontSize: 24),
            )),
        TextButton(
            onPressed: () async {
              await telephony.sendSms(
                  to: _testPhoneNumber, message: _testSmsMessage);
            },
            child: const Text('send sms')),
        TextButton(
            onPressed: () async {
              await telephony.openDialer("123413453");
            },
            child: const Text('Open Dialer'))
        ],);
  }
}
