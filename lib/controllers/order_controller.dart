import 'package:get/get.dart';
import 'package:upai/Model/notification_model.dart';
import 'package:upai/Model/seller_profile_model.dart';
import 'package:upai/data/repository/repository_details.dart';
import 'package:upai/presentation/Profile/profile_screen_controller.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  RxString status = 'REJECTED'.obs;
  ProfileScreenController? ctrl;

// late  UserInfoModel userInfoModel ;
  // "status":"in progress",
  // "status":"completed",
  @override
  void onInit() {
    ctrl = Get.put(ProfileScreenController());

    // userInfoModel=userInfoModelFromJson(Boxes.getUserData().get('user'));
    // TODO: implement onInit
    super.onInit();
  }
  void jobStatus(context,SellerRunningOrder runningOrder) async {

  }
  void awardCreateJob(String duration,String offerId,String sellerId,String title,String description,String packageId,String packageName,String price,) async {
    await RepositoryData.awardCreateJob(body: {
      "cid":"UPAI",
      "offer_id": offerId,
      "buyer_id": "${ctrl!.userInfo.value.userId}",
      "seller_id": sellerId,
      "job_title":title,
      "description": description,
      "package_id":packageId,
      "package_name":packageName,
      "price":price,
      "duration":duration,
      "status": "PENDING"
    },sellerID: sellerId);
  }

  void completionReview(String reviewText,String rating,NotificationModel notification) async {
    await RepositoryData.completionReview(body: {
      "job_id": notification.jobId,
      "status": "COMPLETED",
      "buyer_review": reviewText,
      "buyer_rating": double.parse(rating),
      // "seller_review": "",
      "completion_date":DateTime.now().toString(),
      // "seller_rating": ""
    },notification: notification);
  }
}
