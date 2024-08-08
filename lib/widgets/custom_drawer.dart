import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';

import '../core/utils/image_path.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child: Drawer(
        backgroundColor:AppColors.strokeColor2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
    
            ),
            child: Column(
    
    
              children: [
                const SizedBox(
    
                  height: 30,
                ),
                Container(
                    height: 150,
                    width: 150,
                    child:  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
    
                        backgroundImage: AssetImage(ImageConstant.senderImg),
                      )
                    )
                ),
                Text("Mr. Frank",style: AppTextStyle.bodyLarge700,),
                Text("User Type : Buyer",style: AppTextStyle.titleText,),
                const SizedBox(height: 5,),
                const Divider(
                  height: 3,
                ),
                const ListTile(
                  leading: Icon(
                    Icons.change_circle_outlined,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Switch Account',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Divider(
                  height: 3,
                ),
                const ListTile(
                  leading: Icon(Icons.settings, color: Colors.black),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Divider(
                  height: 3,
                ),
                InkWell(
                  onTap: () async {
                  final box =  Hive.box('userInfo');
               await box.delete("user");
                 print("Data deleted");
    
                 Get.offAllNamed('/login');
                  },
                  child: const ListTile(
                    leading: Icon(Icons.logout, color: Colors.black),
                    title: Text(
                      'Log out',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const Divider(
                  height: 3,
                ),
    
              ],
            ),
          ),
        ),
      ),
  );
  }
}


