import 'package:get/get.dart';
import '../features/user_list/controllers/users_controller.dart';


class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(UsersController(), permanent: true);
  }
}