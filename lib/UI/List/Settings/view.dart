import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/List/Settings/controller.dart';
import 'package:kaydi_mobile/UI/List/Settings/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/constants/parameters.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:kaydi_mobile/core/toast/manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoListSettingsView extends StatefulWidget {
  const TodoListSettingsView({super.key});

  @override
  BaseState<TodoListSettingsView> createState() => _TodoListSettingsView();
}

class _TodoListSettingsView extends BaseState<TodoListSettingsView> {
  ListsController c = Get.put(ListsController());
  TodoListSettingsViewController todoListController = Get.put(TodoListSettingsViewController());

  @override
  void initState() {
    super.initState();
    c.theList.value = ListElement.fromJson(jsonDecode(Get.parameters[Parameter.LIST].toString()));
    checkCloud(c.theList.value.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: K_Appbar(
          AppText: c.theList.value.name,
        ),
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dynamicWidth(0.05), vertical: 20),
          child: Column(
            children: [
              Obx(
                () => TextField(
                  keyboardType: TextInputType.name,
                  readOnly: true,
                  onTap: c.theList.value.inCloud
                      ? () {
                          RouteManager.normalRoute(
                            RouteName.LIST_SEARCH,
                            parameters: {Parameter.ID: c.theList.value.id},
                          );
                        }
                      : () {
                          ToastManager.toast(translate(IKey.TOAST_1));
                        },
                  decoration: InputDecoration(
                    isDense: true,
                    helperMaxLines: 2,
                    filled: true,
                    hintText: translate(IKey.ADD_SOMEONE),
                    helperText: translate(IKey.ADD_SOMEONE_DESCRIPTION),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(translate(IKey.NOTIFICATIONS)),
                trailing: Switch(
                  activeColor: Color.fromARGB(255, 40, 194, 255),
                  value: true,
                  onChanged: (value) {},
                ),
                onTap: () {},
              ),
              Divider(),
              Obx(
                () => ListTile(
                  leading: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    switchOutCurve: Curves.easeInOut,
                    child: todoListController.isLoading.value
                        ? CircularProgressIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.cloudOutline),
                            ],
                          ),
                  ),
                  title: Text(c.theList.value.inCloud ? translate(IKey.IN_CLOUD) : translate(IKey.MOVE_TO_CLOUD)),
                  onTap: c.theList.value.inCloud
                      ? null
                      : () {
                          moveToCloud(c.theList.value.id);
                        },
                  subtitle: c.theList.value.inCloud
                      ? null
                      : Text(
                          translate(IKey.MOVE_TO_CLOUD_DESCRIPTION),
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(MdiIcons.accountOutline),
                  ],
                ),
                title: Text(translate(IKey.USERS)),
                onTap: () {},
                
              ),
              ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(MdiIcons.logout),
                  ],
                ),
                title: Text(translate(IKey.LEAVE)),
                onTap: () {
                  leaveFromList(c.theList.value.id);
                  RouteManager.goRouteAndRemoveBefore(RouteName.HOME);
                },
                subtitle: Text(
                  translate(IKey.LEAVE_DESCRIPTION),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
