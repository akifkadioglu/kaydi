import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/List/Settings/Search/view_controller.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/models/user_lists_model.dart';
import 'package:kaydi_mobile/core/models/user_model.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';

void searchEmail(String mail) async {
  TodoListSearchViewController c = Get.put(TodoListSearchViewController());
  c.setLoading;
  var users = await CloudManager.getCollection(CloudManager.USERS).where("email", isEqualTo: mail.trim()).get();

  var list = users.docs.map(
    (e) => UserModel(
      id: e["id"],
      photoUrl: e["photo_url"],
      email: e["email"],
      name: e["name"],
      isAllowRequest: e["is_allow_request"],
    ),
  );
  c.setLoading;
  c.users.value = list
      .where(
        (element) => element.isAllowRequest,
      )
      .toList();
}

Future<dynamic> addUserDialog(BuildContext context, double width, UserModel user) {
  ListsController c = Get.put(ListsController());
  TodoListSearchViewController todoListSearchViewController = Get.put(TodoListSearchViewController());
  return showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        scrollable: true,
        elevation: 0,
        content: Text(user.name + " " + translate(IKey.ADD_USER_TO_LIST)),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(translate(IKey.CLOSE)),
                ),
              ),
              SizedBox(
                width: width,
                child: Obx(
                  () => FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 23, 116, 153),
                      elevation: 0,
                    ),
                    onPressed: todoListSearchViewController.isLoading.isTrue
                        ? null
                        : () async {
                            todoListSearchViewController.setLoading;
                            await CloudManager.getCollection(CloudManager.USER_LISTS).add(
                              UserListsModel(userId: user.id, listId: c.theList.value.id).toJson(),
                            );

                            todoListSearchViewController.setLoading;
                            RouteManager.back();
                            RouteManager.back();
                          },
                    child: Text(translate(IKey.ADD)),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
