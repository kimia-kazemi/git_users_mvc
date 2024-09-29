import 'package:get/get.dart';
import 'package:git_users_info/core/binding_dependency.dart';
import 'package:git_users_info/core/routes/app_routes.dart';
import '../../features/user_list/views/users_screen.dart';

class AppPages {
  static List<GetPage> listPage = [
    GetPage(name: AppRoutes.all_user_screen, page: () => const UsersScreen(), binding: MainBinding()),
  ];
}