import 'package:get/get.dart';
import 'package:ri_medicare/kyc_page/kyc_page_controller.dart';

class KYCPageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => KYCController());
  }
}