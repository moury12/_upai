

import '../../Boxes/boxes.dart';

class ApiClient {
  //static const String _baseUrl = "http://103.119.102.117:8000/upai_api";
  late String _baseUrl;
  ApiClient()
  {
   // _baseUrl= "${Boxes.getDmPathBox().get("BaseUrl").toString()}/upai_api";
 _baseUrl= "http://192.168.100.245:8002/upai_api";
 //    _baseUrl= "http://103.119.102.117:8000/upai_api";
  }
  String get loginUrl => '$_baseUrl/login';
  String get createUserUrl => '$_baseUrl/create_user';
  String get getCategoryList => '$_baseUrl/get_category_list';
  String get getOfferList => '$_baseUrl/get_offer_list';
  String get createOffer => '$_baseUrl/create_offers';
  String get jobStatus => '$_baseUrl/job_status';
  String get awardCreateJob => '$_baseUrl/award_create_job';
  String get completionReview => '$_baseUrl/completion_review';
  String get sellerProfile => '$_baseUrl/seller_profile';
  String get buyerProfile => '$_baseUrl/buyer_profile';
  String get deleteOffer => '$_baseUrl/delete_offer';
  String get editOffer => '$_baseUrl/edit_offer';
  String get userUpdate => '$_baseUrl/user_profile';


}
