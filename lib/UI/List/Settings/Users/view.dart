import 'package:flutter/material.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/base/view.dart';

class ListUsersView extends StatefulWidget {
  const ListUsersView({super.key});

  @override
  BaseState<ListUsersView> createState() => _ListUsersViewState();
}

class _ListUsersViewState extends BaseState<ListUsersView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(builder: (context) {
      return Scaffold(
        body: ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index) {
            return ListTile();
          },
        ),
      );
    });
  }
}
