import 'package:flutter/material.dart';
import 'package:upai/core/utils/app_colors.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/presentation/HomeScreen2/widgets/my_service.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Upai",style: AppTextStyle.bodyTitle700,),
        centerTitle: true,
        automaticallyImplyLeading: false,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: size.width,
               // height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.containerBackground,

                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12,right: 12,top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 8,
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("Your Stats",style: AppTextStyle.bodyMediumBlack700,),
                          SizedBox(height: 13,),
                          Text("Total Earning",style: AppTextStyle.titleTextSmallwithoutUnderLine,),
                          Text(
                            "৳2500",
                            style: AppTextStyle.bodyLarge,
                          ),
                          SizedBox(height: 5,),
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                            padding: EdgeInsets.all(2),

                              child: Text("5% increased from previous month ",style: AppTextStyle.bodySmallestTextGrey400,)),

                        ],
                      )),
                      Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                                "This month"),
                          ),
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: Text(
                          //       "This month"),
                          // ),
                          SizedBox(height: 20,),
                          Text("Completed Job",style: AppTextStyle.titleTextSmallwithoutUnderLine,),
                          Text(
                            "5",
                            style: AppTextStyle.bodyLarge,
                          ),
                          SizedBox(height: 5,),
                          Text("Review",style: AppTextStyle.bodySmallBlack400S15CGrey,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             Icon( Icons.star,size: 22,),
                              Text(
                               "4.7",
                                style: AppTextStyle.bodyLarge,
                              ),
                            ],
                          ),


                        ],
                      ))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Running Orders",style: AppTextStyle.titleText),
                  Text("All Orders>",
        
                      style: AppTextStyle.titleTextSmall),
        
                ],
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.containerBackground,
                ),
                width: size.width,
                height: 70,
              ),
              SizedBox(height: 50,),
              Text("My Services",style: AppTextStyle.titleText),
              const SizedBox(height: 10,),
              SizedBox(
                width: size.width,
                height: 180,
                child:ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return MyService();
                  },),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
