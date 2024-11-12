import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/default_widget.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/presentation/create-offer/controller/create_offer_controller.dart';
import 'package:upai/presentation/home/controller/home_controller.dart';
import 'package:upai/widgets/custom_text_field.dart';

class SearchableDropDown extends StatefulWidget {
  final bool? fromHome;
  final Widget? child;
  const SearchableDropDown({
    super.key,
    this.fromHome = true,
    this.child,
  });

  @override
  State<SearchableDropDown> createState() => _SearchableDropDownState();
}

class _SearchableDropDownState extends State<SearchableDropDown> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filterDistrict = [];
  final GlobalKey _dropdownKey = GlobalKey();

  @override
  void initState() {
    filterDistrict = HomeController.to.districtList;
    // TODO: implement initState
    super.initState();
  }

  void filterDistrictItem(String query) {
    setState(() {
      filterDistrict = HomeController.to.districtList
          .where(
            (element) => element['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    return GestureDetector(
      key: _dropdownKey,
      onTap: () {
        showCustomMenu(context, overlay).then(
          (value) {
            searchController.clear();
            setState(() {
              filterDistrict = HomeController.to.districtList;
            });
          },
        );
      },
      child: widget.fromHome == true
          ? Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                
                children: [
                  Image.asset(
                    ImageConstant.locationIcon,
                    height: 25.w,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Expanded(
                    child: Obx(() {
                      return Text(
                        textAlign: TextAlign.center,
                        HomeController.to.selectedDistrictForAll.value ??
                            'location'.tr,
                        style: AppTextStyle.bodyMediumWhiteSemiBold(context),
                      );
                    }),
                  )
                ],
              ))
          : Container(
              padding: const EdgeInsets.all(8),
              // margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Text(
                      widget.fromHome!
                          ? HomeController.to.selectedDistrictForAll.value ??
                              'select_district'.tr
                          : CreateOfferController.to.selectedDistrict.value ??
                          'select_district'.tr,
                      style: TextStyle(
                          fontSize: 15.sp,
                          // fontWeight: widget.fromHome!
                          //     ? HomeController
                          //                 .to.selectedDistrictForAll.value !=
                          //             null
                          //         ? FontWeight.w400
                          //         : FontWeight.w600
                          //     : CreateOfferController
                          //                 .to.selectedDistrict.value !=
                          //             null
                          //         ? FontWeight.w400
                          //         : FontWeight.w600,
                          color: widget.fromHome!
                              ? HomeController
                                          .to.selectedDistrictForAll.value !=
                                      null
                                  ? AppColors.kPrimaryColor
                                  : Colors.grey
                              : CreateOfferController
                                          .to.selectedDistrict.value !=
                                      null
                                  ? AppColors.kPrimaryColor
                                  : Colors.grey),
                    );
                  }),
                  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.kPrimaryColor,
                    size: 30,
                  )
                ],
              ),
            ),
    );
  }

  Future<dynamic> showCustomMenu(BuildContext context, RenderBox overlay) {
    final RenderBox buttonRenderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox;
    final Offset buttonOffset = buttonRenderBox.localToGlobal(Offset.zero);
    final Size buttonSize = buttonRenderBox.size;
    return showMenu(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        context: context,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        position: widget.fromHome == false
            ? const RelativeRect.fromLTRB(0, 0, 0, 0)
            : RelativeRect.fromLTRB(
                buttonOffset.dx,
                buttonOffset.dy + buttonSize.height,
                overlay.size.width - buttonOffset.dx - buttonSize.width,
                overlay.size.height - buttonOffset.dy - buttonSize.height),
        items: [
          PopupMenuItem(
              enabled: false,
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      CustomTextField(controller: searchController,hintText: 'Search district',
                        onChanged: (value) {
                          setState(() {
                            filterDistrictItem(value!);
                          });
                        },
                      ),
                      // TextField(
                      //   controller: searchController,
                      //   cursorColor: AppColors.kprimaryColor,
                      //   decoration: InputDecoration(
                      //       hintText: 'Search district',
                      //       focusedBorder: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //           borderSide: BorderSide(
                      //               color: AppColors.kprimaryColor, width: 2)),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       )),
                      //   onChanged: (value) {
                      //     setState(() {
                      //       filterDistrictItem(value);
                      //     });
                      //   },
                      // ),
                      ...filterDistrict.map(
                        (e) {
                          return PopupMenuItem(
                            padding: EdgeInsets.zero,
                            height: 10,
                            child: InkWell(
                              onTap: () {
                                if (widget.fromHome!) {
                                  HomeController.to.selectedDistrictForAll
                                      .value = e['name'];
                                  HomeController.to.getOfferDataList();
                                  HomeController.to.getOfferList.refresh();
                                  HomeController.to.newServiceList.refresh();
                                  HomeController.to.currentPage.value = 1;
                                  HomeController
                                      .to.currentPageForNewService.value = 1;
                                  print(HomeController.to.newServiceList.length);
                                } else {
                                  CreateOfferController
                                      .to.selectedDistrict.value = e['name'];
                                }
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    e['name'],
                                    style: TextStyle(fontSize: default14FontSize),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  );
                },
              ))
        ]);
  }
}
