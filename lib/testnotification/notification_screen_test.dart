import 'package:flutter/material.dart';

import 'notification_service.dart';

class NotificationScreenTest extends StatefulWidget {
  const NotificationScreenTest({super.key});

  @override
  State<NotificationScreenTest> createState() => _NotificationScreenTestState();
}

class _NotificationScreenTestState extends State<NotificationScreenTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(children: [
        ElevatedButton(onPressed: (){
          NotificationService.showInstannotification("hei maruf", "jsdfkljsdlkfjldksfj");
        }, child: Text("show notification")),
        ElevatedButton(onPressed: (){}, child: Text("set notification notification")),
      ],),),
    );
  }
}
