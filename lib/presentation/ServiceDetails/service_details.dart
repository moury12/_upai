import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:upai/core/utils/custom_text_style.dart';
import 'package:upai/core/utils/image_path.dart';
import 'package:upai/widgets/item_service.dart';

import '../../core/utils/app_colors.dart';

class ServiceDetails extends StatelessWidget {
  const ServiceDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                height: 200,
                color: Colors.green,
                child: Stack(
                  children: [
                    Image.asset(
                      ImageConstant.serviceImg,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                      ),
                    )),
                    Positioned(
                        right: 38,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.heart_broken_outlined,
                          ),
                        )),
                    Positioned(
                        right: 8,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.share_outlined),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Catering Services for lunch, evening/ Office and occasion.",
                  style: AppTextStyle.bodyMediumBlack700,
                ),
              ),
              const Divider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(ImageConstant.man),
                ),
                title: Text(
                  "Service Provider Name",
                  style: AppTextStyle.bodyMedium,
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "230 Job completed",
                      style: AppTextStyle.bodySmallBlack400S15CGrey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "4.9 Rating ",
                      style: AppTextStyle.bodySmallBlack400S15CGrey,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: AppTextStyle.titleText,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                      " It has survived not only five centuries, but also the"
                      " leap into electronic typesetting, remaining essentially unchanged...."
                      " See More",
                      style: AppTextStyle.bodySmallBlack400,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Includes",
                      style: AppTextStyle.titleText,
                    ),
                    SizedBox(
                      width: size.width,
                      height: 100,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return const Text("Feature");
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Price",
                                style: AppTextStyle.titleText,
                              ),
                              Text(
                                "৳ 550.0/h",
                                style: AppTextStyle.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                backgroundColor: AppColors.BTNbackgroudgrey,
                                foregroundColor: AppColors.colorWhite),
                            child: const Text("Chat Now"),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    Container(
                      color: const Color(0xffF2F2F2),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Frequently Asked ",
                              style: AppTextStyle.bodyMediumBlack400,
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          "4.4",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        RatingBarIndicator(
                          rating: 4.4,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: AppColors.colorLightBlack,
                          ),
                          itemCount: 5,
                          itemSize: 22.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RateByCat(
                      rateCat: "Seller Communication Level",
                      rating: "4.6",
                    ),
                    RateByCat(
                      rateCat: "Service Quality",
                      rating: "4.6",
                    ),
                    RateByCat(
                      rateCat: "Service as described",
                      rating: "4.6",
                    ),
                    RateByCat(
                      rateCat: "Seller Behavior",
                      rating: "4.6",
                    ),
                    RateByCat(
                      rateCat: "Recommend Service",
                      rating: "4.6",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Client Review", style: AppTextStyle.titleText),
                    const SizedBox(height: 15,),
                    SizedBox(
                      width: size.width,
                      height: 200,
                      child: ListView.builder(
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder:
                          (context, index) {
                        return   ClientReviewCard(size: size);
                      },),

                    ),
               
                    // Container(
                    //   width: size.width,
                    //   height: 400,
                    //   child:  Column(
                    //     children: [
                    //       ListTile(
                    //         leading: CircleAvatar(
                    //           backgroundImage:  AssetImage(ImageConstant.man),
                    //         ),
                    //         title: Text("Client Name",style: AppTextStyle.bodyMedium,),
                    //         subtitle: Text("22 Jan, 2023",style: AppTextStyle.bodySmallBlack400S15CGrey,),
                    //         trailing:Row(
                    //           children: [
                    //             Expanded(
                    //               child: RatingBarIndicator(
                    //                 rating: 4.4,
                    //                 itemBuilder: (context, index) => Icon(
                    //                   Icons.star,
                    //                   color: AppColors.colorLightBlack,
                    //                 ),
                    //                 itemCount: 5,
                    //                 itemSize: 16.0,
                    //                 direction: Axis.horizontal,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(
                      height: 10,
                    ),
                    Text("Explore Top Services", style: AppTextStyle.titleText),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width,
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ItemService();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ClientReviewCard extends StatelessWidget {
  const ClientReviewCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width*0.8,
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(ImageConstant.man),
                        ),
                        SizedBox(width: 5,),
                        Column(
                          children: [
                            Text("Client Name",
                                style: AppTextStyle.bodyMedium),
                            Text("22 Jan, 2023",
                                style: AppTextStyle.bodySmallBlack400S15CGrey),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("4.6",),
                        RatingBarIndicator(
                          rating: 4.4,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: AppColors.colorLightBlack,
                          ),
                          itemCount: 5,
                          itemSize: 16.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Text("Lorem ipsum dolor sit amet consectetur. Ornare pretium sit faucibus non massa sit. At integer nulla vel nisi. Turpis morbi vulputate placerat lacus pellentesque sed."
                  " Vel sit nibh in id dictum augue.Lorem ipsum dolor sit amet consectetur. Ornare pretium sit faucibus non massa sit. At integer nulla vel nisi. Turpis morbi vulputate placerat lacus pellentesque sed."
                  " Vel sit nibh in id dictum augue.",
              overflow: TextOverflow.ellipsis,maxLines: 5,)
            ],
          ),
        ),
      ),
    );
  }
}

class RateByCat extends StatelessWidget {
  final String rateCat;
  final String rating;
  const RateByCat({
    super.key,
    required this.rateCat,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(rateCat),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 16,
                color: AppColors.colorLightBlack,
              ),
              Text(
                rating,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
