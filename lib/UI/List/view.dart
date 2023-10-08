import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/List/controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  BaseState<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends BaseState<TodoListView> {
  String id = '';

  @override
  void initState() {
    super.initState();
    id = Get.parameters['id'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
        child: K_Appbar(
          AppText: id,
          action: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.settings),
            onPressed: () {
              RouteManager.normalRoute(
                RouteName.LIST_SETTINGS,
                parameters: {'id': id},
              );
            },
          ),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) => ListTile(
          leading: Checkbox(
            activeColor: const Color.fromARGB(255, 18, 84, 110),
            value: true,
            onChanged: (bool? value) {},
          ),
          onTap: () {
            showTask(context, dynamicWidth(0.3), 'task');
          },
          onLongPress: () {
            deleteTask(context, dynamicWidth(0.3));
          },
          title: Text('Görev ' + index.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          RouteManager.normalRoute(
            RouteName.CREATE_TASK,
            parameters: {'id': id},
          );
        },
        backgroundColor: const Color.fromARGB(255, 18, 84, 110),
        elevation: 0,
        child: Icon(MdiIcons.plus, color: Colors.white),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
    );
  }
}
