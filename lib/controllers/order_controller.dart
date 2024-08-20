import 'package:get/get.dart';
import 'package:upai/Boxes/boxes.dart';
import 'package:upai/Model/user_info_model.dart';
import 'package:upai/data/repository/repository_details.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find();
  RxString status = 'REJECTED'.obs;
late  UserInfoModel userInfoModel ;
  // "status":"in progress",
  // "status":"completed",
  @override
  void onInit() {
    userInfoModel=userInfoModelFromJson(Boxes.getUserData().get('user'));
    // TODO: implement onInit
    super.onInit();
  }
  void jobStatus(String jobId,String status,String awardDate,
      String completionDate) async {
    await RepositoryData.jobStatus(body: {
      "job_id": jobId,
      "status": status,
      "award_date": awardDate,
      "completion_date": completionDate
    });
  }
  void awardCreateJob(String offerId,String sellerId,String title,String description,String rateType,String rate,String quantity,String total,) async {
    await RepositoryData.awardCreateJob(body: {
      "offer_id": offerId,
      "buyer_mobile": sellerId,
      "seller_mobile": "${userInfoModel.userId}",
      "job_title":title,
      "description": description,
      "rate_type": rateType,
      "rate": rate,
      "quantity": quantity,
      "total": total,
      "status": "INPROGRESS"
    });
  }

  void completionReview() async {
    await RepositoryData.completionReview(body: {
      "job_id": "205",
      "status": "completed",
      "buyer_review": "awsome",
      "buyer_rating": "5",
      "seller_review": "very nice",
      "seller_rating": "5"
    });
  }
}
