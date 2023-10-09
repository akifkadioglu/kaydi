import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/constants/texts.dart';

class K_Appbar extends StatefulWidget {
  const K_Appbar({super.key, required this.AppText, this.action});
  final String AppText;
  final Widget? action;

  @override
  BaseState<K_Appbar> createState() => _K_AppbarState();
}

class _K_AppbarState extends BaseState<K_Appbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.AppText,
        style: GoogleFonts.getFont(TextConstants.AppbarText),
      ),
      backgroundColor: Colors.transparent,
      actions: [
        widget.action ?? SizedBox(),
      ],
    );
  }
}
