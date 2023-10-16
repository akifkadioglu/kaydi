import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/Components/cancel_create_bottom_bar.dart';
import 'package:kaydi_mobile/UI/List/CreateTask/controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/constants/parameters.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  BaseState<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends BaseState<CreateTaskView> {
  static const int TitleMaxLength = 1500;
  ListsController c = Get.put(ListsController());

  @override
  void initState() {
    super.initState();
    c.theList.value = ListElement.fromJson(jsonDecode(Get.parameters[Parameter.LIST].toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
        child: K_Appbar(
          AppText: c.theList.value.name,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () {
              return Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    maxLength: TitleMaxLength,
                    textInputAction: TextInputAction.newline,
                    onChanged: c.setTaskName,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      isDense: true,
                      helperMaxLines: 2,
                      filled: true,
                      hintText: translate(IKey.NEW_TASK),
                      helperText: translate(IKey.NEW_TASK_DESCRIPTION),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      counter: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: c.taskName.value.length < TitleMaxLength ? null : Colors.amber,
                          strokeWidth: 2,
                          value: (1 / TitleMaxLength) * c.taskName.value.length,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomSheet: CancelCreateBottomBar(
        createFunc: () {
          createTask(c.taskName.value, c.theList.value);
        },
      ),
    );
  }
}
