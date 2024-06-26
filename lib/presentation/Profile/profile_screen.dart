import 'package:flutter/material.dart';
import 'package:upai/widgets/client_review_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Profile Screen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
