import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/presentation/HomeScreen/controller/home_screen_controller.dart';

class SearchableDropDown extends StatefulWidget {
  const SearchableDropDown({
    super.key,
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
      filterDistrict = HomeController.to.districtList.value
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
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return Text(
                HomeController.to.selectedDistrictForAll.value ?? 'Select district',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: HomeController.to.selectedDistrictForAll.value != null
                        ?FontWeight.w400: FontWeight.w600,
                    color: HomeController.to.selectedDistrictForAll.value != null
                        ? Colors.black
                        : Colors.black.withOpacity(.6)),
              );
            }),

            Icon(
              Icons.arrow_drop_down,
              color: Colors.black54,
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
        position: RelativeRect.fromLTRB(
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
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: 'Search district',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onChanged: (value) {
                          setState(() {
                            filterDistrictItem(value);
                          });
                        },
                      ),
                      ...filterDistrict.map(
                        (e) {
                          return PopupMenuItem(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  HomeController.to.selectedDistrictForAll.value =
                                      e['name'];
                                  HomeController.to.filterOffer(HomeController.to.searchOfferController.value.text);
                                  Navigator.pop(context);
                                });
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  e['name'],
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList()
                    ],
                  );
                },
              ))
        ]);
  }
}