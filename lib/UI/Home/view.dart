import 'dart:convert';

import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kaydi_mobile/UI/Home/controller.dart';
import 'package:kaydi_mobile/UI/Home/view_controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/base/view.dart';
import 'package:kaydi_mobile/core/constants/app.dart';
import 'package:kaydi_mobile/core/constants/parameters.dart';
import 'package:kaydi_mobile/core/constants/texts.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  HomeViewController homeViewController = Get.put(HomeViewController());
  @override
  void initState() {
    super.initState();
    getCloud();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppConstant.AppName,
          style: GoogleFonts.getFont(TextConstants.AppbarText,
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        actions: [
          auth.currentUser != null
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Icon(
                    MdiIcons.circleSmall,
                    color: Colors.lightBlueAccent,
                  ),
                )
              : SizedBox()
        ],
      ),
      body: BaseView(builder: (context) {
        return Obx(
          () => ListView(
            physics: BouncingScrollPhysics(),
            children: [
              homeViewController.isLoading.value ? LinearProgressIndicator() : SizedBox(),
              SizedBox(
                child: c.list.length == 0
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: dynamicWidth(0.05)),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Divider(),
                              Icon(Icons.task_alt_rounded, size: 100),
                              Text(
                                translate(IKey.FINISH_LIST_DESCRIPTION),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(TextConstants.EmptyListText, fontSize: 16),
                              ),
                              Divider(),
                            ]
                                .map(
                                  (e) => Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: e,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: c.list.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future: loadBannerAd(),
                            builder: (context, snapshot) {
                              print(snapshot.data);
                              return Column(
                                children: [
                                  if (index % 3 == 0 && snapshot.data != null)
                                    Container(
                                      decoration: BoxDecoration(color: themeData.cardColor),
                                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                                      child: SizedBox(
                                        height: snapshot.data.size.height.toDouble(),
                                        width: snapshot.data.size.width.toDouble(),
                                        child: AdWidget(
                                          ad: snapshot.data,
                                        ),
                                      ),
                                    ),
                                  ListTile(
                                    trailing: c.list[index].inCloud ? Icon(Icons.cloud_outlined) : null,
                                    title: Text(c.list[index].name),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: themeData.cardColor, width: 0.2),
                                    ),
                                    onTap: () {
                                      RouteManager.normalRoute(
                                        RouteName.TODOLIST,
                                        parameters: {
                                          Parameter.LIST: json.encode(c.list[index]),
                                        },
                                      );
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox();
                        },
                      ),
              ),
            ],
          ),
        );
      }),
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
              icon: Icon(MdiIcons.plus),
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
