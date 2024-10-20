import 'package:get/get.dart';
import 'package:upai/presentation/create-offer/controller/create_offer_controller.dart';

class CreateOfferBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CreateOfferController());
  }
}
