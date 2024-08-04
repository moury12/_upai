

class ApiClient {
  static const String _baseUrl = "http://192.168.0.211:8000/upai_api";

  String get loginUrl => '$_baseUrl/login';
  String get createUserUrl => '$_baseUrl/create_user';
  String get getCategoryList => '$_baseUrl/get_category_list';
  String get getOfferList => '$_baseUrl/get_offer_list';
  String get createOffer => '$_baseUrl/create_offers';
  String get jobStatus => '$_baseUrl/job_status';
  String get awardCreateJob => '$_baseUrl/award_create_job';


}
