import 'package:get/get.dart';
import 'package:upai/data/repository/repository_details.dart';

class OrderController extends GetxController{
  static OrderController get to => Get.find();
  RxString status ='REJECTED'.obs;
  // "status":"in progress",
  // "status":"completed",
  void jobStatus() async{
    await RepositoryData.jobStatus(body: {
      "job_id":"205",

      "status":status,
      "award_date":"2024-07-29",
      "completion_date":"2024-08-29"


    });
  }
  void awardCreateJob() async{
    await RepositoryData.createOffer(body: {
      "offer_id": "102",
      "buyer_mobile": "8801333",
      "seller_mobile": "8800170000",
      "job_title": "Any electrical issus is resolved",
      "description": "per 1 hour 100 tk",
      "rate_type": "hour",
      "rate": "100",
      "quantity": "12",
      "total": "1200",
      "status": "ACCEPTED"
    });
  }
  void completionReview() async{
    await RepositoryData.completionReview(body: {
      "job_id":"205",
      "status":"completed",
      "buyer_review":"awsome",
      "buyer_rating":"5",
      "seller_review":"very nice",
      "seller_rating":"5"
    });
  }
}