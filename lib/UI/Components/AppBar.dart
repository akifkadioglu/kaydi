import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kaydi_mobile/core/constants/texts.dart';

class K_Appbar extends StatelessWidget {
  const K_Appbar({super.key, required this.AppText, this.action});
  final String AppText;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        AppText,
        style: GoogleFonts.getFont(TextConstants.AppbarText),
      ),
      backgroundColor: Colors.transparent,
      actions: [
        action ?? SizedBox(),
      ],
    );
  }
}
