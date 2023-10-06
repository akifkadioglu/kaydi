import 'package:flutter/material.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/Login/controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/app.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  BaseState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
        child: K_Appbar(
          AppText: AppConstant.AppName,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login with..'),
            Divider(
              endIndent: dynamicWidth(0.1),
              indent: dynamicWidth(0.1),
            ),
            IconButton(
              icon: Icon(MdiIcons.google),
              onPressed: loginWithGoogle,
              style: FilledButton.styleFrom(
                backgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ]
              .map(
                (e) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
