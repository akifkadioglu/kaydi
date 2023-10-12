import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/Components/cancel_create_bottom_bar.dart';
import 'package:kaydi_mobile/UI/CreateList/controller.dart';
import 'package:kaydi_mobile/UI/CreateList/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';

class CreateListView extends StatefulWidget {
  const CreateListView({super.key});

  @override
  BaseState<CreateListView> createState() => _CreateListViewState();
}

class _CreateListViewState extends BaseState<CreateListView> {
  CreateListViewController c = Get.put(CreateListViewController());
  static const int TitleMaxLength = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
        child: K_Appbar(
          AppText: translate(IKey.NEW_LIST),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () {
              return Column(
                children: [
                  TextField(
                    autofocus: true,
                    keyboardType: TextInputType.name,
                    maxLength: TitleMaxLength,
                    textInputAction: TextInputAction.done,
                    smartDashesType: SmartDashesType.enabled,
                    onChanged: c.setListName,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      helperMaxLines: 2,
                      filled: true,
                      isDense: true,
                      hintText: translate(IKey.TITLE_OF_LIST),
                      helperText: translate(IKey.TITLE_OF_LIST_DESCRIPTION),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      counter: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: c.listName.value.length < TitleMaxLength ? null : Colors.amber,
                          strokeWidth: 2,
                          value: (1 / TitleMaxLength) * c.listName.value.length,
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
        createFunc: () => createList(c.listName.value),
      ),
    );
  }
}
