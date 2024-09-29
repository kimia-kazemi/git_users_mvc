import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:git_users_info/features/user_list/controllers/users_controller.dart';
import '../widgets/shimmer_loading.dart';

class UsersScreen extends GetView<UsersController> {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<UsersController>(
            id: 'loadMore',
            builder: (controller) {
              return RefreshIndicator(
                onRefresh: () => controller.onRefresh(),
                child: SingleChildScrollView(
                  padding:const EdgeInsets.symmetric(vertical: 18,horizontal: 8),
                  controller: controller.scrollController,
                  child: Card(
                    color: Colors.white.withOpacity(0.5),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (controller.allUsers.length != 0 ||
                              controller.allUsers.length != null)
                          ? controller.allUsers.length + 1
                          : controller.allUsers.length,
                      itemBuilder: (context, index) {
                        if (controller.allUsers.length == index) {
                          return  UiLoadingAnimation(
                            tileNum: (controller.allUsers.isNotEmpty) ? 1 : 30,
                          );
                        } else {
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 40.0,
                                backgroundImage:
                                NetworkImage(controller.allUsers[index].avatar),
                                backgroundColor: Colors.transparent,
                              ).marginOnly(right: 5),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(controller.allUsers[index].name,style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.w700)).marginOnly(bottom: 5),
                                  Text(controller.allUsers[index].htmlUrl,style: Theme.of(context)
                                      .textTheme
                                      .bodySmall,),
                                ],
                              ))
                            ],
                          ).marginOnly(bottom: 10);
                        }
                      },
                    ),
                  )
                ),
              );
            }),
      ),
    );
  }
}
