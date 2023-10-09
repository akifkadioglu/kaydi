import 'package:flutter/material.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ThemeData get themeData => Theme.of(context);
  double dynamicHeight(double value) => MediaQuery.of(context).size.height * value;
  double dynamicWidth(double value) => MediaQuery.of(context).size.width * value;

  Widget buildBottomSheet(
    BuildContext context,
    ScrollController scrollController,
    double bottomSheetOffset,
  ) {
    return Material(
      child: Container(
        child: SingleChildScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.translate),
                  ],
                ),
              ),
              ListTile(
                title: Text('English'),
                subtitle: Text(translate(IKey.ENGLISH)),
                onTap: () {
                  RouteManager.back();
                  ChangeLanguage(Languages.ENGLISH);
                },
              ),
              ListTile(
                title: Text('Türkçe'),
                subtitle: Text(translate(IKey.TURKISH)),
                onTap: () {
                  RouteManager.back();
                  ChangeLanguage(Languages.TURKISH);
                },
              ),
              SizedBox(
                height: dynamicHeight(0.15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
