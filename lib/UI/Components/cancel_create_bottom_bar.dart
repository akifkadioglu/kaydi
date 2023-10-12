import 'package:flutter/material.dart';
import 'package:kaydi_mobile/core/base/state.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';

class CancelCreateBottomBar extends StatefulWidget {
  const CancelCreateBottomBar({super.key, required this.createFunc});
  final VoidCallback createFunc;
  @override
  BaseState<CancelCreateBottomBar> createState() => _CancelCreateBottomBarState();
}

class _CancelCreateBottomBarState extends BaseState<CancelCreateBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: dynamicWidth(0.45),
            child: FilledButton(
              style: FilledButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                RouteManager.back();
              },
              child: Text(
                translate(IKey.CANCEL),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            width: dynamicWidth(0.45),
            child: FilledButton(
              style: FilledButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              onPressed: () {
                widget.createFunc();
                RouteManager.back();
              },
              child: Text(
                translate(IKey.CREATE),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
