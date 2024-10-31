import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:upai/core/utils/app_colors.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T? value;  // The selected value
  final String label;  // Dropdown hint label
  final List<T> menuList;  // Dropdown menu items
  final Function(T?)? onChanged;  // Callback to handle value changes
  final bool isEditArgument;  // Controls whether the dropdown is disabled or not

  const CustomDropDown({
    super.key,
    required this.value,
    required this.menuList,
    required this.label,
    required this.onChanged,
    this.isEditArgument = false, // Default to false unless specified
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButton<T>(

        dropdownColor: Colors.white, padding:EdgeInsets.symmetric(horizontal: 12.sp,vertical: 8.sp) ,
        style: TextStyle(color: AppColors.kprimaryColor,fontSize: 14.sp),
        iconSize: 20.sp,
        iconEnabledColor: AppColors.kprimaryColor,
        borderRadius: BorderRadius.circular(12),
        underline: const SizedBox.shrink(),
        value: value,
        hint: Text(
          label,
          style: TextStyle(color: Colors.grey,fontSize: 14.sp),
        ),
        items: menuList.map((element) {
          return DropdownMenuItem<T>(

            value: element,
            child: Text(element.toString(),style: TextStyle(fontSize: 14.sp)), // Convert element to string for display
          );
        }).toList(),
        onChanged: isEditArgument ? null : onChanged, // Disable dropdown if `isEditArgument` is true
      ),
    );
  }
}
