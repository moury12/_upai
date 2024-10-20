import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';

class CustomDropDown<T> extends StatelessWidget {
  final T? value;  // The selected value
  final String label;  // Dropdown hint label
  final List<T> menuList;  // Dropdown menu items
  final ValueChanged<T?> onChanged;  // Callback to handle value changes
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kprimaryColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<T>(
        dropdownColor: Colors.white,
        style: TextStyle(color: AppColors.kprimaryColor),
        iconEnabledColor: AppColors.kprimaryColor,
        borderRadius: BorderRadius.circular(12),
        underline: const SizedBox.shrink(),
        value: value,
        hint: Text(
          label,
          style: TextStyle(color: AppColors.kprimaryColor),
        ),
        items: menuList.map((element) {
          return DropdownMenuItem<T>(
            value: element,
            child: Text(element.toString()), // Convert element to string for display
          );
        }).toList(),
        onChanged: isEditArgument ? null : onChanged, // Disable dropdown if `isEditArgument` is true
      ),
    );
  }
}