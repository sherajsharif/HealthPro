import 'package:get/get.dart';
import 'package:ri_medicare/auth/auth_controller.dart';

class AuthBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }

}