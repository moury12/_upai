import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/core/utils/app_colors.dart';
import '../../core/utils/custom_text_style.dart';
import 'widgets/running_order_widget.dart';

class RunningOrderListScreen extends StatelessWidget {
  final List<RunningOrder> runningOrder;

  RunningOrderListScreen({super.key, required this.runningOrder});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 4 : 2;
    return Scaffold(
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
            },
          ),
          title: Text(
            "Running Orders",
            style: AppTextStyle.appBarTitle,
          ),
        ),
        body: runningOrder.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : ListView.builder(padding: EdgeInsets.all(12),
                itemCount: runningOrder.length,
                itemBuilder: (context, index) {
                  return RunningOrderWidget(
                    runningOrder: runningOrder[index],
                  );
                },
              ));
  }
}