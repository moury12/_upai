
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/controllers/filter_controller.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_button.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/global_variable.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/presentation/HomeScreen/controller/home_controller.dart';
import 'package:upai/presentation/HomeScreen/widgets/search_able_dropdown.dart';
import 'package:upai/presentation/create-offer/widget/custom_drop_down.dart';
import 'package:upai/presentation/service-list/service_list_screen.dart';

class FilterBanner extends StatefulWidget {
  final bool? isService;
  final bool? isNewestArrival;
  const FilterBanner({
    super.key,
    this.isService = false,
    this.isNewestArrival = false,
  });

  @override
  State<FilterBanner> createState() => _FilterBannerState();
}

class _FilterBannerState extends State<FilterBanner> {
  @override
  void initState() {
    Get.put(FilterController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => FilterDialog(
                    isNewestArrival: widget.isNewestArrival!,
                  ),
                );
              },
              icon: Image.asset(
                ImageConstant.filterIcon,
                color: AppColors.kprimaryColor,
                height: 30,
              )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchableDropDown(
              fromHome: true,
            ),
          )),
          widget.isService!
              ? SizedBox.shrink()
              : Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(ServiceListScreen.routeName, arguments: "");
                    },
                    child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColors.kprimaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstant.serviceIcon,
                              height: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              'Service',
                              style: AppTextStyle.bodyMediumWhiteSemiBold,
                            )
                          ],
                        )),
                  ),
                )
        ],
      ),
    );
  }
}

class FilterDialog extends StatelessWidget {
  final bool isNewestArrival;
  const FilterDialog({
    super.key,
    required this.isNewestArrival,
  });

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      title: Text(
        'Search Filter',
        style: AppTextStyle.bodyMediumBlackBold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return FilterDropdown<String?>(
              menuList: serviceType,
              value: FilterController.to.selectedServiceType.value,
              onChanged: (val) {
                FilterController.to.selectedServiceType.value = val;
              },
              label: 'Select service type',
              title: 'Service Type:',
            );
          }),
          Obx(() {
            return FilterDropdown(
              menuList: HomeController.to.getCatList
                  .map(
                    (element) => element.categoryName,
                  )
                  .toList(),
              value: FilterController.to.selectedCategory.value,
              onChanged: (val) {
                FilterController.to.selectedCategory.value = val;
              },
              label: 'Select service category',
              title: 'Service category:',
            );
          }),
          Obx(() {
            return FilterDropdown<String?>(
              menuList: const ['Rating', 'Newest Arrival', 'Best Selling'],
              value: FilterController.to.selectedSortBy.value,
              onChanged:  (val) {
                      FilterController.to.selectedSortBy.value = val;
                    },
              label: 'select sort by',
              title: 'Sort By:',
            );
          }),
          Divider()
        ],
      ),
      contentPadding: EdgeInsets.all(12).copyWith(bottom: 0),
      actionsPadding:
          EdgeInsets.symmetric(vertical: 8, horizontal: 8).copyWith(top: 0),
      actions: [
        CustomTextButton(
          primary: AppColors.cancelButtonColor,
          label: 'Cancel',
          onChange: () {
            Navigator.pop(context);
          },
        ),
        CustomTextButton(
          label: 'Apply',
          onChange: () {
            HomeController.to.getOfferDataList();
            HomeController.to.currentPage.value=1;
            HomeController.to.currentPageForNewService.value=1;
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class FilterDropdown<T> extends StatelessWidget {
  final String title;
  final T value;
  final String label;
  final List<T> menuList;

  final Function(T?)? onChanged;
  const FilterDropdown({
    super.key,
    required this.title,
    required this.value,
    required this.label,
    required this.menuList,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Text(title, style: AppTextStyle.bodySmallblack),
        sizeBoxHeight6,
        CustomDropDown(
            isEditArgument: false,
            menuList: menuList,
            value: value,
            onChanged: onChanged ?? null,
            label: label)
      ],
    );
  }
}
