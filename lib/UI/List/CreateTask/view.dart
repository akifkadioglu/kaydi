import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/List/CreateTask/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/constants/parameters.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';

class CreateTaskView extends StatefulWidget {
  const CreateTaskView({super.key});

  @override
  BaseState<CreateTaskView> createState() => _CreateTaskViewState();
}

class _CreateTaskViewState extends BaseState<CreateTaskView> {
  static const int TitleMaxLength = 500;
  CreateTaskViewController c = Get.put(CreateTaskViewController());
  String id = '';
  @override
  void initState() {
    super.initState();
    id = Get.parameters[Parameter.ID].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
        child: K_Appbar(
          AppText: id,
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
                    keyboardType: TextInputType.name,
                    maxLength: TitleMaxLength,
                    textInputAction: TextInputAction.newline,
                    smartDashesType: SmartDashesType.enabled,
                    onChanged: c.setTaskName,
                    maxLines: 5,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      isDense: true,
                      helperMaxLines: 2,
                      filled: true,
                      hintText: 'Yeni Görev',
                      helperText: id +
                          '\'e yeni görev ekliyorsunuz. Bu işlemden sonra bu listedeki herkese bildirim gidecektir.',
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
      bottomSheet: BottomAppBar(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: dynamicWidth(0.45),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  RouteManager.back();
                },
                child: Text(
                  'İptal',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              width: dynamicWidth(0.45),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  foregroundColor: Colors.white,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {},
                child: Text(
                  'Oluştur',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
