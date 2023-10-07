import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/core/base/state.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  BaseState<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends BaseState<TodoListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Get.parameters.toString()),
      ),
    );
  }
}
