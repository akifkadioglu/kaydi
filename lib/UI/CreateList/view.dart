import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/CreateList/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';

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
          AppText: 'New List',
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
                    onChanged: c.setCounter,
                    decoration: InputDecoration(
                      helperMaxLines: 2,
                      filled: true,
                      hintText: 'Listenin Başlığı',
                      helperText: 'Listenin Başlığı zorunlu bir alandır ve katılımcılar bu başlığı görür.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      counter: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: c.counter.value.length < TitleMaxLength ? null : Colors.amber,
                          strokeWidth: 2,
                          value: (1 / TitleMaxLength) * c.counter.value.length,
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
