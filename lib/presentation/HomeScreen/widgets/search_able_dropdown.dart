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
      onTap: () {
        showMenu(
            surfaceTintColor: Colors.white,
            color: Colors.white,
            context: context,
            position: RelativeRect.fromRect(
                Rect.fromLTWH(0, 0, overlay.size.width, overlay.size.height),
                Offset.zero & overlay.size),
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
                                  child: TextButton(
                                child: Text(
                                  e['name'],
                                ),
                                onPressed: () {
                                  setState(() {
                                    HomeController.to.selectedDistrict.value =
                                        e['name'];
                                    Navigator.pop(context);
                                  });
                                },
                              ));
                            },
                          ).toList()
                        ],
                      );
                    },
                  ))
            ]).then(
          (value) {
            searchController.clear();
            setState(() {
              filterDistrict = HomeController.to.districtList;
            });
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Obx(() {
              return Text(
                HomeController.to.selectedDistrict.value ?? 'Select district',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              );
            }),
            Spacer(),
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
}
