import 'package:flutter/material.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
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
          AppText: 'Profile',
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
                  helperText: 'E-mail',
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
                  helperText: 'Name',
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Liste istekleri'),
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
                title: Text('Çıkış Yap'),
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
