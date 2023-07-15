import 'package:flutter/material.dart';
import 'package:sms_advanced/sms_advanced.dart';



class SmsAdvancedPackage extends StatefulWidget {
  const SmsAdvancedPackage({super.key});

  @override
  State<SmsAdvancedPackage> createState() => _SmsAdvancedPackageState();
}

class _SmsAdvancedPackageState extends State<SmsAdvancedPackage> {

  final SmsQuery query = SmsQuery();
  List<SmsThread> threads = [];

  @override
  void initState() {
    super.initState();
    query.getAllThreads.then((value) {
      threads = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: threads.length,
        itemBuilder: (BuildContext context, int index){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                minVerticalPadding: 8,
                minLeadingWidth: 4,
                title: Container(
                    decoration: BoxDecoration(border: Border.all(width: 3)),
                    child: Text(threads[index].messages.last.body ?? 'empty')),
                subtitle: Text(threads[index].contact?.address ?? 'empty'),
              ),
              const Divider()
            ],
          );
        });
  }
}
