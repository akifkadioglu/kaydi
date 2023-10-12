import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/Home/controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/app.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/constants/parameters.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  BaseState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  
  

  ListsController c = Get.put(ListsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
        child: K_Appbar(
          AppText: AppConstant.AppName,
        ),
      ),
      body: Obx(
        () => ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: c.list.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(c.list[index].name),
            onTap: () {
              RouteManager.normalRoute(
                RouteName.TODOLIST,
                parameters: {
                  Parameter.ID: c.list[index].id,
                  Parameter.LIST_NAME: c.list[index].name,
                },
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomNavigationBar(
          onTap: route,
          currentIndex: 0,
          backgroundColor: themeData.primaryColor,
          bubbleCurve: Curves.easeIn,
          elevation: 0,
          borderRadius: Radius.circular(30),
          isFloating: true,
          items: [
            CustomNavigationBarItem(
              icon: Icon(
                MdiIcons.home,
                color: Color.fromARGB(255, 40, 194, 255),
              ),
            ),
            CustomNavigationBarItem(
              icon: Icon(MdiIcons.creationOutline),
            ),
            CustomNavigationBarItem(
              icon: Icon(MdiIcons.account),
            ),
          ],
        ),
      ),
    );
  }
}
