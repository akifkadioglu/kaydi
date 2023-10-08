import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/List/Settings/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoListSettingsView extends StatefulWidget {
  const TodoListSettingsView({super.key});

  @override
  BaseState<TodoListSettingsView> createState() => _TodoListSettingsView();
}

class _TodoListSettingsView extends BaseState<TodoListSettingsView> {
  String id = '';
  TodoListSettingsViewController c = Get.put(TodoListSettingsViewController());

  @override
  void initState() {
    super.initState();
    id = Get.parameters['id'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: K_Appbar(
          AppText: id,
        ),
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dynamicWidth(0.05), vertical: 20),
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.name,
                readOnly: true,
                onTap: () {
                  RouteManager.normalRoute(
                    RouteName.LIST_SEARCH,
                    parameters: {'id': id},
                  );
                },
                decoration: InputDecoration(
                  isDense: true,
                  helperMaxLines: 2,
                  filled: true,
                  hintText: 'Kişi ekle',
                  helperText: 'Listeye eklemek istediğiniz kişinin E-mail adresini aratın.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Bildirimler'),
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
                  title: Text('Buluta Taşı'),
                  onTap: () {
                    c.setLoading;
                  },
                  subtitle: Text(
                    'Listenizi buluta taşıyarak istediğiniz kişileri listenize ekleyebilirsiniz.',
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
                title: Text('Ayrıl'),
                onTap: () {
                  RouteManager.goRouteAndRemoveBefore(RouteName.HOME);
                },
                subtitle: Text(
                  'Listedeki kullanıcılara bildirim gidecektir.',
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
