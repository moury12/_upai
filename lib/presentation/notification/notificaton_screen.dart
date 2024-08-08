import 'package:flutter/material.dart';

class NotificatonScreen extends StatefulWidget {
  const NotificatonScreen({super.key});

  @override
  State<NotificatonScreen> createState() => _NotificatonScreenState();
}

class _NotificatonScreenState extends State<NotificatonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: Text("NO Notification Yet"),
        ),
      ),

    );
  }
}
