import 'package:get/get.dart';
import 'package:ri_medicare/my_loans/my_loans_controller.dart';

class MyLoansBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MyLoansController());
  }

}