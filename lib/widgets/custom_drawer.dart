import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';

import '../core/utils/image_path.dart';
import '../data/api/firebase_apis.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.userInfo});
  final UserInfoModel userInfo;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.backgroundLight,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(ImageConstant.senderImg),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 15),
                Center(
                  child: Text(
                    widget.userInfo.name.toString(),
                    style: AppTextStyle.bodyLarge700.copyWith(
                      fontSize: 20.0,
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                  widget.userInfo.userId.toString(),
                    style: AppTextStyle.titleText.copyWith(
                      fontSize: 14.0,
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildMenuOption(
                  icon: Icons.person,
                  label: 'Profile',
                  onTap: () => Get.toNamed('/profile'),
                ),
                _buildMenuOption(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () {},
                ),
                _buildMenuOption(
                  icon: Icons.logout,
                  label: 'Log out',
                  onTap: () async {
                    final box = Hive.box('userInfo');
                    await box.delete("user");
                    print("Data deleted");
                    FirebaseAPIs.updateActiveStatus(false);
                    Get.offAllNamed('/login');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ListTile(
            leading: Icon(icon, color: AppColors.iconColor),
            title: Text(
              label,
              style: TextStyle(
                color: AppColors.primaryTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Divider(
          color: AppColors.dividerColor,
          thickness: 0.8,
        ),
      ],
    );
  }
}
