import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  BaseState<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends BaseState<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: K_Appbar(
          AppText: translate(IKey.PROFILE),
          action: IconButton(
            splashRadius: 20,
            onPressed: () {
              showFlexibleBottomSheet(
                minHeight: 0,
                initHeight: 0.4,
                maxHeight: 0.4,
                isSafeArea: true,
                context: context,
                builder: buildBottomSheet,
                isExpand: false,
              );
            },
            icon: Icon(
              MdiIcons.translate,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: dynamicWidth(0.05), vertical: 20),
          child: Column(
            children: [
              TextFormField(
                initialValue: 'akif.kadioglu.28@gmail.com',
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  helperText: translate(IKey.EMAIL),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Divider(),
              TextFormField(
                initialValue: 'akif',
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  helperText: translate(IKey.NAME),
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text(translate(IKey.LIST_REQUESTS)),
                trailing: Switch(
                  activeColor: Color.fromARGB(255, 40, 194, 255),
                  value: true,
                  onChanged: (value) {},
                ),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(MdiIcons.logout),
                title: Text(translate(IKey.LOGOUT)),
                onTap: () {
                  RouteManager.goRouteAndRemoveBefore(RouteName.LOGIN);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
