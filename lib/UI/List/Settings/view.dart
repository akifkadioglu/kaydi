import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/List/Settings/controller.dart';
import 'package:kaydi_mobile/UI/List/Settings/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/constants/parameters.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TodoListSettingsView extends StatefulWidget {
  const TodoListSettingsView({super.key});

  @override
  BaseState<TodoListSettingsView> createState() => _TodoListSettingsView();
}

class _TodoListSettingsView extends BaseState<TodoListSettingsView> {
  String id = '';
  String listName = '';
  TodoListSettingsViewController c = Get.put(TodoListSettingsViewController());

  @override
  void initState() {
    super.initState();
    id = Get.parameters[Parameter.ID].toString();
    listName = Get.parameters[Parameter.LIST_NAME].toString();
    checkCloud(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: K_Appbar(
          AppText: listName,
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
                  onTap: c.inCloud.value
                      ? () {
                          RouteManager.normalRoute(
                            RouteName.LIST_SEARCH,
                            parameters: {Parameter.ID: id},
                          );
                        }
                      : () {
                          Fluttertoast.showToast(
                            msg: translate(IKey.TOAST_1),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0,
                          );
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
                    child: c.isLoading.value
                        ? CircularProgressIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.cloudOutline),
                            ],
                          ),
                  ),
                  title: Text(c.inCloud.value ? translate(IKey.IN_CLOUD) : translate(IKey.MOVE_TO_CLOUD)),
                  onTap: c.inCloud.value
                      ? null
                      : () {
                          moveToCloud(id);
                        },
                  subtitle: c.inCloud.value
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
                    Icon(MdiIcons.logout),
                  ],
                ),
                title: Text(translate(IKey.LEAVE)),
                onTap: () {
                  leaveFromList(id);
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
