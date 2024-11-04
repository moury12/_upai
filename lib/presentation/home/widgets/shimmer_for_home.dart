import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:upai/core/utils/app_colors.dart';

class ShimmerCategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              6,
              (index) {
                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white),
                  margin: EdgeInsets.only(right: 8),
                  height: 40,
                  width: 200,
                  // color: Colors.white,
                );
              },
            ),
          ),
        ));
  }
}
class ShimmerRunnigOrder extends StatelessWidget {
  final bool? forList;

  const ShimmerRunnigOrder({super.key, this.forList=true});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
              children: List.generate(
                 forList!?10:2,
                    (index) {

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: OfferCardShimmer(),
                  );
                },
              )),
        );
  }
}
class OfferCardShimmer extends StatelessWidget {
  const OfferCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 2)
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child:Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                height:120.w,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 6,
              child: SizedBox(
                height:120.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            height: 16.w,
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 40.w,
                          width: 40.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height:12.w,
                      color: Colors.grey[300],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            children: [

                              Container(
                                height: 14.w,
                                width: 30.w,
                                color: Colors.grey[300],
                              ),
                              const Spacer(),
                              Container(
                                height:12.w,
                                width: 50.w,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 16.w,
                                width: 40.w,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ShimmerExploreTopService extends StatelessWidget {


  ShimmerExploreTopService({super.key});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child:SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: AlwaysScrollableScrollPhysics(),
          child: Row(
              children: List.generate(
                 10,
                    (index) {

                  return Padding(
                    padding:  EdgeInsets.only(left: 8.sp),
                    child: ShimmerContainer(height: 200.w,width: 200.w,),
                  );
                },
              )),
        ));
  }
}

class ShimmerContainer extends StatelessWidget {
  final double? height;
  final double? width;
  const ShimmerContainer({
    super.key, this.height, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(height: height,width: width,
      decoration:
    BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
    );
  }
}
class ShimmerSellerStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisSpacing: 6,
              crossAxisSpacing: 8,

              maxCrossAxisExtent:
              MediaQuery.of(context).size.width / 2.5),
          shrinkWrap: true,
          primary: false,
          children:List.generate(3, (index) =>
              Container(decoration:
              BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
              ),),
        ));
  }
}
class ShimmerCategoryDetailsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child:  GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12).copyWith(top:0),
          itemCount:9 ,
          gridDelegate:

          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8),
          itemBuilder: (context, index) {
            return Container( decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),);
          },
        ));
  }
}
class ShimmerOfferList extends StatelessWidget {final bool? fromServiceList;

  const ShimmerOfferList({super.key, this.fromServiceList=false});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine the number of columns and aspect ratio dynamically
    int crossAxisCount = 2;
    double childRatio=0.8;

    if (screenWidth > 600) {
      crossAxisCount = 3;
      childRatio =screenWidth> screenHeight?0.9:1;
    }
    if (screenWidth > 900) {
      crossAxisCount = 4; childRatio =screenWidth> screenHeight?0.9:1;
    }
    if (screenWidth > 1232) {
      crossAxisCount = 5; childRatio =1;
    }
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child:  GridView.builder(
          shrinkWrap: true,
          primary: false,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              // childAspectRatio:childRatio,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8),
          itemCount:
       fromServiceList!?10:   4,
          itemBuilder: (context, index) {

            return Container(padding: EdgeInsets.all(12),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(15),
              ),

            );
          },
        ),);
  }
}
