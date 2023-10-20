import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/List/Settings/Search/controller.dart';
import 'package:kaydi_mobile/UI/List/Settings/Search/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/toast/manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoListSearchView extends StatefulWidget {
  const TodoListSearchView({super.key});

  @override
  BaseState<TodoListSearchView> createState() => _TodoListSearchViewState();
}

class _TodoListSearchViewState extends BaseState<TodoListSearchView> {
  ListsController listsController = Get.put(ListsController());
  TodoListSearchViewController c = Get.put(TodoListSearchViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SizedBox(
          height: 40,
          width: dynamicWidth(1),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (mail) {
              searchEmail(mail);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              filled: true,
              hintText: translate(IKey.SEARCH_EMAIL),
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => ListView(
          physics: BouncingScrollPhysics(),
          children: [
            c.isLoading.value ? LinearProgressIndicator() : SizedBox(),
            c.users.length == 0
                ? Column(
                    children: [
                      Text(
                        "🥺",
                        style: TextStyle(fontSize: 60),
                      ),
                      Text(
                        "👉🏻👈🏻",
                        style: TextStyle(fontSize: 30),
                      ),
                    ],
                  )
                : SizedBox(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: c.users.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(c.users[index].photoUrl),
                  backgroundColor: Colors.transparent,
                ),
                onTap: listsController.theListUserIds.contains(c.users[index].id)
                    ? () {
                        ToastManager.toast(translate(IKey.ALREADY_ADDED_TO_LIST));
                      }
                    : () {
                        addUserDialog(context, dynamicWidth(0.3), c.users[index]);
                      },
                trailing:
                    listsController.theListUserIds.contains(c.users[index].id) ? Icon(MdiIcons.circleSmall) : null,
                title: Text(c.users[index].name),
                subtitle: Text(c.users[index].email),
                isThreeLine: false,
                subtitleTextStyle: TextStyle(overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
