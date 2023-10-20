import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kaydi_mobile/UI/Account/controller.dart';
import 'package:kaydi_mobile/UI/Account/view_controller.dart';
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
  final FirebaseAuth auth = FirebaseAuth.instance;
  AccountViewController c = Get.put(AccountViewController());
  @override
  void initState() {
    isAllowRequest(auth.currentUser!.uid);
    super.initState();
  }

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
              auth.currentUser != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CircleAvatar(
                        radius: 50.0,
                        child: CachedNetworkImage(
                          imageUrl: auth.currentUser!.photoURL!,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(Icons.person),
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  : SizedBox(),
              TextFormField(
                initialValue: auth.currentUser?.email ?? '',
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
                initialValue: auth.currentUser?.displayName ?? '',
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
              Obx(
                () => ListTile(
                  title: Text(translate(IKey.LIST_REQUESTS)),
                  subtitle: Text(translate(IKey.LIST_REQUESTS_DESCRIPTION)),
                  trailing: c.isLoading.isFalse
                      ? Switch(
                          activeColor: Color.fromARGB(255, 40, 194, 255),
                          value: c.isAllow.value,
                          onChanged: (value) {
                            switchAllow();
                          },
                        )
                      : null,
                  onTap: () {
                    switchAllow();
                  },
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(MdiIcons.logout),
                title: Text(translate(IKey.LOGOUT)),
                onTap: () async {
                  await GoogleSignIn().disconnect();
                  await FirebaseAuth.instance.signOut();
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
