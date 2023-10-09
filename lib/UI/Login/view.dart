import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaydi_mobile/UI/Login/controller.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  BaseState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInToLinear,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: () {
              showFlexibleBottomSheet(
                minHeight: 0,
                initHeight: 0.4,
                maxHeight: 0.4,
                isSafeArea: true,
                context: context,
                builder: _buildBottomSheet,
                isExpand: false,
              );
            },
            icon: Icon(
              MdiIcons.translate,
            ),
          ),
        ],
      ),
      body: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(0, 0.1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut,
          ),
        ),
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: dynamicHeight(0.05),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      WelcomeText(),
                      continueWithGoogle(),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: loginWithGoogle,
                  child: Text(
                    translate(IKey.CONTINUE_OFFLINE),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  SlideTransition WelcomeText() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, 0.5),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      ),
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: dynamicWidth(0.1),
            vertical: dynamicHeight(0.05),
          ),
          child: Text(
            translate(IKey.WELCOME_TO_KAYDI),
            style: GoogleFonts.unbounded(fontSize: 30),
          ),
        ),
      ),
    );
  }

  SizedBox continueWithGoogle() {
    return SizedBox(
      height: 60,
      width: dynamicWidth(0.8),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          side: BorderSide(
            color: themeData.dividerColor,
          ),
        ),
        icon: Icon(MdiIcons.google),
        label: Text(
          translate(IKey.CONTINUE_WITH_GOOGLE),
          style: GoogleFonts.ptSans(),
        ),
        onPressed: loginWithGoogle,
      ),
    );
  }

  Widget _buildBottomSheet(
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
