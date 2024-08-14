import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/widgets/custom_text_field.dart';

import 'widgets/my_service_widget.dart';

class MyServiceListScreen extends StatelessWidget {
  final List<MyService> service;
  const MyServiceListScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return  PopScope( canPop: true,
      onPopInvoked: (didPop) {
        // controller.searchController.value.clear();
        //
        // controller.filterOffer('');
      },
      child: Scaffold(
          backgroundColor: AppColors.strokeColor2,
          appBar: AppBar(
            elevation: 0,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            backgroundColor: AppColors.strokeColor2,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () {
                Get.back();
                // controller.searchController.value.clear();
                //
                // controller.filterOffer('');
              },
            ),
            title:Text(
              "My Services",
              style: AppTextStyle.appBarTitle,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0)
                    .copyWith(bottom: 12),
                child:
                   CustomTextField(

                    hintText: "Search service..",
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // controller.searchController.value.clear();
                        // controller.filterOffer('');
                      },
                    ),
                  )

              ),
              Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                        MediaQuery.of(context).size.width >
                            MediaQuery.of(context).size.height
                            ? MediaQuery.of(context).size.width / 4
                            : MediaQuery.of(context).size.width / 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemCount: service.length,
                    itemBuilder: (context, index) {

                      return GestureDetector(
                          onTap: () {
                            // Get.to(
                            //   ServiceDetails(
                            //     offerDetails: service,
                            //   ),
                            // );
                          },
                          child: MyServiceWidget(
                            service: service[index],
                          ));
                    },
                  ))
            ],
          )),
    );
  }
}
