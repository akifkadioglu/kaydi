import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/List/Settings/Users/controller.dart';
import 'package:kaydi_mobile/UI/List/Settings/Users/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/base/view.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';

class ListUsersView extends StatefulWidget {
  const ListUsersView({super.key});

  @override
  BaseState<ListUsersView> createState() => _ListUsersViewState();
}

class _ListUsersViewState extends BaseState<ListUsersView> {
  ListsController listsController = Get.put(ListsController());
  ListUsersViewController c = Get.put(ListUsersViewController());
  @override
  void initState() {
    super.initState();
    getListUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(builder: (context) {
      return Scaffold(
        appBar: PreferredSize(
          child: K_Appbar(
            AppText: listsController.theList.value.name,
          ),
          preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
        ),
        body: Obx(
          () => SizedBox(
            child: c.isLoading.value
                ? LinearProgressIndicator()
                : ListView.builder(
                    itemCount: c.users.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(c.users[index].photoUrl),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(c.users[index].name),
                        subtitle: Text(c.users[index].email),
                        isThreeLine: false,
                        subtitleTextStyle: TextStyle(overflow: TextOverflow.ellipsis),
                      );
                    },
                  ),
          ),
        ),
      );
    });
  }
}
