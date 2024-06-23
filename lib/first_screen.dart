import 'package:flutter/material.dart';
import 'package:upai/core/utils/global_variable.dart';
import 'package:upai/presentation/deafult_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              userType = "client";
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeafultScreen()));

            }, child: Text("Client")),
            ElevatedButton(onPressed: (){

              userType = "serviceprovider";
              Navigator.push(context, MaterialPageRoute(builder: (context) => DeafultScreen()));
            }, child: Text("Service Provider")),
          ],
        ),
      ),
    );
  }
}
