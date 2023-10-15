import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaydi_mobile/core/base/view.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/routes/route_names.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (auth.currentUser != null) {
        RouteManager.goRouteAndRemoveBefore(RouteName.HOME);
      } else {
        RouteManager.goRouteAndRemoveBefore(RouteName.LOGIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(builder: (context) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
