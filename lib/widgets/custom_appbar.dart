import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? icon;
  const CustomAppBar({
    super.key,
    required this.title,  this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double appBarIconSize = ScreenUtil().screenHeight < ScreenUtil().screenWidth? 14.sp : defaultAppBarIconSize;

    return AppBar(
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor : Colors.white,
actions: [
  icon??SizedBox.shrink()
],
      iconTheme: IconThemeData(
          size: appBarIconSize,

          color:  Colors.white
      ),
      titleTextStyle:AppTextStyle.appBarTitle(context),
      title: Text(
        title,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}