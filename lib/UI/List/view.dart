import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/List/controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/constants/parameters.dart';
import 'package:kaydi_mobile/core/constants/texts.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  BaseState<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends BaseState<TodoListView> {
  ListsController c = Get.put(ListsController());
  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
        child: K_Appbar(
          AppText: c.theList.value.name,
          action: IconButton(
            splashRadius: 20,
            icon: Icon(Icons.settings),
            onPressed: () {
              RouteManager.normalRoute(
                RouteName.LIST_SETTINGS,
                parameters: {
                  Parameter.LIST: jsonEncode(c.theList.value),
                },
              );
            },
          ),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: monitorDocument(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return SizedBox();
              }
              Future.delayed(Duration.zero, () async {
                handleDataChange(snapshot.data);
              });
              return SizedBox();
            },
          ),
          Obx(
            () => SizedBox(
              child: c.task.length == 0
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: dynamicWidth(0.05)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(),
                            Icon(Icons.rocket_rounded, size: 100),
                            Text(
                              translate(IKey.FINISH_TASK_DESCRIPTION),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.getFont(TextConstants.EmptyListText, fontSize: 16),
                            ),
                            Divider(),
                          ]
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: e,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: c.task.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: Checkbox(
                          activeColor: const Color.fromARGB(255, 18, 84, 110),
                          value: c.task[index].isChecked,
                          onChanged: (bool? value) {
                            checkTask(c.theList.value, c.task[index]);
                          },
                        ),
                        onTap: () {
                          showTaskDialog(context, dynamicWidth(0.3), c.task[index], c.theList.value);
                        },
                        onLongPress: () {
                          deleteTaskDialog(context, dynamicWidth(0.3), c.task[index], c.theList.value);
                        },
                        title: Text(
                          c.task[index].task.replaceAll("\n", " "),
                          style: TextStyle(
                            decoration: c.task[index].isChecked ? TextDecoration.lineThrough : null,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          RouteManager.normalRoute(
            RouteName.CREATE_TASK,
            parameters: {
              Parameter.LIST: jsonEncode(c.theList.value),
            },
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
