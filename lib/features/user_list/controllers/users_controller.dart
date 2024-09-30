import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api_services.dart';
import '../models/user_model.dart';

class UsersController extends GetxController {
  List<UserModel> allUsers = [];
  ScrollController scrollController = ScrollController();
  var page = 1;
  var perPage = 30;

  @override
  void onInit() {
    getUsersList();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getUsersList();
      }
    });
    super.onInit();
  }
  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  Future<void> onRefresh() async {
    page = 1;
    perPage = 30;
    allUsers.clear();
    update(['loadMore']);
    await getUsersList();
  }

  getUsersList() async {
    try {
      var response = await Api().getUsers(page, perPage);
      var dataJson = response.data;
      var userList = (dataJson as List)
          .map((carItemJson) => UserModel.fromJson(carItemJson))
          .toList();

      allUsers.addAll(userList);
      page++;
    } catch (e) {
      print('Error fetching repos: $e');
    } finally {
      update(['loadMore']);
    }
    print(allUsers);
  }
}
