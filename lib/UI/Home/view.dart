import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Components/AppBar.dart';
import 'package:kaydi_mobile/UI/Home/controller.dart';
import 'package:kaydi_mobile/UI/Home/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/app.dart';
import 'package:kaydi_mobile/core/constants/components.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  BaseState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> {
  HomeViewController c = Get.put(HomeViewController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ComponentsConstants.AppbarHeight),
        child: K_Appbar(
          AppText: AppConstant.AppName,
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 15,
        itemBuilder: (context, index) => ListTile(
          title: Text(index.toString()),
          onTap: () {
            RouteManager.normalRoute(
              RouteName.TODOLIST,
              parameters: {
                "id": index.toString(),
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Obx(() => Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomNavigationBar(
              currentIndex: c.selectedIndex.value,
              onTap: route,
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
          )),
    );
  }
}
